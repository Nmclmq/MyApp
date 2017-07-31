//
//  practiceTableCell1.m
//  个人项目
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "practiceTableCell1.h"
#import "UIImageView+WebCache.h"
@implementation practiceTableCell1

- (void)awakeFromNib {
    // Initialization code
}

- (void)configDataModel:(practiceModel1 *)model{
    
    _titleLabel.text = model.dishes_step_desc;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.dishes_step_image]placeholderImage:[UIImage imageNamed:@"Unknown-2.jpeg"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
