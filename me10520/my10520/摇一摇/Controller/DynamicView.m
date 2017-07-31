//
//  DynamicView.m
//  UIDynamicDemo
//
//  Created by baoxu on 16/5/7.
//  Copyright © 2016年 BaoXu. All rights reserved.
//

#import "DynamicView.h"

@implementation DynamicView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.网格背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"6463-110PQ1024059.jpg"]];
//        self.button.backgroundColor = [UIColor cyanColor];
//        self.button.center = self.center;
//        [self addSubview:self.button];
        // 2.盒子
        self.box = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Box"]];
        self.box.center = self.center;
        [self addSubview:self.box];
        
        // 3.环境
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self];
        
    }
    return self;
}

@end
