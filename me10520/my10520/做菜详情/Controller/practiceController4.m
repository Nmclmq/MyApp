//
//  practiceController4.m
//  个人项目
//
//  Created by qianfeng on 16/5/15.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "practiceController4.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "practiceModel4.h"
#import "practiceTableCell4.h"
#import "UIImageView+WebCache.h"
#import "Header.h"


@interface practiceController4 ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _currentPage;
    NSInteger _index;
    NSInteger _index1;
    NSArray * array;
}
@property (nonatomic,copy)NSString * Image;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataSource;


@end

@implementation practiceController4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.502 green:0.000 blue:0.000 alpha:1.000];
    
    _UID = [[NSUserDefaults standardUserDefaults] stringForKey:@"tianma"];
    _dataSource = [[NSMutableArray alloc]init];
    array = @[@"相宜食物",@"相克食物"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //        [self loadDataSource];
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
}
//结束刷新
- (void)endRereshing{
    NSLog(@"结束下拉刷新");
    [self.tableView.mj_header endRefreshing];
}

- (void)loadDataSource{
    [self showLoading];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableSet * set = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    [set addObject:@"html/text"];
    manager.responseSerializer.acceptableContentTypes = set;
    NSString * url = [NSString stringWithFormat:MEDETAILSAPI,_UID];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * data = responseObject[@"data"];
        NSDictionary * material = data[@"material"];
        //获取头视图
        NSString * imageUrl = material[@"image"];
        _Image = imageUrl;
        //解析内容
        NSArray * array1 = material[@"suitable_not_with"];
        NSMutableArray *result1 = [practiceModel4 arrayOfModelsFromDictionaries:array1 error:nil];
        [self.dataSource addObjectsFromArray:result1];
        _index = array1.count;
        NSLog( @"*******************%ld",(long)_index);
        NSArray * array2 = material[@"suitable_with"];
        _index1 = array2.count;
        NSMutableArray *result2 = [practiceModel4 arrayOfModelsFromDictionaries:array2 error:nil];
        [self.dataSource addObjectsFromArray:result2];
        NSLog( @"*******************%lu",(unsigned long)_dataSource.count);
        
        
        [self createTableView];
        [_tableView reloadData];
        [self endRereshing];
        [self hideLoading];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self hideLoading];
        [self showNetErrorTip];
        NSLog(@"不会失败的数据");
        
    }];
    
    
}

- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor blueColor];
    self.tableView.sectionHeaderHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200.0l;
    [self.tableView registerNib:[UINib nibWithNibName:@"practiceTableCell4" bundle:nil] forCellReuseIdentifier:@"practiceTableCell4"];
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 1){
        return _index;
    }
    return _index1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    practiceTableCell4 * cell = [tableView dequeueReusableCellWithIdentifier:@"practiceTableCell4" forIndexPath:indexPath];
    if (indexPath.section==1) {
        practiceModel4 * model = _dataSource[indexPath.row];
        [cell configDataModel:model];
    }else{
        practiceModel4 * model = _dataSource[indexPath.row+_index];
        [cell configDataModel:model];
    }
    
    
    return cell;
    
}

#pragma mark - 返回组头部标题和尾部标题
//- ( NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;



//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 50;
//}
//
//    NSLog(@"section================%ld",section);
//    switch (section) {
//        case 0:
//            return @"相克食材";
//            break;
//        case 1:
//            return @"相宜食材";
//            break;
//        default:
//            break;
//    }
//    return @"相宜食材";

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"相宜食材";
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [[UIView alloc] init];
    
    headerView.backgroundColor = [UIColor grayColor];
    //    UILabel * label = [[UILabel alloc]init];
    //    label.frame = CGRectMake(0, 0, headerView.bounds.size.height, headerView.bounds.size.width);
    ////    label.backgroundColor = [UIColor redColor];
    //    label.text = array[0];
    //    [headerView addSubview:label];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.  MEDETAILSAPI
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
