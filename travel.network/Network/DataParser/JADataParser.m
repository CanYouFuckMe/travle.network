//
//  BaseDataParser.m
//  JedAuto
//
//  Created by Sven on 2017/11/30.
//  Copyright © 2017年 Sven. All rights reserved.
//

#import "JADataParser.h"
#import "JABannerModel.h"
#import "JACarModel.h"
#import "JAServiceCityModel.h"

@implementation JADataParser

+ (ErrorModel *)getErrorInfoWithResponseObject:(id _Nullable)responseObject {
    NSDictionary *responseDic = nil;
    if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
        responseDic = (NSDictionary *)responseObject;
    }
    NSInteger errorCode = -1;
    NSString *errorMessage = responseDic[@"ErrMessage"];
    NSString *errorCodeStr = responseDic[@"errCode"];
    if (errorCodeStr) {
        errorCode = [errorCodeStr integerValue];
    }
    ErrorModel *errorModel = [[ErrorModel alloc]init];
    errorModel.code = errorCode;
    errorModel.message = errorMessage;
    
    return errorModel;
}

+ (NSArray *)getModelArrayWithResponseObject:(id _Nullable)responseObject URLConfig:(NSDictionary *)URLConfig {
    
    NSDictionary *responseDic = nil;
    NSArray *responseArray = nil;
    if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
        responseDic = (NSDictionary *)responseObject;
    } else if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
        responseArray = (NSArray *)responseObject;
    }
    
    NSArray *modelArray = nil;
    if ([URLConfig isEqual:Tel_Login]) {
        
    } else if ([URLConfig isEqual:CHOOSECITY]) {
        modelArray = [NSArray modelArrayWithClass:[JAServiceCityModel class] json:responseDic[@"list"]];
    } else if ([URLConfig isEqual:Home_Banner]) {
        modelArray = [JABannerModel mj_objectArrayWithKeyValuesArray:responseDic[@"list"]];
    } else if ([URLConfig isEqual:Home_Car_List]) {
        modelArray = [JACarModel mj_objectArrayWithKeyValuesArray:responseDic[@"list"]];
    }
    return modelArray;
}

@end
