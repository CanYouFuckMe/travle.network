//
//  NetworkErrorParser.m
//  JedAuto
//
//  Created by Sven on 2017/11/30.
//  Copyright © 2017年 Sven. All rights reserved.
//

#import "JANetworkErrorParser.h"

@implementation JANetworkErrorParser

+ (NSString *)getErrorMessageWithErrorCode:(NSString *)errorCode {
    NSInteger errorCodeNum = [errorCode integerValue];
    NSString *errorMessage = nil;
    switch (errorCodeNum) {
        case 0:
            errorMessage = @"请求成功";
            break;
            
        default:
            break;
    }
    return errorMessage;
}

@end
