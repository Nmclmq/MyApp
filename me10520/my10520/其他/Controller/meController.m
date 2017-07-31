//
//  meController.m
//  个人项目
//
//  Created by qianfeng on 16/5/10.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "meController.h"
#import "LastTableViewCell.h"
#import "ViewControllerA.h"
#import "ViewControllerB.h"
#import "ViewControllerC.h"
#import "ViewControllerD.h"
#import "ViewControllerE.h"


@interface meController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UIImageView * headerImageView;
//@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) NSMutableArray * dataSource;


@end

@implementation meController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"其他";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.tableView];
    _tableView.tableHeaderView = self.headerView;
    NSLog(@"%@",self.headerImageView);
    [self.headerView addSubview:self.headerImageView];
    
    NSLog(@"=====%lf,%lf",self.tableView.frame.size.height,self.view.frame.size.height );
//    [self.headerView addSubview:self.label];
}
//- (void)awakeFromNib{
//    [super awakeFromNib];
//    self.tableView.tableFooterView = [[UIView alloc ]initWithFrame:CGRectZero];
//}

- (NSMutableArray *)dataSource{
    if(!_dataSource){
        NSArray * array =  @[@"操作提醒",@"关于我们",@"联系我们",@"免责声明",@"开发商"];
        _dataSource = [NSMutableArray arrayWithArray:array];

    }
    return _dataSource;
    
}

- (UITableView *)tableView{
    
    if(!_tableView){
        CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 49 );
//        _tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        _tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
            _tableView.estimatedRowHeight = 200.0l;
         [_tableView registerNib:[UINib nibWithNibName:@"LastTableViewCell" bundle:nil] forCellReuseIdentifier:@"identifier"];
        
        _tableView.tableFooterView = [[UIView alloc ]initWithFrame:CGRectZero];
       
    }
    return _tableView;
}

- (UIView *)headerView{
    if(!_headerView){
//        CGFloat temp = 900 / 1440;
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
        //        _headerView.backgroundColor = [UIColor redColor];
        _headerView.center = _tableView.tableHeaderView.center;
    }
    return _headerView;
    
}
//- (UILabel *)label{
//    if(!_label){
//        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//        _label.text = @"登录";
//        _label.textColor = [UIColor whiteColor];
//        _label.center = self.headerView.center;
//    }
//    return _label;
//}

- (UIImageView *)headerImageView{
    if(!_headerImageView){
        CGRect frame = self.view.bounds;
        _headerImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back1.jpg"]];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headerImageView.clipsToBounds = YES;
        
        _headerImageView.frame = CGRectMake(0, 0, frame.size.width, 200);
        _headerImageView.center = self.headerView.center;
        _headerImageView.backgroundColor = [UIColor greenColor];
        
    }
    return _headerImageView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LastTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    NSString * title = _dataSource[indexPath.row];
    cell.contentLabel.text = title;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGRect frame = self.headerView.frame;
    CGFloat offset = -scrollView.contentOffset.y;
//    NSLog(@"%lf",offset);
    if(offset > 0){
        frame.size.height += offset * 2; //323 500
        frame.size.width += 323/500 * offset * 2;
        self.headerImageView.frame = frame;
        CGPoint center = self.headerView.center;
        center.y -= offset;
        self.headerImageView.center = center;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    switch (indexPath.row) {
        case 0:
        {
            ViewControllerA *nvc = [[ViewControllerA alloc]init];
            [self.navigationController pushViewController:nvc animated:YES];
        }
            break;
        case 1:
        {
            ViewControllerB *nvc = [[ViewControllerB alloc]init];
            [self.navigationController pushViewController:nvc animated:YES];
        }
            break;
        case 2:
        {
            ViewControllerC *nvc = [[ViewControllerC alloc]init];
            [self.navigationController pushViewController:nvc animated:YES];
        }
            break;
        case 3:
        {
            ViewControllerD *nvc = [[ViewControllerD alloc]init];
            [self.navigationController pushViewController:nvc animated:YES];
        }
            break;
        case 4:
        {
            ViewControllerE *nvc = [[ViewControllerE alloc]init];
            [self.navigationController pushViewController:nvc animated:YES];
        }
            break;
            
        default:
            break;
    }
}
//
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
//
////- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
////{
////    UIView * headerView = [[UIView alloc] init];
////    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
////    return headerView;
////}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//

//---------





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
