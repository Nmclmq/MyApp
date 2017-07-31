//
//  cookViewController.m
//  个人项目
//
//  Created by qianfeng on 16/5/15.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "cookViewController.h"
#import "cookModel.h"
#import "cookTableCell.h"
#import "AFNetworking.h"
#import "Header.h"
#import "practiceController.h"
#import "practiceController1.h"


@interface cookViewController ()<UITableViewDataSource,UITableViewDelegate,pushNext>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataSource;

@end

@implementation cookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc]init];
    self.title = @"菜肴介绍";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    //    [self createTableView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self loadDataSource];
    //    self.navigationController.navigationBarHidden=NO;
}


- (void)loadDataSource{
    [self showLoading];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableSet * set = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    [set addObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = set;
    NSString * url = [NSString stringWithFormat:neibuAPI,_UID];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        cookModel * model = [[cookModel alloc]init];
        NSDictionary * data = responseObject[@"data"];
        model.image = data[@"image"];
        model.dishes_title = data[@"dishes_title"];
        model.material_desc = data[@"material_desc"];
        model.hard_level = data[@"hard_level"];
        model.cooke_time = data[@"cooke_time"];
        model.taste = data[@"taste"];
        [self.dataSource addObject:model];
        
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
    //
    
    //    [self.tableView registerNib:[UINib nibWithNibName:@"cookTableCell" bundle:nil] forCellReuseIdentifier:@"cookTableCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"cookTableCell" bundle:nil] forCellReuseIdentifier:@"cookTableCell"];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (void)pushNextController {
    //    practiceController *pc = [[practiceController alloc]init];
    //    [self.navigationController pushViewController:pc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cookTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cookTableCell"];
    cookModel * model = self.dataSource[indexPath.row];
    
    cell.PID = _UID;
    cell.delegate = self;
    cell.block = ^(NSString * str){
        NSLog(@"%@",str);
        
        practiceController *nvc = [[practiceController alloc]init];
        //        practiceController1 *nvc1 = [[practiceController1 alloc]init];
        nvc.UID = _UID;
        //        FuckViewController *fc = [[FuckViewController alloc]init];
        
        [self.navigationController pushViewController:nvc animated:YES];
        
    };
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
