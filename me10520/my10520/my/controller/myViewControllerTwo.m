//
//  myViewControllerTwo.m
//  个人项目
//
//  Created by qianfeng on 16/5/12.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "myViewControllerTwo.h"
#import "AFNetworking.h"
#import "Header.h"
#import "myTableViewCellTwo.h"
#import "myModelTwo.h"
#import "MJRefresh.h"
@interface myViewControllerTwo ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataSource;
@end

@implementation myViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithRed:0.856 green:0.914 blue:1.000 alpha:1.000];
    _dataSource = [[NSMutableArray alloc]init];
    self.title = _itemTitle;
    [self createDataSource];
    
}





- (void)createDataSource{
    [self showLoading];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableSet * set = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    [set addObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = set;
    
    //    [self showLoading];
    NSString * url = [NSString stringWithFormat:touchDetailedAPI,self.UID];
    //        NSLog(@"%@ %@",url,self.UID);
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //            [self hideLoading];
        NSDictionary * data = responseObject[@"data"];
        myModelTwo * model = [[myModelTwo alloc]init];
        model.pick_image = data[@"pick_image"];
        model.pick = data[@"pick"];
        model.effect_image = data[@"effect_image"];
        model.effect = data[@"effect"];
        model.applied_image = data[@"applied_image"];
        model.applied = data[@"applied"];
        [self.dataSource addObject:model];
        //            NSLog(@"%@",_dataSource);
        
        [self createTableView];
        [self hideLoading];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self hideLoading];
        [self showNetErrorTip];
        NSLog(@"呜呜呜坑爹的数据");
    }];
    
    
    
    
}


- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200.0l;
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"myTableViewCellTwo" bundle:nil] forCellReuseIdentifier:@"myTableViewCellTwo"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    myTableViewCellTwo * cell = [tableView dequeueReusableCellWithIdentifier:@"myTableViewCellTwo"];
    //    myModelTwo * model = [[myModelTwo alloc]init];
    myModelTwo * model = self.dataSource[indexPath.row];
    [cell configDataModel:model andIndex:_index];
    cell.backgroundColor = [UIColor colorWithRed:0.782 green:0.904 blue:1.000 alpha:1.000];
    return cell;
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
