//
//  homePageController.m
//  个人项目
//
//  Created by qianfeng on 16/5/10.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "homePageController.h"
#import "UIParameter.h"
#import "NinaPagerView.h"
@interface homePageController ()

@end

@implementation homePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
//    self.navigationController.navigationBar.translucent = NO;
    
    NSArray *titleArray =   @[
                              @"热门",
                              @"最新",
                              @"排行"
                              ];
    
    NSArray *vcsArray = @[
                          @"HomeViewController1",
                          @"HomeViewController2",
                          @"HomeViewController3",
                          ];
    NSArray *colorArray = @[
                            [UIColor brownColor], /**< 选中的标题颜色 Title SelectColor  **/
                            [UIColor grayColor], /**< 未选中的标题颜色  Title UnselectColor **/
                            [UIColor redColor], /**< 下划线颜色 Underline Color   **/
                            ];
    NinaPagerView *ninaPagerView = [[NinaPagerView alloc] initWithTitles:titleArray WithVCs:vcsArray WithColorArrays:colorArray];
    [self.view addSubview:ninaPagerView];
    
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
