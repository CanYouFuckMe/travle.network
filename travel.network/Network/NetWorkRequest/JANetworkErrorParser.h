//
//  NetworkErrorParser.h
//  JedAuto
//
//  Created by Sven on 2017/11/30.
//  Copyright © 2017年 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JANetworkErrorParser : NSObject

+ (NSString *)getErrorMessageWithErrorCode:(NSString *)errorCode;

@end
