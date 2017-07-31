//
//  XZBaseViewController.m
//  LimitFreeApp
//
//  Created by jameswatt on 16/4/7.
//  Copyright © 2016年 xuzhixiang1. All rights reserved.
//

#import "XZBaseViewController.h"
#import "MBProgressHUD+Add.h"


@interface XZBaseViewController ()

@end

@implementation XZBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //可以做一些统一的设置
    self.view.backgroundColor = [UIColor whiteColor];
    
//    if (self.navigationController.viewControllers.count >= 1  ) {
//        self.hidesBottomBarWhenPushed = YES;
//    }
    if (self.navigationController.viewControllers.count > 1  ) {
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backBarBtnPressed:)];
    }
    
}
- (void)backBarBtnPressed:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)showLoading {
    [MBProgressHUD showMessag:@"正在努力加载..." toView:self.view];
}
- (void)showTipWithTitle:(NSString*)title {
    [MBProgressHUD showSuccess:title toView:self.view];
}
- (void)hideLoading {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
/**
 *  网络请求失败的提示
 */
- (void)showNetErrorTip {
    [self showTipWithTitle:@"网络连接失败，请检查网络"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
