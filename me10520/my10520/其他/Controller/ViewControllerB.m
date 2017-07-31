//
//  ViewControllerB.m
//  个人项目
//
//  Created by qianfeng on 16/5/22.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "ViewControllerB.h"

@interface ViewControllerB ()
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;

@end

@implementation ViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _contextLabel.text = @"希望大家健健康康合理饮食，我们会致力于创新出更好的App来为大家服务。";
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
