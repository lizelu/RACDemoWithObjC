//
//  RACAndFPSViewController.m
//  RACDemoWithObjC
//
//  Created by lizelu on 2017/12/16.
//  Copyright © 2017年 lizelu. All rights reserved.
//

#import "RACAndFPSViewController.h"

@interface RACAndFPSViewController ()

@property (weak, nonatomic) IBOutlet UITextView *logTextView;
@property (weak, nonatomic) IBOutlet UILabel *signalLengthLabel;
@property (assign, nonatomic) NSUInteger signalLength;

@end

@implementation RACAndFPSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signalLength = 5;
}
- (IBAction)tapStep:(UIStepper *)sender {
    self.signalLength = sender.value;
    self.signalLengthLabel.text = [NSString stringWithFormat:@"%lu", self.signalLength];
    
}

- (void)createSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"a"];
        return nil;
    }];

    
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970] * 1000;
    for (int i = 0; i < self.signalLength; i++) {
        signal = [signal map:^id(id value) {
            [NSThread sleepForTimeInterval:0.0005]; //模拟一些操作的耗时，设置为0.5ms
            return [NSString stringWithFormat:@"%@,%d",value, i];
        }];
    }
    
    [signal subscribeNext:^(NSString *x) {
        [self showLog:x];
    }];
    
    NSTimeInterval endIntervel = [[NSDate date] timeIntervalSince1970] * 1000 - startTime;
    [self showLog:[NSString stringWithFormat:@"信号链长度为%lu时的耗时%f", self.signalLength, endIntervel]];
    
    [self showLog:@""];
}
- (IBAction)tapActionButton:(id)sender {
    [self createSignal];
}


- (void)showLog:(NSString *)log {
    [ShowLogUtile showLog:self.logTextView log:log];
}

-(void)dealloc
{
    NSLog(@"释放");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
