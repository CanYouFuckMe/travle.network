//
//  ErrorModel.h
//  travel.network
//
//  Created by design-mac1 on 2018/8/28.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorModel : NSObject

@property (assign,nonatomic)NSUInteger code;
@property (strong,nonatomic) NSString *Message;


@end
