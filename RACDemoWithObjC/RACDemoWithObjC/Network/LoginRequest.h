//
//  LoginRequest.h
//  RACDemoWithObjC
//
//  Created by lizelu on 2017/12/1.
//  Copyright © 2017年 lizelu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginRequest.h"

@interface LoginRequest : NSObject

-(void)request:(void(^)(NSString *value))finish;

@end
