//
//  NMCTabBar.m
//  基本骨架
//
//  Created by Whensea on 16/11/15.
//  Copyright © 2016年 Whensea. All rights reserved.
//

#import "NMCTabBar.h"
@interface NMCTabBar()
@property (weak,nonatomic)UIButton * publishBtn;
@end

@implementation NMCTabBar
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //创建子控件
        UIButton * publish = [[UIButton alloc]init];
        [publish setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publish setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon_click"] forState:UIControlStateHighlighted];
        [self addSubview:publish];
        self.publishBtn = publish;
    }
    
    return self;
}


@end
