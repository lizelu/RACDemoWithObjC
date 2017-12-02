//
//  LoginRequest.m
//  RACDemoWithObjC
//
//  Created by lizelu on 2017/12/1.
//  Copyright © 2017年 lizelu. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest

-(void)request:(void(^)(NSString *value))finish {
    dispatch_async(dispatch_queue_create("com.zeluli.concurrent", DISPATCH_QUEUE_CONCURRENT), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            finish(@"login success!");
        });
    });
}

@end
