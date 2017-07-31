//
//  practiceModel2.m
//  个人项目
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "practiceModel2.h"

@implementation practiceModel2
- (instancetype)init
{
    self = [super init];
    if (self) {
        //实例化可变数组
        self.material = [[NSMutableArray alloc] init];
        self.spices = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
