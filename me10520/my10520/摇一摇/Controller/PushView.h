//
//  PushView.h
//  UIDynamicDemo
//
//  Created by baoxu on 16/5/7.
//  Copyright © 2016年 BaoXu. All rights reserved.
//

#import "DynamicView.h"
@protocol pushNext <NSObject>

- (void)pushNextController:(NSString *)url;

@end

@interface PushView : DynamicView

@property (weak, nonatomic) id<pushNext>delegate;
@end
