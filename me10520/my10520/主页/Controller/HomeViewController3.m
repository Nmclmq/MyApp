//
//  HomeViewController3.m
//  个人项目
//
//  Created by qianfeng on 16/5/15.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "HomeViewController3.h"
#import "homePageModel.h"
#import "HomePageTableViewCell.h"
#import "AFNetworking.h"
#import "Header.h"
#import "MJRefresh.h"
#import "cookViewController.h"
#import "UIImageView+WebCache.h"

@interface HomeViewController3 ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataSource;
//当前展示的页码
@property (nonatomic)NSInteger currentPage;

@end

@implementation HomeViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐";
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor redColor];
    _dataSource = [[NSMutableArray alloc]init];
    [self loadDataSource];
    [self createTableView];
}


- (void)loadDataSource{
    [self showLoading];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableSet * set = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    [set addObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = set;
    
    NSString * url = [NSString stringWithFormat:HomePageRankingAPI,(long)_currentPage];
    //    NSLog(@"url %@",url);-
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSDictionary * data = responseObject[@"data"];
        
        NSArray * array = [[NSArray alloc]init];
        
        array = data[@"data"];
        NSMutableArray *result = [homePageModel arrayOfModelsFromDictionaries:array];
        [self.dataSource addObjectsFromArray:result];
        
        [self hideLoading];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hideLoading];
        [self showNetErrorTip];
        NSLog(@"呜呜呜坑爹的数据");
    }];
    
    
}

- (void)createTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200.0l;
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"HomePageTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomePageTableViewCell"];
    self.tableView.frame=CGRectMake (0,0,self.view.bounds.size.width,self.view.bounds.size.height -110);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomePageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageTableViewCell"];
    homePageModel * model = self.dataSource[indexPath.row];
    [cell configDataModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    cookViewController * cvc = [[cookViewController alloc]init];
    homePageModel * model = _dataSource[indexPath.row];
    cvc.UID = model.dishes_id;
    //
    NSLog(@"-------------%@",cvc.UID);
    [self.navigationController pushViewController:cvc animated:YES];
    NSLog(@"再点我一下试试 菜谱里面的布局开始");
    
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
