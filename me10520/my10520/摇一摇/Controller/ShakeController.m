//
//  ShakeController.m
//  个人项目
//
//  Created by qianfeng on 16/5/10.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "ShakeController.h"
#import "DynamicView.h"
#import "PushView.h"
#import "cookViewController.h"
@interface ShakeController ()<pushNext>

@end

@implementation ShakeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.view.backgroundColor = [UIColor colorWithRed:0.051 green:0.537 blue:1.000 alpha:1.000];
    // 多态属性，父类指针指向子类
//    DynamicView *dynamicView = nil;
    PushView *dynamicView = [[PushView alloc]initWithFrame:self.view.bounds];
    self.title = @"碰碰乐";
    dynamicView.delegate = self;
    [self.view addSubview:dynamicView];
    
//    self.navigationController.navigationBarHidden=YES;
    
//    ShakeController * cvc = [[ShakeController alloc]init];
    
}
- (void)pushNextController:(NSString *)url {
    cookViewController *pc = [[cookViewController alloc]init];
//    self.navigationController.navigationBarHidden=NO;
    pc.UID = url;
    [self.navigationController pushViewController:pc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
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
