//
//  RACObserveViewController.m
//  RACDemoWithObjC
//
//  Created by lizelu on 2017/11/30.
//  Copyright © 2017年 lizelu. All rights reserved.
//

#import "RACObserveViewController.h"

@interface RACObserveViewController ()

@property (strong, nonatomic) IBOutlet UITextView *logTextView;
@property (strong, nonatomic) IBOutlet UITextField *myTextField;

@end

@implementation RACObserveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"RACObserve";

    @weakify(self)
    [RACObserve(self.myTextField, text) subscribeNext:^(NSString *value) {
        @strongify(self)
        [self showLog:value];
    }];
    
    [[self.myTextField rac_textSignal] subscribeNext:^(NSString *value) {
        @strongify(self)
        [self showLog:value];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapGesture:(id)sender {
    [self.view endEditing:YES];
}

- (void)showLog:(NSString *)log {
    [ShowLogUtile showLog:self.logTextView log:log];
}

- (void)dealloc {
    NSLog(@"被释放");
}

@end
