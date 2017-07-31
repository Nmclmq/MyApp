//
//  practiceTableCell4.m
//  个人项目
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "practiceTableCell4.h"
#import "UIImageView+WebCache.h"
@implementation practiceTableCell4

- (void)awakeFromNib {
    // Initialization code
}
- (void)configDataModel:(practiceModel4 *)model{
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.image]placeholderImage:[UIImage imageNamed:@"Unknown-2.jpeg"]];
    _titleLabel.text = model.material_name;
    _contextLabel.text = model.suitable_desc;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
