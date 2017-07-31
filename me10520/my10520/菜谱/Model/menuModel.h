//
//  menuModel.h
//  个人项目
//
//  Created by qianfeng on 16/5/10.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

//#import "JSONModel.h"
#import <Foundation/Foundation.h>
@interface menuModel : NSObject
@property (nonatomic,copy) NSString * ID;

@property (nonatomic,copy) NSString * text;

@property (nonatomic,strong)NSMutableArray * data;

@end
