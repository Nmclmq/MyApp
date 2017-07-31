//
//  DynamicView.h
//  UIDynamicDemo
//
//  Created by baoxu on 16/5/7.
//  Copyright © 2016年 BaoXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicView : UIView
// 仿真者，盒子
@property (strong, nonatomic) UIImageView *box;
//@property (strong,nonatomic)UIButton * button;
// 仿真器，仿真环境，操场
@property (strong, nonatomic) UIDynamicAnimator *animator;

@end
