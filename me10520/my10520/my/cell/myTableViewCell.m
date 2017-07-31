//
//  myTableViewCell.m
//  个人项目
//
//  Created by qianfeng on 16/5/11.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "myTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation myTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)configDataModel:(myModel *)model{
    
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 15;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.image]placeholderImage:[UIImage imageNamed:@"Unknown-2.jpeg"]];
    _nameLabel.text = model.title;
    _contextLabel.text = model.MyDescription;
    _easyLabel.text = model.hard_level;
    _flavorLabel.text = model.taste;
    _timesLabel.text = model.cookie;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
