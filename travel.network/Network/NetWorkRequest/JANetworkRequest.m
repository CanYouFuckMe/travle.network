//
//  SVNetworkRequest.m
//  JedAuto
//
//  Created by Sven on 2017/11/20.
//  Copyright © 2017年 Sven. All rights reserved.
//

#import "JANetworkRequest.h"
#import "JANetworkManager.h"
#import "JADataParser.h"

@implementation JANetworkRequest
+ (instancetype)shared {
    static JANetworkRequest *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc]init];
    });
    
    return shared;
}

- (void)getRequestWithURLConfig:(NSDictionary *)URLConfig parameters:(_Nullable id)paramaters success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    [self sendRequestWithURLConfig:URLConfig method:SVRequestMethodGet parameters:paramaters success:success failure:failure];
}

- (void)postRequestWithURLConfig:(NSDictionary *)URLConfig parameters:(_Nullable id)paramaters success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    [self sendRequestWithURLConfig:URLConfig method:SVRequestMethodPost parameters:paramaters success:success failure:failure];
}

- (void)sendRequestWithURLConfig:(NSDictionary *)URLConfig method:(SVRequestMethod)method parameters:(id)paramaters success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    
    JANetworkManager *manager = [JANetworkManager defaultManager];
    NSString *urlPath = URLConfig[URLPath];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",manager.baseURL.absoluteString,urlPath];
    JALog(@"-------- URL --------\n%@\n----- Parameters -----\n%@\n-----------------------",urlString,[paramaters jsonPrettyStringEncoded]);

    [self.delegate requestDidStart:URLConfig];
    switch (method) {
        case SVRequestMethodGet:
        {
            [manager GET:urlPath parameters:paramaters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self parserResponse:responseObject withURLConfig:URLConfig success:success];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
                [self.delegate requestDidFail:URLConfig error:error];
                JALog(@"!!!Request Failure:%@",error.description);
            }];
            
        }
            break;
        case SVRequestMethodPost:
        {
            [manager POST:urlPath parameters:paramaters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self parserResponse:responseObject withURLConfig:URLConfig success:success];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
                [self.delegate requestDidFail:URLConfig error:error];
                JALog(@"!!!Request Failure:%@",error.description);
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)parserResponse:(id  _Nullable)responseObject withURLConfig:(NSDictionary *)URLConfig success:(HttpRequestSuccess)success {
    ErrorModel *errorModel = [JADataParser getErrorInfoWithResponseObject:responseObject];
    NSArray *modelArray = [JADataParser getModelArrayWithResponseObject:responseObject URLConfig:URLConfig];
    success(errorModel, modelArray);
    [self.delegate requestDidFinish:URLConfig json:responseObject];
    JALog(@"------ Response ------\n%@",[responseObject jsonPrettyStringEncoded]);
}

+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                             parameters:(id)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                               progress:(HttpProgress)progress
                                success:(HttpRequestSuccess)success
                                failure:(HttpRequestFailure)failure {
    
    JANetworkManager *manager = [JANetworkManager defaultManager];
    NSURLSessionTask *sessionTask = [manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSError *error = nil;
        [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:name error:&error];
        !(failure && error) ?: failure(error);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async_on_main_queue(^{
            !progress ?: progress(uploadProgress);
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ErrorModel *errorModel = [[ErrorModel alloc]init];
        errorModel.code = 0;
        !success ?: success(errorModel,responseObject);
        JALog(@"uploadSuccess: %@",[responseObject jsonPrettyStringEncoded]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ?: failure(error);
        JALog(@"uploadError: %@",error);
    }];
    return sessionTask;
}

#pragma mark - 上传多张图片
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(HttpProgress)progress
                                  success:(HttpRequestSuccess)success
                                  failure:(HttpRequestFailure)failure {
    
    JANetworkManager *manager = [JANetworkManager defaultManager];
    NSURLSessionTask *sessionTask = [manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSUInteger i = 0; i < images.count; i++) {
            NSString *imageFileName = nil;
            if (fileNames) {
                imageFileName = [NSString stringWithFormat:@"%@.%@" ,fileNames[i] ,imageType ?: @"jpg"];
            } else {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                NSString *dateStr = [formatter stringFromDate:[NSDate date]];
                imageFileName = [NSString stringWithFormat:@"%@%ld.%@", dateStr, i, imageType ?: @"jpg"];
            }
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:imageFileName
                                    mimeType:[NSString stringWithFormat:@"image/%@",imageType ?: @"jpg"]];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async_on_main_queue(^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ErrorModel *errorModel = [[ErrorModel alloc]init];
        errorModel.code = 0;
        success ? success(errorModel, responseObject) : nil;
        JALog(@"uploadSuccess: %@",[responseObject jsonPrettyStringEncoded]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
        JALog(@"uploadError: %@",error);
    }];
    
    return sessionTask;
}

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(HttpProgress)progress
                              success:(void(^)(NSString *))success
                              failure:(HttpRequestFailure)failure {
    
    JANetworkManager *manager = [JANetworkManager defaultManager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        dispatch_async_on_main_queue(^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                failure(error);
            }
            JALog(@"downloadError: %@",error);
        } else {
            !success ?: success(filePath.absoluteString);
            JALog(@"downloadSuccess, FilePath: %@", filePath.absoluteString);
        }
    }];
    [downloadTask resume];
    
    return downloadTask;
}


- (void)cancelAllRequest {
    [[JANetworkManager defaultManager].tasks makeObjectsPerformSelector:@selector(cancel)];
}

- (void)cancelAllDataRequest {
    [[JANetworkManager defaultManager].dataTasks makeObjectsPerformSelector:@selector(cancel)];
}

- (void)cancelAllUploadRequest {
    [[JANetworkManager defaultManager].uploadTasks makeObjectsPerformSelector:@selector(cancel)];
}

- (void)cancelAllDownloadRequest {
    [[JANetworkManager defaultManager].downloadTasks makeObjectsPerformSelector:@selector(cancel)];
}

- (void)changeBaseURLToDebug {
    [JANetworkManager changeBaseURLToDebug:YES];
    JALog(@"切换测试服务器成功！");
}

- (void)changeBaseURLToRelease {
    [JANetworkManager changeBaseURLToDebug:NO];
    JALog(@"切换正式服务器成功！");
}

@end
