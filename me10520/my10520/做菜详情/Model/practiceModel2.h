//
//  practiceModel2.h
//  个人项目
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "JSONModel.h"

@interface practiceModel2 : NSObject
//食材名
//@property (nonatomic,copy)NSString *material_name;
//用量
//@property (nonatomic,copy)NSString *material_weight;

//@property (nonatomic,copy)NSString * material_image;
@property (nonatomic,strong)NSMutableArray *material;
@property (nonatomic,strong)NSMutableArray * spices;

@end
