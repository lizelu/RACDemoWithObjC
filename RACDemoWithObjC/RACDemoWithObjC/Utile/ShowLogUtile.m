//
//  ShowLogUtile.m
//  RACDemoWithObjC
//
//  Created by lizelu on 2017/11/30.
//  Copyright © 2017年 lizelu. All rights reserved.
//

#import "ShowLogUtile.h"

@implementation ShowLogUtile

+ (void)showLog:(UITextView *)textView log:(NSString *)log {
    if (log != nil) {
        [NSString stringWithFormat:@""];
        NSString *tempStr = [NSString stringWithFormat:@"%@\n", textView.text];
        NSString *resultStr = [tempStr stringByAppendingString:log];
        NSString *b =[resultStr stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
        textView.text = b;
        [textView scrollRangeToVisible:NSMakeRange(textView.text.length, 1)];
    }
}

@end
