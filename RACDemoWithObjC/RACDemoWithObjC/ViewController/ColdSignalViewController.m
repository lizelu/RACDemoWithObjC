//
//  ColdSignalViewController.m
//  RACDemoWithObjC
//
//  Created by lizelu on 2017/12/2.
//  Copyright © 2017年 lizelu. All rights reserved.
//
// 冷信号的副作用
// Most signals start out "cold," which means that they will not do any work until subscription.

#import "ColdSignalViewController.h"

@interface ColdSignalViewController ()

@property (weak, nonatomic) IBOutlet UIButton *addSubscriberButton;
@property (weak, nonatomic) IBOutlet UITextView *logTextView;

@end

@implementation ColdSignalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __block unsigned subscriptions = 0;
    
    //每次对下方信号进行订阅，都会执行尾随闭包
    //For a cold signal, side effects will be performed once per subscription
    //This behavior can be changed using a connection.
    
    RACSignal *loggingSignal = [RACSignal createSignal:^ RACDisposable * (id<RACSubscriber> subscriber) {
        subscriptions++;
        [subscriber sendNext:@(subscriptions)];
        [subscriber sendCompleted];
        return nil;
    }];

    @weakify(self)
    [[self.addSubscriberButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [loggingSignal subscribeCompleted:^{
            [self showLog:[NSString stringWithFormat:@"subscribeCompleted: 添加订阅者 %u", subscriptions]];
        }];
        
        [loggingSignal subscribeNext:^(id x) {
            [self showLog:[NSString stringWithFormat:@"subscribeNext: 添加订阅者 %@", x]];
        }];
    }];
    
    
}

- (void)showLog:(NSString *)log {
    [ShowLogUtile showLog:self.logTextView log:log];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
