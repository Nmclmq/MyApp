//
//  menuController.m
//  个人项目
//
//  Created by qianfeng on 16/5/10.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#import "menuController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "menuModel.h"
#import "menuCollectionViewCell.h"
#import "MNModel.h"
#import "meViewController.h"
#import "myViewController.h"

@interface menuController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UILabel * _label;
    UIView * _view;
    NSString * url;
    UIButton * button1;
    UIButton * button2;
    NSInteger _index;
}
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic)NSMutableArray * dataSource;
@property (nonatomic)NSMutableArray * data;
@end

@implementation menuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"菜谱";
    self.view.backgroundColor = [UIColor colorWithRed:0.800 green:0.904 blue:1.000 alpha:1.000];
    _index = 0;
    button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    _dataSource = [[NSMutableArray alloc]init];
    
    _data = [[NSMutableArray alloc]init];
    url =MenuAPI;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self createUiView];
    [self createDataSource];
    
}
//创建菜谱食材UIVIEW
- (void)createUiView{
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreeWidth,40)];
    _view.backgroundColor = [UIColor colorWithRed:0.782 green:0.969 blue:1.000 alpha:1.000];
    [self createButton];
    [self.view addSubview:_view];
}
//创建button
- (void)createButton{
    button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(0, 0, kScreeWidth/2, 40);
    [button1 setTitle:@"菜谱" forState:UIControlStateNormal];
    button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.frame = CGRectMake(kScreeWidth/2, 0, kScreeWidth/2, 40);
    [button2 setTitle:@"食材" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:17];
    button2.titleLabel.font = [UIFont systemFontOfSize:17];
    [button1 addTarget:self action:@selector(caipubutton:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(shicaipubutton:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
    [_view addSubview:button1];
    [_view addSubview:button2];
    
}

- (void)caipubutton:(UIButton *)button{
    NSLog(@"我是菜谱");
    _index = 0;
    url =MenuAPI;
    _dataSource = [[NSMutableArray alloc]init];
    [_collectionView reloadData];
    _data = [[NSMutableArray alloc]init];
    [button1 setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [self createDataSource];
}

- (void)shicaipubutton:(UIButton *)button{
    NSLog(@"我是食材");
    _index = 1;
    url =  IngredientsAPI;
    _dataSource = [[NSMutableArray alloc]init];
    _data = [[NSMutableArray alloc]init];
    [_collectionView reloadData];
    [button1 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
    [self createDataSource];
    
}

- (void)createDataSource{
    [self showLoading];
    [_collectionView reloadData];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableSet * set = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    [set addObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = set;
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * pdata = responseObject[@"data"];
        
        _data = pdata[@"data"];
        for (NSDictionary * item in _data) {
            
            menuModel * model = [[menuModel alloc]init];
            model.text = item[@"text"];
            NSArray * array = item[@"data"];
            for (NSDictionary * dic in array) {
                MNModel * mdel = [[MNModel alloc]init];
                mdel.text = dic[@"text"];
                mdel.MID = dic[@"id"];
                mdel.image = dic[@"image"];
                [model.data addObject:mdel];
            }
            //            NSLog(@"%@",model);
            
            [self.dataSource addObject:model];
        }
        
        [self hideLoading];
        [self createCollectionView];
        [_collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hideLoading];
        [self showNetErrorTip];
        NSLog(@"失败了啊");
    }];
}

- (void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //    layout.headerReferenceSize = CGSizeMake(320, 100);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height-40) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor colorWithRed:0.768 green:1.000 blue:0.964 alpha:1.000];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"menuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CellIdentifier"];
    
    [_collectionView registerClass:[menuCollectionViewCell class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CellIdentifier"];
    [self.view addSubview:_collectionView];
}







// 指定Section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //    float n ;
    //    if(_index==0){
    //        n =_dataSource.count-1;
    //    }else{
    //    n =_dataSource.count;
    //    }
    return _dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    menuModel *model = self.dataSource[section];
    return model.data.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    menuModel *model = self.dataSource[indexPath.section];
    //    _label.text = model.text;
    menuCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    MNModel * mdel = model.data[indexPath.row];
    [cell configDataModel:mdel];
    
    //    cell.backgroundColor = [UIColor colorWithRed:0.826 green:1.000 blue:0.742 alpha:1.000];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(150)/50.0 green:arc4random_uniform(150)/50.0 blue:arc4random_uniform(150)/50.0 alpha:1];
    
    cell.layer.cornerRadius = 15;
    return cell;
}

//- (void)createLabel{
//    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
//    _label.backgroundColor = [UIColor purpleColor];
//}
//设置collectionview cell中间的头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        UICollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor colorWithRed:0.847 green:1.000 blue:0.487 alpha:1.000];
        
        reusableview = headerView;
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, reusableview.frame.size.width, 20)];
        _label.backgroundColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        [reusableview addSubview:_label];
        
    }
    
    menuModel *model = self.dataSource[indexPath.section];
    _label.text = model.text;
    
    return reusableview;
}




//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UIView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:findCollectionViewSectionHeaderIdentifier forIndexPath:indexPath];
//    return headerView;
//}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //    CGFloat w = (self.view.frame.size.width-15) / 2;
    return CGSizeMake((kScreeWidth-10)/5 ,30);
}

// 设置每个cell上下左右相距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 0, 20, 0);
}



// 设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

// 设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 20);
}
//// 设置section尾视图的参考大小，与tablefooterview类似
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeMake(self.view.frame.size.width, 44);
//}

// 选中操作
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(_index ==0){
        meViewController * mvc = [[meViewController alloc]init];
        menuModel * model = _dataSource[indexPath.section];
        MNModel * mdel = model.data[indexPath.row];
        mvc.UID = mdel.MID;
        mvc.itemTitle = mdel.text;
        NSLog(@"%@",mdel.MID);
        [self.navigationController pushViewController:mvc animated:YES];
    }
    if(_index ==1){
        myViewController * mv = [[myViewController alloc]init];
        menuModel * model = _dataSource[indexPath.section];
        MNModel * mdel = model.data[indexPath.row];
        mv.UID = mdel.MID;
        mv.itemTitle = mdel.text;
        mv.Image = mdel.image;
        [self.navigationController pushViewController:mv animated:YES];
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
