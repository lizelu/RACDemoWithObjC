//
//  SignalSwitchToLatestViewController.m
//  RACDemoWithObjC
//
//  Created by lizelu on 2017/11/30.
//  Copyright © 2017年 lizelu. All rights reserved.
//

#import "SignalSwitchToLatestViewController.h"

@interface SignalSwitchToLatestViewController ()

@property (nonatomic) RACSubject *google;
@property (nonatomic) RACSubject *baidu;
@property (nonatomic) RACSubject *signalOfSignal;

@property (weak, nonatomic) IBOutlet UISwitch *baiduSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *googeSwitch;
@property (weak, nonatomic) IBOutlet UITextView *logTextView;

@end

@implementation SignalSwitchToLatestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"信号开关";
    
    //创建3个自定义信号
    self.google = [RACSubject subject];
    self.baidu = [RACSubject subject];
    self.signalOfSignal = [RACSubject subject];
    
    //获取开关信号
    RACSignal *switchSignal = [self.signalOfSignal switchToLatest];
    
    //对通过开关的信号进行操作
    @weakify(self)
    [[switchSignal  map:^id(NSString * value) {
        return [@"https//www." stringByAppendingFormat:@"%@", value];
    }] subscribeNext:^(NSString * x) {
        @strongify(self)
        [self showLog:x];
    }];
}

- (IBAction)tapSendNextButton:(id)sender {
    [self.baidu sendNext:@"baidu.com"];
    [self.google sendNext:@"google.com"];
}

- (IBAction)tapBaiduSwitch:(UISwitch *)sender {
    self.googeSwitch.on = !sender.on;
    if (sender.on) {
        [self.signalOfSignal sendNext:self.baidu];
    } else {
        [self.signalOfSignal sendNext:self.google];
    }
}

- (IBAction)tapGoogleSwitch:(UISwitch *)sender {
    self.baiduSwitch.on = !sender.on;
    if (sender.on) {
        [self.signalOfSignal sendNext:self.google];
    } else {
        [self.signalOfSignal sendNext:self.baidu];
    }
}

- (void)showLog:(NSString *)log {
    [ShowLogUtile showLog:self.logTextView log:log];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"被释放");
}


@end
