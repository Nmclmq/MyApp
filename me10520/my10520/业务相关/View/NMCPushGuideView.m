//
//  NMCPushGuideView.m
//  基本骨架
//
//  Created by Whensea on 16/11/15.
//  Copyright © 2016年 Whensea. All rights reserved.
//

#import "NMCPushGuideView.h"

@implementation NMCPushGuideView
+ (instancetype)guideView{
    NMCPushGuideView * guideView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    return  guideView;
}


+ (void)show{
    //进入的时候判断一下版本号 只有第一次打开或者更新了以后才会显示引导页
    //获取版本号
    NSDictionary * info = [[NSBundle mainBundle] infoDictionary];
    NSString * key = @"CFBundleShortVersionString";
    NSString * currenVersion = info[key];
    
    //思路：判断，如果这次运行的版本号 和上一次的版本号不一样，，那么就显示引导页！
    //数据持续化！！沙盒！！
    //拿出沙盒中的版本号
    NSString * sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    //对拿出的版本号进行判断
    if(![currenVersion isEqualToString:sanboxVersion]){//如果满足条件就是版本号更新了
        //创建引导页
        NMCPushGuideView * push = [NMCPushGuideView guideView];
        push.frame = [UIApplication sharedApplication].keyWindow.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:push];
        
        //新的版本存到沙盒中
        [[NSUserDefaults standardUserDefaults] setObject:currenVersion forKey:key];
        //立刻存储
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}
@end
