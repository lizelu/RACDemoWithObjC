//
//  RACCommandViewController.m
//  RACDemoWithObjC
//
//  Created by lizelu on 2017/12/1.
//  Copyright © 2017年 lizelu. All rights reserved.
//

#import "RACCommandViewController.h"
#import "RACCommandViewModel.h"

@interface RACCommandViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *authCodeTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;     //登录按钮
@property (weak, nonatomic) IBOutlet UITextView *logTextView;   //显示log日志
@property (nonatomic) RACCommandViewModel *viewModel;           //ViewModle层

@end

@implementation RACCommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[RACCommandViewModel alloc] init];
    
     @weakify(self)
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [self fetchData];
    }];
    
    [self bindValueAndSignal];
}

- (void)bindValueAndSignal {
    
//    @weakify(self)
//    [self.userNameTextField.rac_textSignal subscribeNext:^(NSString *userName) {
//        @strongify(self)
//        self.viewModel.userName = userName;
//    }];
//
//    [self.passwordTextField.rac_textSignal subscribeNext:^(NSString *password) {
//        @strongify(self)
//        self.viewModel.password = password;
//    }];
//
//    [self.authCodeTextField.rac_textSignal subscribeNext:^(NSString *authCode) {
//        @strongify(self)
//        self.viewModel.authCode = authCode;
//    }];
//
//    [self.viewModel.loginButtonEnableSignal subscribeNext:^(NSNumber *value) {
//        @strongify(self)
//        self.loginButton.enabled = value.boolValue;
//    }];
    
    
    // or

    RAC(self.viewModel, userName) = self.userNameTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
    RAC(self.viewModel, authCode) = self.authCodeTextField.rac_textSignal;
    RAC(self.loginButton, enabled) = self.viewModel.loginButtonEnableSignal;
}


/**
 调用ViewModel层获取数据
 */
- (void)fetchData {
    @weakify(self)
    [[self.viewModel.loginCommand execute:nil] subscribeNext:^(NSString *loginResult) {
        @strongify(self)
        [self showLog:loginResult];
    }];
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
