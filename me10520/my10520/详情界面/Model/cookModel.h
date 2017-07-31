//
//  cookModel.h
//  个人项目
//
//  Created by qianfeng on 16/5/15.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "JSONModel.h"

@interface cookModel : JSONModel
@property (nonatomic,copy)NSString * image;
//名字
@property (nonatomic,copy)NSString * dishes_title;
//介绍
@property (nonatomic,copy)NSString * material_desc;
//难度
@property (nonatomic,copy)NSString *hard_level;
//时间
@property (nonatomic,copy)NSString *cooke_time;
//口味
@property (nonatomic,copy)NSString * taste;
//做法

@end























