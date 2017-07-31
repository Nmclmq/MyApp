//
//  practiceTableCell3.m
//  个人项目
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "practiceTableCell3.h"

@implementation practiceTableCell3

- (void)awakeFromNib {
    // Initialization code
}
- (void)configDataModel:(practiceModel3 *)model{
    _contextLabel.text = model.nutrition_analysis;
    _context2Label.text =model.production_direction;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
