//
//  XZBaseViewController.h
//  LimitFreeApp
//
//  Created by jameswatt on 16/4/7.
//  Copyright © 2016年 xuzhixiang1. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "APIHeader.h"

@interface XZBaseViewController : UIViewController

- (void)showLoading;
- (void)showTipWithTitle:(NSString*)title;
- (void)hideLoading;
/**
 *  网络请求失败的提示
 */
- (void)showNetErrorTip;
@end
