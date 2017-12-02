//
//  RACCommandViewModel.m
//  RACDemoWithObjC
//
//  Created by lizelu on 2017/12/1.
//  Copyright © 2017年 lizelu. All rights reserved.
//

#import "RACCommandViewModel.h"
#import "LoginRequest.h"

@interface RACCommandViewModel()

@property (nonatomic, strong) LoginRequest *loginRequest;

@end

@implementation RACCommandViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self)
        self.loginRequest = [LoginRequest new];
        //创建登录命令
        self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [self login];
        }];
    }
    return self;
}


/**
 登录操作

 @return 返回的是一个和上述loginCommand命令关联的信号量
 */
- (RACSignal *)login {
    @weakify(self)
    return [RACSignal startLazilyWithScheduler:[RACScheduler mainThreadScheduler] block:^(id<RACSubscriber> subscriber) {
        @strongify(self)
        
        [subscriber sendNext:@"login……"];
        
        [self.loginRequest request:^(NSString *value) {     //发起网络请求
            [subscriber sendNext:value];
            [subscriber sendCompleted];
        }];
    }];
}


@end
