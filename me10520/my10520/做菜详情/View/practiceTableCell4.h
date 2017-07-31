//
//  practiceTableCell4.h
//  个人项目
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "practiceModel4.h"
@interface practiceTableCell4 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;
- (void)configDataModel:(practiceModel4 *)model;
@end
