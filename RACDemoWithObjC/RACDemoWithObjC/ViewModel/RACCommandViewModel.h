//
//  RACCommandViewModel.h
//  RACDemoWithObjC
//
//  Created by lizelu on 2017/12/1.
//  Copyright © 2017年 lizelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RACCommandViewModel : NSObject

@property (nonatomic, strong) RACCommand *loginCommand;  //对外的命令接口，来触发登录操作

@end
