//
//  meModel.h
//  个人项目
//
//  Created by qianfeng on 16/5/11.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "JSONModel.h"

@interface meModel : JSONModel
@property (nonatomic,copy)NSString * dishes_id;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * MyDescription;
@property (nonatomic,copy)NSString * image;
@end
