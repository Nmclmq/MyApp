//
//  practiceController1.m
//  个人项目
//
//  Created by qianfeng on 16/5/15.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "practiceController1.h"
#import "practiceModel1.h"
#import "practiceTableCell1.h"
#import "AFNetworking.h"
#import "Header.h"
#import "practiceController.h"
#import "MJRefresh.h"
@interface practiceController1 ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _currentPage;
}
//@property (nonatomic,strong)NSInteger _currentPage;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataSource;


@end

@implementation practiceController1

//
//- (void)recvBcast:(NSNotification *)notify {
////    NSDictionary *dic = [notify userInfo];
////    _UID = [dic objectForKey:@"myKey"];
//    NSLog(@"----------------/*****************-%@",[notify object]);
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recvBcast:) name:@"guanguan" object:nil];
    
    _UID = [[NSUserDefaults standardUserDefaults] stringForKey:@"tianma"];
    NSLog(@"%@",_UID);
    _currentPage = 1;
    //    [NSNotificationCenter defaultCenter] post
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.800 green:1.000 blue:0.400 alpha:1.000];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _dataSource = [[NSMutableArray alloc]init];
    [self createTableView];
    [self createRefeshView];
    
    [self.tableView.mj_header beginRefreshing];
}

//- (void)sendId:(NSString *)uid {
//    self.UID = uid;
//}

- (void)createRefeshView{
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        _currentPage = 1;
        //请求数据
        if (_currentPage==1) {
            [self loadDataSource];
        }else{
            [self endRereshing];
        }
        _currentPage++;
    }];
}
//结束刷新
- (void)endRereshing{
    [self.tableView.mj_header endRefreshing];
}
//
//- (void)createRefeshView{
//    //下拉刷新
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        _currentPage++;
//        //请求数据
//        if(_currentPage ==1){
//            [self loadDataSource];
//        }else{
//            [self endRereshing];
//        }
//        [self endRereshing];
//    }];
////
////    //上拉加载更多
////    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
////        if(_currentPage==1){
////            //结束刷新
////            [self endRereshing];
////        }
////        //加载更多数据
////        [self loadDataSource];
////    }];
////
//}
////结束刷新
//- (void)endRereshing{
//        [self.tableView.mj_header endRefreshing];
//
//}



- (void)loadDataSource{
    [self showLoading];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableSet * set = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    [set addObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = set;
    NSString * url = [NSString stringWithFormat:MECOOKAPI,_UID];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * data = responseObject[@"data"];
        NSArray * array = data[@"step"];
        for (NSDictionary * dict in array) {
            practiceModel1 * model = [[practiceModel1 alloc]initWithDictionary:dict error:nil];
            [_dataSource addObject:model];
            
        }
        //        [self createTableView];
        [_tableView reloadData];
        [self endRereshing];
        [self hideLoading];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hideLoading];
        [self showNetErrorTip];
        NSLog(@"做饭失误");
    }];
    
}


- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //    self.tableView.backgroundColor = [UIColor redColor];
    //    NSLog(@"2");
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"practiceTableCell1" bundle:nil] forCellReuseIdentifier:@"asd"];
    self.tableView.frame=CGRectMake (0,0,self.view.bounds.size.width,self.view.bounds.size.height - 145);
    //     NSLog(@"3");
    [self.view addSubview:_tableView];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    NSLog(@" count  %ld",_dataSource.count);
    return self.dataSource.count;
}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[UITableViewCell alloc]init];
//    cell.textLabel.text = @"daf";
//    return cell;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    practiceTableCell1 * cell = [tableView dequeueReusableCellWithIdentifier:@"asd" forIndexPath:indexPath];
    practiceModel1 * model = _dataSource[indexPath.row];
    //    NSLog(@"0.0.0.0.0.0%@",model);
    [cell configDataModel:model];
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
