//
//  cookTableCell.m
//  个人项目
//
//  Created by qianfeng on 16/5/15.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "cookTableCell.h"
#import "UIImageView+WebCache.h"
#import "practiceController.h"
@implementation cookTableCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)goToButton:(id)sender {
//    practiceController * cvc = [[practiceController alloc]init];
//    homePageModel * model = _dataSource[indexPath.row];
//    cvc.UID = model.dishes_id;
    //
//    NSLog(@"-------------%@",cvc.UID);
//    [self d];
//    [self.navigationController pushViewController:cvc animated:YES];
//    [s];
    
    
    [self.delegate pushNextController];
    self.block(@"fuck");
    NSLog(@"跳转到最后界面");
}


- (void)configDataModel:(cookModel *)model{
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.image]placeholderImage:[UIImage imageNamed:@"Unknown-2.jpeg"]];
    _nameLabel.text = model.dishes_title;
    _contextLabel.text = model.material_desc;
    _difficultyLabel.text = model.hard_level;
    _timeLabel.text = model.cooke_time;
    _flavorLabel.text = model.taste;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
