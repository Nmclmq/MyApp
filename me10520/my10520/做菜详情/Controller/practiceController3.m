//
//  practiceController3.m
//  个人项目
//
//  Created by qianfeng on 16/5/15.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "practiceController3.h"
#import "AFNetworking.h"
#import "practiceModel3.h"
#import "practiceTableCell3.h"
#import "MJRefresh.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
//#import "<#header#>"
@interface practiceController3 ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _currentPage;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataSource;
@property (nonatomic,copy)NSString * Image;

@end

@implementation practiceController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:0.502 alpha:1.000];
    _UID = [[NSUserDefaults standardUserDefaults] stringForKey:@"tianma"];
    _dataSource = [[NSMutableArray alloc]init];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    [self loadDataSource];
    [self createTableView];
    [self createRefeshView];
    
    [self.tableView.mj_header beginRefreshing];
}


- (void)createRefeshView{
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _currentPage++;
        //请求数据
        if(_currentPage ==1){
            [self loadDataSource];
        }else{
            [self endRereshing];
        }
        [self endRereshing];
    }];
    //
    //    //上拉加载更多
    //    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
    //        if(_currentPage==1){
    //            //结束刷新
    //            [self endRereshing];
    //        }
    //        //加载更多数据
    //        [self loadDataSource];
    //    }];
    //
}
//结束刷新
- (void)endRereshing{
    //    if (_currentPage == 1) {
    NSLog(@"结束下拉刷新");
    [self.tableView.mj_header endRefreshing];
    //    }else{
    //        [self.tableView.mj_footer endRefreshing];
    //    }
}


- (void)loadDataSource{
    [self showLoading];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableSet * set = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    [set addObject:@"html/text"];
    manager.responseSerializer.acceptableContentTypes = set;
    NSString * url = [NSString stringWithFormat:MERELEVANTAPI,_UID];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        practiceModel3 * model = [[practiceModel3 alloc]init];
        NSDictionary *data = responseObject[@"data"];
        NSString * imageUrl = data[@"image"];
        _Image = imageUrl;
        model.nutrition_analysis = data[@"nutrition_analysis"];
        model.production_direction = data[@"production_direction"];
        [_dataSource addObject:model];
        //        NSLog(@"-------%@",_dataSource);
        
        //        NSLog(@"%@",_dataSource);
        //        [self createTableView];
        [_tableView reloadData];
        [self endRereshing];
        
        UIView * tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 250)];
        //        tableHeaderView.backgroundColor = [UIColor colorWithRed:0.614 green:0.947 blue:1.000 alpha:1.000];
        self.tableView.tableHeaderView = tableHeaderView;
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.tableView.tableHeaderView.bounds];
        [self.tableView.tableHeaderView addSubview:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:_Image]];
        //        NSLog(@"****************%@",_Image);
        //        imageView.backgroundColor = [UIColor yellowColor];
        [self hideLoading];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hideLoading];
        [self showNetErrorTip];
    }];
    
    
}

- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200.0l;
    [self.tableView registerNib:[UINib nibWithNibName:@"practiceTableCell3" bundle:nil] forCellReuseIdentifier:@"practiceTableCell3"];
    self.tableView.frame=CGRectMake (0,0,self.view.bounds.size.width,self.view.bounds.size.height - 145);
    [self.view addSubview:_tableView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    practiceTableCell3 * cell = [tableView dequeueReusableCellWithIdentifier:@"practiceTableCell3" forIndexPath:indexPath];
    practiceModel3 * model = _dataSource[indexPath.row];
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
