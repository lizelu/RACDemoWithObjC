//
//  SignalMergeViewController.m
//  RACDemoWithObjC
//
//  Created by lizelu on 2017/11/30.
//  Copyright © 2017年 lizelu. All rights reserved.
//

#import "SignalMergeViewController.h"

@interface SignalMergeViewController ()

@property (strong, nonatomic) IBOutlet UITextView *logTextView;

@property (nonatomic, strong) RACSubject *letters;
@property (nonatomic, strong) RACSubject *numbers;

@property (nonatomic) NSArray *lettersArray;

@end

@implementation SignalMergeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"信号merge";
    
    self.letters = [RACSubject subject];
    self.numbers = [RACSubject subject];
    
    @weakify(self)
    [[RACSignal merge:@[self.letters, self.numbers]] subscribeNext:^(id value) {
        @strongify(self)
        [self showLog:[NSString stringWithFormat:@"merge signal : %@ \\n", value]];
    }] ;
    
    self.lettersArray = @[@"A", @"B", @"C", @"D", @"E", @"F"];
}

- (IBAction)tapSendLetterButton:(id)sender {
    NSString *randomString = self.lettersArray[arc4random() % self.lettersArray.count];
    [self showLog:[NSString stringWithFormat:@"send letter value : %@", randomString]];
    [self.letters sendNext:randomString];
}

- (IBAction)tapSendNumberButton:(id)sender {
    NSUInteger number = arc4random() % 100;
    [self showLog:[NSString stringWithFormat:@"send number value : %@", @(number)]];
    [self.numbers sendNext:@(number)];
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
