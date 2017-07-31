//
//  HomeViewController.m
//  美食阅
//
//  Created by NMC on 02/12/2016.
//  Copyright © 2016 NieManCang. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionViewCell.h"
static NSString *headerViewIdentifier = @"hederview";
@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}


- (NSMutableArray *)dataSource{
    if(!_dataSource){
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (UICollectionView *)collectionView{
    
    CGRect frame = self.view.bounds;
    CGFloat W = frame.size.width;
    CGFloat H = frame.size.height;
    if(!_collectionView){
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.headerReferenceSize = CGSizeMake(W, 350);
        _collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
        //注册单元格
//        [_collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forSupplementaryViewOfKind:<#(nonnull NSString *)#> withReuseIdentifier:<#(nonnull NSString *)#>]
        
        [_collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
        
        //注册头视图
//        [_collectionView registerNib:[UICollectionReusableView class] forCellWithReuseIdentifier:headerViewIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeViewController * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    return cell;
}
/*
 
 
 UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
 layout.minimumLineSpacing=20; //设置每一行的间距
 layout.itemSize=CGSizeMake(100, 100);  //设置每个单元格的大小
 layout.sectionInset=UIEdgeInsetsMake(0, 0, 50, 0);
 layout.headerReferenceSize=CGSizeMake(self.view.frame.size.width, 250); //设置collectionView头视图的大小
 
 UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
 collectionView.frame=self.view.bounds;
 //注册cell单元格
 [collectionView registerNib:[UINib nibWithNibName:@"ConstomCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
 //注册头视图
 [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier];
 
 collectionView.backgroundColor=[UIColor whiteColor];
 collectionView.delegate=self;
 collectionView.dataSource=self;
 [self.view addSubview:collectionView];
 
 
 */

/* UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
 //    layout.headerReferenceSize = CGSizeMake(320, 100);
 _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height-40) collectionViewLayout:layout];
 _collectionView.backgroundColor = [UIColor colorWithRed:0.768 green:1.000 blue:0.964 alpha:1.000];
 _collectionView.delegate = self;
 _collectionView.dataSource = self;
 //    _collectionView.backgroundColor = [UIColor whiteColor];
 [_collectionView registerNib:[UINib nibWithNibName:@"menuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CellIdentifier"];
 
 [_collectionView registerClass:[menuCollectionViewCell class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CellIdentifier"];
 [self.view addSubview:_collectionView];
*/

@end
