//
//  ViewControllerE.m
//  个人项目
//
//  Created by qianfeng on 16/5/22.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "ViewControllerE.h"

@interface ViewControllerE ()
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;

@end

@implementation ViewControllerE

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _contextLabel.text = @"一只茁壮成长的菜鸟:near";
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
