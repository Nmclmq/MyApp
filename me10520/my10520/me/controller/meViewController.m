//
//  meViewController.m
//  个人项目
//
//  Created by qianfeng on 16/5/11.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "meViewController.h"
#import "meModel.h"
#import "meTableCell.h"
#import "AFNetworking.h"
#import "Header.h"
#import "MJRefresh.h"

#import "cookViewController.h"
@interface meViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataSource;
//当前展示的页码
@property (nonatomic)NSInteger currentPage;
@end
@implementation meViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithRed:0.856 green:0.914 blue:1.000 alpha:1.000];
    // Do any additional setup after loading the view.
    self.title = _itemTitle;
    _dataSource = [[NSMutableArray alloc]init];
    //    [self loadDataSource];
    [self createTableView];
    [self createRefeshView];
    [self.tableView.mj_header beginRefreshing];
    
}




- (void)createRefeshView{
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _currentPage = 1;
        //请求数据
        [self loadDataSource];
    }];
    
    //上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _currentPage ++;
        //加载更多数据
        [self loadDataSource];
    }];
    
}
//结束刷新
- (void)endRereshing{
    if (_currentPage == 1) {
        NSLog(@"结束下拉刷新");
        [self.tableView.mj_header endRefreshing];
    }else{
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)loadDataSource{
    
    [self showLoading];
    
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableSet * set = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    [set addObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = set;
    
    NSString * url = [NSString stringWithFormat:touchMenuAPI,self.UID,_currentPage];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self hideLoading];
        NSDictionary * data = responseObject[@"data"];
        
        
        NSString * count = data[@"count"];
        
        
        NSArray * array = data[@"data"];
        //            NSMutableArray * resArray = [meModel arrayOfModelsFromDictionaries:array];
        //        [self.dataSource addObjectsFromArray:resArray];
        //        [self createTableView];
        
        
        if ([count integerValue] == 10) {
            NSLog(@"请求成功");
            //转模型
            NSMutableArray *result = [meModel arrayOfModelsFromDictionaries:array error:nil];
            if (_currentPage == 1) {
                //下拉刷新
                //                    self.dataSource = result;
                [self.dataSource addObjectsFromArray:result];
            }else{
                //上拉加载更多
                [self.dataSource addObjectsFromArray:result];
            }
            [self.tableView reloadData];
        }
        
        //结束刷新
        [self endRereshing];
        
        
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
    [self.tableView registerNib:[UINib nibWithNibName:@"meTableCell" bundle:nil] forCellReuseIdentifier:@"meTableCell"];
    self.tableView.frame=CGRectMake (0,0,self.view.bounds.size.width,self.view.bounds.size.height - 64);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    meTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"meTableCell"];
    meModel * model = self.dataSource[indexPath.row];
    [cell configDataModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"再点我一下试试 菜谱里面的布局开始");
    cookViewController * cvc = [[cookViewController alloc]init];
    meModel * model = _dataSource[indexPath.row];
    cvc.UID = model.dishes_id;
    [self.navigationController pushViewController:cvc animated:YES];
    
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
