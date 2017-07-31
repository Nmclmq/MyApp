//
//  menuCollectionViewCell.m
//  个人项目
//
//  Created by qianfeng on 16/5/10.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "menuCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation menuCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)configDataModel:(MNModel *)model{
    self.nameLabel.text = model.text;
    
}

@end
