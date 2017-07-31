//
//  ViewControllerA.m
//  个人项目
//
//  Created by qianfeng on 16/5/22.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "ViewControllerA.h"

@interface ViewControllerA ()
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;

@end

@implementation ViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _contextLabel.text = @"\n\n1:数据较多，需要分批加载，请注意使用上拉刷新新数据\n\n2:碰碰乐界面请通过滑动屏幕长短来决定碰撞的力度\n\n3:如果产生错误请联系我们，我们会尽力解决";
    _contextLabel.backgroundColor = [UIColor colorWithRed:0.604 green:0.723 blue:1.000 alpha:1.000];
    
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
