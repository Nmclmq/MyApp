//
//  NMCRootController.m
//  基本骨架
//
//  Created by Whensea on 16/11/15.
//  Copyright © 2016年 Whensea. All rights reserved.
//

#import "NMCRootController.h"
//#import "HomePageController.h"
//#import "NextPageController.h"
//#import "ThirdPagesController.h"
//#import "FourthPagesController.h"
#import "ShakeController.h"
#import "menuController.h"
#import "meController.h"
#import "HomeViewController3.h"

#import "NMCNavController.h"
#import "NMCTabBar.h"
#import "UIImage+NMCExtension.h"
@interface NMCRootController ()

@end

@implementation NMCRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewControllers];
    self.view.backgroundColor = [UIColor grayColor];
    
//    NMCTabBar * tabBar = [[NMCTabBar alloc]init];
//    [self setValue:tabBar forKey:@"tabbar"];
    //主题设置
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    
    
    UITabBarItem * itemAppearance = [UITabBarItem appearance];
    NSDictionary * dict = @{
                            NSForegroundColorAttributeName:[UIColor darkGrayColor]
                            };
    //选中状态
    [itemAppearance setTitleTextAttributes:dict forState:UIControlStateSelected];
}

- (void)addChildViewControllers{
    //home Page
    [self setUpChildViewController:[[HomeViewController3 alloc]init] title:@"推荐" imageNamed:@"tabBar_essence_icon"];
    [self setUpChildViewController:[[ShakeController alloc]init] title:@"碰碰" imageNamed:@"tabBar_new_icon"];
    [self setUpChildViewController:[[menuController alloc]init] title:@"菜谱" imageNamed:@"tabBar_me_icon"];
    [self setUpChildViewController:[[meController  alloc]init] title:@"其他" imageNamed:@"tabBar_friendTrends_icon"];
}

//创建子控件的方法


- (void)setUpChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageName{
    NMCNavController * naVc = [[NMCNavController alloc]initWithRootViewController:vc];
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    NSString * selectImageName = [imageName stringByAppendingString:@"_click"];
    vc.tabBarItem.selectedImage = [UIImage nmc_originarImageNamed:selectImageName];
    //给TabBarController添加一个自控制器
    [self addChildViewController:naVc];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
