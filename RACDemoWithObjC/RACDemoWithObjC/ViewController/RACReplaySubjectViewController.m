//
//  RACReplaySubjectViewController.m
//  RACDemoWithObjC
//
//  Created by lizelu on 2017/11/30.
//  Copyright © 2017年 lizelu. All rights reserved.
//

#import "RACReplaySubjectViewController.h"

@interface RACReplaySubjectViewController ()

@property (strong, nonatomic) IBOutlet UITextView *logTextView;
@property (strong, nonatomic) RACReplaySubject *replaySubject;
@property (strong, nonatomic) dispatch_queue_t serialQueue;

@property (assign, nonatomic) NSUInteger subscriberCount;

@end

@implementation RACReplaySubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"RACReplaySubject";
    
    self.subscriberCount = 0;
    self.serialQueue = dispatch_queue_create("com.zeluli.serial", DISPATCH_QUEUE_SERIAL);
    
    self.replaySubject = [RACReplaySubject subject];
    
    [self.replaySubject sendNext:@"AA"];
    [self.replaySubject sendNext:@"BB"];
    [self.replaySubject sendNext:@"CC"];
}

//每次点击都会添加一个新的监听者
- (IBAction)tapSubscriberButton:(id)sender {
    [self showLog:[NSString stringWithFormat:@"\\n共%lu个监听者", ++self.subscriberCount]];
    
    dispatch_async(self.serialQueue, ^{
        @weakify(self)
        [self.replaySubject subscribeNext:^(id value) {
            @strongify(self)
            [self showLog:[NSString stringWithFormat:@"%@", value]];
        }];
        
        [self showLog:@"\\n"];
    });
    
}

//每次点击都会发出一个新的值
- (IBAction)tapSendNextButton:(id)sender {
    
    dispatch_async(self.serialQueue, ^{
        [self.replaySubject sendNext:@(arc4random()%100)];
        [self showLog:@"\\n"];
    });
    
}

- (void)showLog:(NSString *)log {
    dispatch_async(dispatch_get_main_queue(), ^{
        [ShowLogUtile showLog:self.logTextView log:log];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
