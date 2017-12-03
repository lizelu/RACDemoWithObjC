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
@property (weak, nonatomic) IBOutlet UIButton *hotSignalAddSubscriberButton;
@property (weak, nonatomic) IBOutlet UITextView *logTextView;

@end

@implementation ColdSignalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __block unsigned subscriptions = 0;
    
    //cold signal
    //每次对下方信号进行订阅，都会执行尾随闭包
    //For a cold signal, side effects will be performed once per subscription
    //This behavior can be changed using a connection.
    RACSignal *loggingSignal = [RACSignal createSignal:^ RACDisposable * (id<RACSubscriber> subscriber) {
        [[RACScheduler mainThreadScheduler] afterDelay:3 schedule:^{
            subscriptions++;
            [subscriber sendNext:@(subscriptions)];
        }];
        return nil;
    }];
    
    
    //转换成hot signal
    RACMulticastConnection *connectioin = [loggingSignal publish];
    [connectioin connect];
    RACSignal *hotSignal = connectioin.signal;
    
    @weakify(self)
    [[self.addSubscriberButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [loggingSignal subscribeNext:^(id x) {
            [self showLog:[NSString stringWithFormat:@"cold siganl subscribeNext: 添加订阅者 %@", x]];
        }];
    }];
    
    [[self.hotSignalAddSubscriberButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [hotSignal subscribeNext:^(id x) {
            [self showLog:[NSString stringWithFormat:@"hot siganl subscribeNext: 添加订阅者 %@", x]];
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
