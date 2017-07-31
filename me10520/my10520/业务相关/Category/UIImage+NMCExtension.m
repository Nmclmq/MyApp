//
//  UIImage+NMCExtension.m
//  基本骨架
//
//  Created by Whensea on 16/11/15.
//  Copyright © 2016年 Whensea. All rights reserved.
//

#import "UIImage+NMCExtension.h"

@implementation UIImage (NMCExtension)

+ (UIImage *)originarImageNamed:(NSString *)name{
    UIImage * image = [UIImage imageNamed:name];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}


+ (UIImage *)nmc_originarImageNamed:(NSString *)name{
    UIImage * image = [UIImage imageNamed:name];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}
@end
