//
//  ViewController.m
//  RACDemoWithObjC
//
//  Created by lizelu on 2017/11/30.
//  Copyright © 2017年 lizelu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"aaaa"];
            [subscriber sendNext:@"bbb"];
            [subscriber sendNext:@"ccc"];
            [subscriber sendNext:@"ddd"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    [command executing];
    
}

- (IBAction)tapRACSequenceButton:(id)sender {
    [self uppercaseString];
}


/**
 RACSequence
 */
- (void)uppercaseString {
    RACSequence *sequence = [@[@"you", @"are", @"beautiful"] rac_sequence];
    
    [[sequence.signal map:^id(NSString *value) {
        return [value capitalizedString];   //映射规则
    }] subscribeNext:^(NSString *value) {
         NSLog(@"capitalizedSignal --- %@", value);
    }] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
