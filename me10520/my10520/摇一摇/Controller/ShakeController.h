//
//  ShakeController.h
//  个人项目
//
//  Created by qianfeng on 16/5/10.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShakeController : UIViewController
// 仿真者，盒子
@property (strong, nonatomic) UIImageView *box;
//@property (strong,nonatomic)UIButton * button;
// 仿真器，仿真环境，操场
@property (strong, nonatomic) UIDynamicAnimator *animator;

@end
