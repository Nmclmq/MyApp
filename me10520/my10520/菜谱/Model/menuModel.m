//
//  menuModel.m
//  个人项目
//
//  Created by qianfeng on 16/5/10.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "menuModel.h"

@implementation menuModel


//+ (JSONKeyMapper *)keyMapper{
//    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"ID"}];
//}
- (instancetype)init
{
    self = [super init];
    if (self) {
        //实例化可变数组
        self.data = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
