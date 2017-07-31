//
//  practiceController2.m
//  个人项目
//
//  Created by qianfeng on 16/5/15.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "practiceController2.h"
#import "practiceModel2.h"
#import "PracticeModel2_1.h"
#import "PracticeModel2_2.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "Header.h"
#import "practiceTableCell2.h"
#import "PracticeTableCell2_1.h"

@interface practiceController2 ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _currentPage;
    NSInteger _number ;
    NSInteger _index;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataSource;
@property (nonatomic,strong)NSMutableArray * dataSource1;
@property (nonatomic,strong)NSMutableArray * dataSource2;
@end

@implementation practiceController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:1.000];
    _UID = [[NSUserDefaults standardUserDefaults] stringForKey:@"tianma"];
    _dataSource = [[NSMutableArray alloc]init];
    NSLog(@"%@",_UID);
    //    [self loadDataSource];
    //    [self createTableView];
    //    [self createTableView];
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
    
    NSString * url = [NSString stringWithFormat:MEINGREDIENTSAPI,_UID];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //        practiceModel2 * model = [[practiceModel2 alloc]init];
        NSDictionary * data = responseObject[@"data"];
        //表头
        //        NSString * imageUrl = data[@"material_image"];
        NSArray * array1 = data[@"material"];
        NSArray * array2 = data[@"spices"];
        for (NSDictionary * dict in array1) {
            PracticeModel2_1 * model1 = [[PracticeModel2_1 alloc]init];
            model1.material_name = dict[@"material_name"];
            model1.material_weight = dict[@"material_weight"];
            [self.dataSource addObject:model1];
        }
        _index = self.dataSource.count;
        for (NSDictionary * dict in array2) {
            PracticeModel2_2 * model2 = [[PracticeModel2_2 alloc]init];
            model2.image = dict[@"image"];
            model2.title = dict[@"title"];
            
            [self.dataSource addObject:model2];
        }
        
        [self createTableView];
        [_tableView reloadData];
        [self endRereshing];
        [self hideLoading];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hideLoading];
        [self showNetErrorTip];
        NSLog(@"呜呜呜呜不要失败啊");
    }];
    
    
}

- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200.0l;
    [self.tableView registerNib:[UINib nibWithNibName:@"practiceTableCell2" bundle:nil] forCellReuseIdentifier:@"practiceTableCell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PracticeTableCell2_1" bundle:nil] forCellReuseIdentifier:@"PracticeTableCell2_1"];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row>=_index){
        PracticeTableCell2_1 * cell1 = [tableView dequeueReusableCellWithIdentifier:@"PracticeTableCell2_1" forIndexPath:indexPath];
        PracticeModel2_2 * model = _dataSource[indexPath.row];
        //        NSLog(@"%@",_dataSource[indexPath.row]);
        [cell1 configDataModel:model];
        return cell1;
    }
    practiceTableCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"practiceTableCell2" forIndexPath:indexPath];
    PracticeModel2_1 * model = _dataSource[indexPath.row];
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
