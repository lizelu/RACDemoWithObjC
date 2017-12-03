//
//  RACSubjectViewController.m
//  RACDemoWithObjC
//
//  Created by lizelu on 2017/12/3.
//  Copyright © 2017年 lizelu. All rights reserved.
//

#import "RACSubjectViewController.h"

@interface RACSubjectViewController ()

@property (weak, nonatomic) IBOutlet UIButton *sendNextButton;
@property (weak, nonatomic) IBOutlet UIButton *subscriberButton;
@property (weak, nonatomic) IBOutlet UITextView *logTextView;
@property (strong, nonatomic) RACSubject *subject;

@end

@implementation RACSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.subject = [RACSubject subject];

    @weakify(self)
    [[self.sendNextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [self.subject sendNext:@"ABCDE"];
        [self showLog:@"\\n"];
    }];
    
    [[self.subscriberButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [self showLog:@"\\n新添加一个监听者"];
        
        @weakify(self)
        [self.subject subscribeNext:^(NSString *value) {
            @strongify(self)
            [self showLog:value];
        }];
    }];
}

- (void)showLog:(NSString *)log {
    dispatch_async(dispatch_get_main_queue(), ^{
        [ShowLogUtile showLog:self.logTextView log:log];
    });
}

- (void)dealloc {
    NSLog(@"释放");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
