//
//  myModel.m
//  个人项目
//
//  Created by qianfeng on 16/5/11.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "myModel.h"

@implementation myModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"description":@"MyDescription"}];
}
//MyDescription
@end
