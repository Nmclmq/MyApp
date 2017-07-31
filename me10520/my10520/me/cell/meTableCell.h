//
//  meTableCell.h
//  个人项目
//
//  Created by qianfeng on 16/5/11.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "meModel.h"
@interface meTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;
- (void)configDataModel:(meModel *)model;
@end
