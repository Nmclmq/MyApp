//
//  cookViewController.h
//  个人项目
//
//  Created by qianfeng on 16/5/15.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "XZBaseViewController.h"
@protocol sendID <NSObject>

- (void)sendID:(NSString *)uid;

@end
@interface cookViewController : XZBaseViewController
@property (nonatomic,copy)NSString * UID;
@property (nonatomic ,weak)id<sendID>delegate;
@end
