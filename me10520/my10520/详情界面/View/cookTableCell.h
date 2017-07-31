//
//  cookTableCell.h
//  个人项目
//
//  Created by qianfeng on 16/5/15.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cookModel.h"

typedef void(^pushNext)(NSString *);

@protocol pushNext <NSObject>

- (void)pushNextController;

@end

@interface cookTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;
@property (weak, nonatomic) IBOutlet UILabel *difficultyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *flavorLabel;
@property (nonatomic,copy)NSString * PID;
- (void)configDataModel:(cookModel *)model;

@property (weak, nonatomic) id<pushNext>delegate;

@property (copy, nonatomic) pushNext block;

@end
