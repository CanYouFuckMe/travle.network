//
//  JADataParser.h
//  JedAuto
//
//  Created by Sven on 2017/11/30.
//  Copyright © 2017年 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorModel.h"

@interface JADataParser : NSObject

+ (ErrorModel * _Nonnull)getErrorInfoWithResponseObject:(id _Nullable)responseObject;

+ (NSArray * _Nullable)getModelArrayWithResponseObject:(id _Nullable)responseObject URLConfig:(NSDictionary *_Nonnull)URLConfig;

@end
