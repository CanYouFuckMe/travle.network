//
//  travel_networkTests.m
//  travel.networkTests
//
//  Created by design-mac1 on 2018/8/27.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface travel_networkTests : XCTestCase

@end

@implementation travel_networkTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    NSLog(@"自定义测试testExample");
    int a = 3;
    XCTAsserTrue(a == 0,"a 不等于0");
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
