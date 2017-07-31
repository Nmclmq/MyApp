//
//  meTableCell.m
//  个人项目
//
//  Created by qianfeng on 16/5/11.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "meTableCell.h"
#import "UIImageView+WebCache.h"
@implementation meTableCell


- (void)configDataModel:(meModel *)model{
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 15;
    
    _nameLabel.backgroundColor = [UIColor colorWithRed:255 green:248 blue:220 alpha:0.5];
    _contextLabel.backgroundColor = [UIColor colorWithRed:255 green:248 blue:220 alpha:0.5];
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.image]placeholderImage:[UIImage imageNamed:@"Unknown-2.jpeg"]];
    _nameLabel.text = model.title;
    _contextLabel.text = model.MyDescription;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
