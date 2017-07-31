//
//  practiceTableCell2.h
//  个人项目
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PracticeModel2_1.h"
@interface practiceTableCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;
- (void)configDataModel:(PracticeModel2_1 *)model;
@end
