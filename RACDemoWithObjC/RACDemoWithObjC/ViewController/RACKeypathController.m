//
//  RACKeypathController.m
//  RACDemoWithObjC
//
//  Created by lizelu on 2017/12/1.
//  Copyright © 2017年 lizelu. All rights reserved.
//

#import "RACKeypathController.h"

@interface RACKeypathController ()

@property (weak, nonatomic) IBOutlet UITextView *logTextView;
@property (weak, nonatomic) IBOutlet UITextField *firstTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondTextField;
@property (copy, nonatomic) NSString *combineLatestString;
@end

@implementation RACKeypathController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RAC()";
    RAC(self, combineLatestString) = [RACSignal combineLatest:@[self.firstTextField.rac_textSignal, self.secondTextField.rac_textSignal] reduce:^id(NSString *firstValue, NSString *secondValue){
        return [NSString stringWithFormat:@"%@, %@", firstValue, secondValue];
    }];
}

- (IBAction)tapCombineLatestButton:(id)sender {
    [self showLog:self.combineLatestString];
}

- (void)showLog:(NSString *)log {
    [ShowLogUtile showLog:self.logTextView log:log];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
