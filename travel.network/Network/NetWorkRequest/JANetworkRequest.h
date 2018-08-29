//
//  SVNetworkRequest.h
//  JedAuto
//
//  Created by Sven on 2017/11/20.
//  Copyright © 2017年 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorModel.h"

typedef void (^HttpRequestSuccess)(ErrorModel * _Nonnull errorModel, NSArray * _Nullable modelArray);
typedef void (^HttpRequestFailure)(NSError * _Nonnull error);
typedef void (^DownloadCompletionHandler)(NSURL * _Nullable filePath, NSError * _Nullable error);
typedef void (^HttpProgress)(NSProgress * _Nullable progress);

typedef NS_ENUM(NSInteger, SVRequestMethod) {
    SVRequestMethodGet  = 1,
    SVRequestMethodPost = 2,
};

NS_ASSUME_NONNULL_BEGIN

@protocol JANetworkRequestDelegate<NSObject>

- (void)requestDidStart:(NSDictionary *)URLConfigInfo;
- (void)requestDidFinish:(NSDictionary *)URLConfigInfo json:(id)json;
- (void)requestDidFail:(NSDictionary *)URLConfigInfo error:(NSError *)error;

@end

@interface JANetworkRequest : NSObject

@property (weak, nonatomic) id<JANetworkRequestDelegate> delegate;

+ (instancetype)shared;

- (void)getRequestWithURLConfig:(NSDictionary *)URLConfig parameters:(_Nullable id)paramaters success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;
- (void)postRequestWithURLConfig:(NSDictionary *)URLConfig parameters:(_Nullable id)paramaters success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;


/**
 下载
 
 @param URL 下载URL
 @param fileDir 下载文件存放目录名
 */
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(HttpProgress)progress
                              success:(void(^)(NSString *))success
                              failure:(HttpRequestFailure)failure;


/**
 上传单个文件

 @param URL 上传URL
 @param name 上传文件名
 @param filePath 上传文件路径
 */
+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                             parameters:(id)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                               progress:(HttpProgress)progress
                                success:(HttpRequestSuccess)success
                                failure:(HttpRequestFailure)failure;

//上传多张图片
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(HttpProgress)progress
                                  success:(HttpRequestSuccess)success
                                  failure:(HttpRequestFailure)failure;



- (void)changeBaseURLToDebug;
- (void)changeBaseURLToRelease;

- (void)cancelAllRequest;
- (void)cancelAllDataRequest;
- (void)cancelAllUploadRequest;
- (void)cancelAllDownloadRequest;

NS_ASSUME_NONNULL_END
@end
