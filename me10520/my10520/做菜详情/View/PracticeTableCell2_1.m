//
//  PracticeTableCell2_1.m
//  个人项目
//
//  Created by qianfeng on 16/5/19.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "PracticeTableCell2_1.h"
#import "UIImageView+WebCache.h"
@implementation PracticeTableCell2_1

- (void)awakeFromNib {
    // Initialization code
}

- (void)configDataModel:(PracticeModel2_2 *)model{
    _iconLabel.text = model.title;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.image]placeholderImage:[UIImage imageNamed:@"Unknown-2.jpeg"]];
    NSLog(@"***********************************%@",model.image);
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
