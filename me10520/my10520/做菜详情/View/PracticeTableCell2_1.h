//
//  PracticeTableCell2_1.h
//  个人项目
//
//  Created by qianfeng on 16/5/19.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PracticeModel2_2.h"
@interface PracticeTableCell2_1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
- (void)configDataModel:(PracticeModel2_2 *)model;
@end
