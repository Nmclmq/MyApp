//
//  myViewController.m
//  个人项目
//
//  Created by qianfeng on 16/5/11.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "myViewController.h"
#import "myModel.h"
#import "myTableViewCell.h"
#import "AFNetworking.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#import "myViewControllerTwo.h"
#import "MJRefresh.h"
#import "cookViewController.h"
@interface myViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataSource;

//当前展示的页码
@property (nonatomic)NSInteger currentPage;
@end

@implementation myViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _itemTitle;
    self.view.backgroundColor = [UIColor colorWithRed:0.856 green:0.914 blue:1.000 alpha:1.000];
    _dataSource = [[NSMutableArray alloc]init];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
    //    [self createDataSource];
    //增加刷新空间
    [self createTableView];
    [self createRefeshView];
    [self.tableView.mj_header beginRefreshing];
}


- (void)createRefeshView{
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _currentPage = 1;
        //请求数据
        [self createDataSource];
    }];
    
    //上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _currentPage ++;
        //加载更多数据
        [self createDataSource];
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




- (void)createDataSource{
    [self showLoading];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableSet * set = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    [set addObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = set;
    NSString * url = [NSString stringWithFormat:touchIngredientsAPI,self.UID,(long)_currentPage];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * data = responseObject[@"data"];
        
        NSArray * array = data[@"data"];
        NSString * count = data[@"count"];
        NSLog(@"%@",count);
        //                NSMutableArray * resArray = [myModel arrayOfModelsFromDictionaries:array];
        //                [self.dataSource addObjectsFromArray:resArray];
        
        if ([count integerValue] == 6) {
            NSLog(@"请求成功");
            //转模型
            NSMutableArray *result = [myModel arrayOfModelsFromDictionaries:array error:nil];
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
    self.tableView.frame=CGRectMake (0,0,self.view.bounds.size.width,self.view.bounds.size.height - 64);
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"myTableViewCell" bundle:nil] forCellReuseIdentifier:@"myTableViewCell"];
    //    self.tableView.sectionHeaderHeight = 50;
    UIView * tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    tableHeaderView.backgroundColor = [UIColor colorWithRed:0.614 green:0.947 blue:1.000 alpha:1.000];
    self.tableView.tableHeaderView = tableHeaderView;
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.tableView.tableHeaderView.bounds];
    [self.tableView.tableHeaderView addSubview:imageView];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:_Image]];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    myTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"myTableViewCell"];
    myModel * model = self.dataSource[indexPath.row];
    [cell configDataModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cookViewController * cvc = [[cookViewController alloc]init];
    myModel * model = _dataSource[indexPath.row];
    cvc.UID = model.dishes_id;
    [self.navigationController pushViewController:cvc animated:YES];
    
    
    NSLog(@"再点一下你信不信我不干了食材里面的布局");
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
//设置视图后标题无效
//【注】头部视图和尾部视图创建可以没有frame，但是需要统一指定高度，或者动态的指定高度，没有高度不显示。
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithRed:0.512 green:0.898 blue:1.000 alpha:1.000];
    NSArray * array = @[@"菜谱",@"选购",@"营养",@"百科"];
    for (int i =0; i<4; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(i*kScreeWidth/4, 0, kScreeWidth/4, 30);
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+i;
        [headerView addSubview:button];
    }
    return headerView;
}
- (void)onClick:(UIButton *)button{
    switch (button.tag) {
        case 100:
        {
            NSLog(@"菜谱");
        }
            break;
        case 101:
        {
            myViewControllerTwo * mvc = [[myViewControllerTwo alloc]init];
            mvc.UID = _UID;
            mvc.itemTitle = @"选购";
            mvc.index = 1;
            [self.navigationController pushViewController:mvc animated:YES];
            NSLog(@"选购");
        }
            
            break;
        case 102:
        {
            myViewControllerTwo * mvc = [[myViewControllerTwo alloc]init];
            mvc.UID = _UID;
            mvc.itemTitle = @"营养";
            mvc.index = 2;
            [self.navigationController pushViewController:mvc animated:YES];
            NSLog(@"营养");
        }
            
            break;
        case 103:
        {
            myViewControllerTwo * mvc = [[myViewControllerTwo alloc]init];
            mvc.UID = _UID;
            mvc.itemTitle = @"百科";
            mvc.index = 3;
            [self.navigationController pushViewController:mvc animated:YES];
            NSLog(@"百科");
        }
            break;
        default:
            break;
    }
    
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
