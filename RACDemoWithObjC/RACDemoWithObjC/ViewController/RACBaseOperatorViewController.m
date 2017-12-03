//
//  RACBaseOperatorViewController.m
//  RACDemoWithObjC
//
//  Created by lizelu on 2017/12/3.
//  Copyright © 2017年 lizelu. All rights reserved.
//

#import "RACBaseOperatorViewController.h"

@interface RACBaseOperatorViewController ()

@property (weak, nonatomic) IBOutlet UITextView *logTextView;
@property (nonatomic, assign) unsigned subscriptions;
@property (nonatomic, strong) RACSignal *loggingSignal;

@end

@implementation RACBaseOperatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"login";
    // Do any additional setup after loading the view.
    self.subscriptions = 0;

    @weakify(self)
    self.loggingSignal = [RACSignal createSignal:^ RACDisposable * (id<RACSubscriber> subscriber) {
        @strongify(self)
        self.subscriptions++;
        [subscriber sendCompleted];
        return nil;
    }];

    // Does not output anything yet
    self.loggingSignal = [self.loggingSignal doCompleted:^{  //
        @strongify(self)
        [self showLog:[NSString stringWithFormat:@"about to complete subscription %u", self.subscriptions]];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapDocompletedButton:(id)sender {
    
    // Outputs:
    // about to complete subscription 1
    // subscription 1
    @weakify(self)
    [self.loggingSignal subscribeCompleted:^{
        @strongify(self)
        [self showLog:[NSString stringWithFormat:@"subscription %u", self.subscriptions]];
    }];
    [self showLog:@"\\n"];
}

- (IBAction)tapMappingButton:(id)sender {
    RACSequence *letters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence;
    
    // Contains: AA BB CC DD EE FF GG HH II
    RACSequence *mapped = [letters map:^(NSString *value) {
        return [value stringByAppendingString:value];
    }];
    
    [[mapped signal] subscribeNext:^(NSString *value) {
        [self showLog:value];
    }];
    [self showLog:@"\\n"];
}

- (IBAction)tapConcatenatingButton:(id)sender {
    RACSequence *letters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence;
    RACSequence *numbers = [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence;
    
    // Contains: A B C D E F G H I 1 2 3 4 5 6 7 8 9
    RACSequence *concatenated = [letters concat:numbers];
    [[concatenated signal] subscribeNext:^(NSString *value) {
        [self showLog:value];
    }];
    [self showLog:@"\\n"];
}

- (IBAction)taptaptapFlatteningButton:(id)sender {
    RACSequence *letters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence;
    RACSequence *numbers = [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence;
    RACSequence *sequenceOfSequences = @[ letters, numbers ].rac_sequence;
    
    // Contains: A B C D E F G H I 1 2 3 4 5 6 7 8 9
    RACSequence *flattened = [sequenceOfSequences flatten];
    [[flattened signal] subscribeNext:^(NSString *value) {
        [self showLog:value];
    }];
    [self showLog:@"\\n"];
}

- (IBAction)tapSignalAreMergedButton:(id)sender {
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSignal *signalOfSignals = [RACSignal createSignal:^ RACDisposable * (id<RACSubscriber> subscriber) {
        [subscriber sendNext:letters];
        [subscriber sendNext:numbers];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *flattened = [signalOfSignals flatten];
    
    // Outputs: A 1 B C 2
    [flattened subscribeNext:^(NSString *x) {
        [self showLog:x];
    }];
    
    [letters sendNext:@"A"];
    [numbers sendNext:@"1"];
    [letters sendNext:@"B"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"2"];
    [self showLog:@"\\n"];
}


- (void)showLog:(NSString *)log {
    [[RACScheduler mainThreadScheduler] afterDelay:0 schedule:^{
        [ShowLogUtile showLog:self.logTextView log:log];
    }];
}

- (void)dealloc {
    NSLog(@"被释放");
}


@end
