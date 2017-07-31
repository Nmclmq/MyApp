//
//  practiceTableCell1.h
//  个人项目
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "practiceModel1.h"
@interface practiceTableCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

- (void)configDataModel:(practiceModel1 *)model;
@end
