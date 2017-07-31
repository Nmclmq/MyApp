//
//  practiceTableCell2.m
//  个人项目
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "practiceTableCell2.h"

@implementation practiceTableCell2

- (void)awakeFromNib {
    // Initialization code
}

- (void)configDataModel:(PracticeModel2_1 *)model{
    _contextLabel.text = model.material_weight;
    _titleLable.text = model.material_name;
    
}














- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
