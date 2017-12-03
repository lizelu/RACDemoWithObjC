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
        
        NSArray *signals = @[RACObserve(self, userName),
                             RACObserve(self, password),
                             RACObserve(self, authCode)];
        self.loginButtonEnableSignal =
        [RACSignal combineLatest:signals reduce:^(NSString *userName,
                                                  NSString *password,
                                                  NSString *authCode) {
            return @(userName.length > 0 && password.length > 0 && authCode.length > 0);
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
        self.log = @"正在登陆";
        [subscriber sendNext:[NSString stringWithFormat:@"USER: %@, PWD: %@, AUTH: %@", self.userName, self.password, self.authCode]];
        
        [self.loginRequest request:^(NSString *value) {     //发起网络请求
            self.log = @"登陆成功";
            [subscriber sendNext:value];
            [subscriber sendNext:@"\\n"];
            [subscriber sendCompleted];
        }];
    }];
}


@end
