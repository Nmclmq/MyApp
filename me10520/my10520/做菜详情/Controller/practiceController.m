//
//  practiceController.m
//  个人项目
//
//  Created by qianfeng on 16/5/15.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "practiceController.h"
#import "UIParameter.h"
#import "NinaPagerView.h"
@interface practiceController ()

@end

@implementation practiceController
//
//- (void)dealloc {
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"123" object:nil];
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSDictionary *dic = [NSDictionary dictionaryWithObject:_UID forKey:@"myKey"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"guanguan" object:_UID userInfo:nil];
   
    [[NSUserDefaults standardUserDefaults] setObject:_UID forKey:@"tianma"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSLog(@"##################%@",self.UID);
//
//    //    self.navigationController.navigationBar.translucent = NO;
//    
    NSArray *titleArray =   @[
                              @"做法",
                              @"食材",
                              @"相关知识",
                              @"相宜相克",
                              ];
    
    NSArray *vcsArray = @[
                          @"practiceController1",
                          @"practiceController2",
                          @"practiceController3",
                          @"practiceController4",
                          ];
    NSArray *colorArray = @[
                            [UIColor brownColor], /**< 选中的标题颜色 Title SelectColor  **/
                            [UIColor grayColor], /**< 未选中的标题颜色  Title UnselectColor **/
                            [UIColor redColor], /**< 下划线颜色 Underline Color   **/
                            ];
    
    NinaPagerView *ninaPagerView = [[NinaPagerView alloc] initWithTitles:titleArray WithVCs:vcsArray WithColorArrays:colorArray];
//    [self.delegate sendId:self.UID];
    [self.view addSubview:ninaPagerView];

}
//
//- (NSString *)UID {
//   
//    return _UID;
//}

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
