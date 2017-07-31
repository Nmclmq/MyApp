//
//  myTableViewCellTwo.m
//  个人项目
//
//  Created by qianfeng on 16/5/11.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "myTableViewCellTwo.h"
#import "UIImageView+WebCache.h"
@implementation myTableViewCellTwo

- (void)awakeFromNib {
    // Initialization code
}
- (void)configDataModel:(myModelTwo *)model andIndex:(NSInteger)index{
    
    switch (index) {
        case 1:
        {
            [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.pick_image]placeholderImage:[UIImage imageNamed:@"Unknown-2.jpeg"]];
            _contextLabel.text = model.pick;
//            NSLog(@"11111 %@",_iconImageView.image);
            NSLog(@"11111 %@",model.pick_image);
        }
            break;
        case 2:
        {
            [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.effect_image]placeholderImage:[UIImage imageNamed:@"Unknown-2.jpeg"]];
            _contextLabel.text = model.effect;
            NSLog(@"22222");
        }
            break;
        case 3:
        {
            [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.applied_image]placeholderImage:[UIImage imageNamed:@"Unknown-2.jpeg"]];
            _contextLabel.text = model.applied;
            NSLog(@"33333");
        }
            break;
            
        default:
            break;
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
