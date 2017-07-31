//
//  PushView.m
//  UIDynamicDemo
//
//  Created by baoxu on 16/5/7.
//  Copyright © 2016年 BaoXu. All rights reserved.
//

#import "PushView.h"
#import "AFNetworking.h"
#import "Header.h"
#import "practiceController.h"
@interface PushView ()
{
    //记录第一次点击的点
    CGPoint _beganPoint;
    //记录移动过程当中的点
    CGPoint _movePoint;
    
    //橡皮筋头
    UIImageView *_imageView;
    
    //推动行为
    UIPushBehavior *_push;
    UIButton * button;
    UIButton * button1;
    UIButton * button2;
    UIButton * button3;
    UIButton * button4;
    UIButton * button5;
    NSString * indexID;
    NSString * indexID1;
    NSString * indexID2;
    NSString * indexID3;
    NSString * indexID4;
    NSString * indexID5;
    NSMutableArray * _dataSource;
    NSInteger _numberOne;
}
@end

@implementation PushView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _dataSource = [[NSMutableArray alloc]init];
        
        // 0.准备工作
        // 更改一下box状态
        
        self.box.center = CGPointMake(self.center.x, 100);
        self.box.layer.cornerRadius = 50;
        //self.box.transform = CGAffineTransformMakeRotation(M_PI_4);
        self.box.image = [UIImage imageNamed:@"32FA8141-6B0F-4CD1-BCAE-EFE8EBDDF002.jpg"];
        self.box.layer.masksToBounds = YES;

        
        [self createButton];
        
        
        [self createNewLayer];
        // 1.定义一个手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
        
        // 2.添加橡皮筋
        UIImage *image = [UIImage imageNamed:@"AttachmentPoint"];
        _imageView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:_imageView];
        _imageView.hidden = YES;
        
        // 3.添加推动行为
        _push = [[UIPushBehavior alloc]initWithItems:@[self.box] mode:UIPushBehaviorModeInstantaneous];
        [self.animator addBehavior:_push];
        
        // 4.添加碰撞检测
        UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:@[self.box,button,button1,button2,button3,button4,button5]];
        // 是否与参照视图的bounds为边界
        collision.translatesReferenceBoundsIntoBoundary = YES;
//        [self.animator addBehavior:collision];
        
        
        UIView * redView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-44, kScreeWidth, 1)];
        redView.backgroundColor = [UIColor redColor];
        [self addSubview:redView];
        CGFloat toX = redView.frame.size.width;
        CGFloat toY = redView.frame.size.height+redView.frame.origin.y;
        [collision addBoundaryWithIdentifier:@"redView" fromPoint:redView.frame.origin toPoint:CGPointMake(toX, toY)];
//        collision.collisionDelegate = self;
        [self.animator addBehavior:collision];
        
        
        
        //设置物体属性行为
        UIDynamicItemBehavior * item = [[UIDynamicItemBehavior alloc]initWithItems:@[self.box,button,button1,button2,button3,button4,button5]];
        
        //弹力系数(0-1)0是不弹 1是停不下来
        item.elasticity = 1.0;
        
        [self.animator addBehavior:item];

        
        
        
        
        
        
        // ios7后，添加了对视图颜色处理的功能，过滤图片颜色
        _imageView.tintColor = [UIColor blueColor];
        _imageView.image = [_imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    }
    return self;
}

// 手势响应
-(void)pan:(UIPanGestureRecognizer*)recognizer{
    
    _numberOne = 1;
    // 取到手势锁在的点
    CGPoint location = [recognizer locationInView:self];
//    [button setTitle:@"都比" forState:UIControlStateNormal];
    // 判断一下当前是怎么动的，开始，拖动中，松手
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // 记录起点，方便画图
        _beganPoint = location;
        
        // 添加图像标记起点位置
        _imageView.hidden = NO;
        _imageView.center = location;
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        _movePoint = location;
        // 调用绘图方法
        [self setNeedsDisplay];
        
    }else if (recognizer.state == UIGestureRecognizerStateEnded){
        /**
         *  1.推的方向
            2.推的力量
            3.行为生效
         */
        CGPoint endPoint = location;
        CGPoint offset = CGPointMake(_beganPoint.x - endPoint.x, _beganPoint.y - endPoint.y);
        
        //方向,角度计算（Y/X）
        CGFloat angle = atan2(offset.y, offset.x);
        _push.angle = angle;
        
        //力量，力量与拉伸长度（对角线）成正比，所以开平方计算
        CGFloat distance = sqrtf(offset.x * offset.x + offset.y * offset.y);
        //推动行为的力量属性
        _push.magnitude = distance*0.08;
        
        //对于单次的推动，需要设置下面的属性
        _push.active = YES;
        
        // 清理工作
        _imageView.hidden = YES;
        _beganPoint = CGPointZero;
        _movePoint = CGPointZero;
        
        
        [self setNeedsDisplay];
    }
}



- (void)drawRect:(CGRect)rect {
    // Drawing code
    // 1.获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 2.设置路径
    // 起点
    CGContextMoveToPoint(context, _beganPoint.x, _beganPoint.y);
    // 终点
    CGContextAddLineToPoint(context, _movePoint.x, _movePoint.y);
//    NSLog(@"我的天啊");
    // 线状态
    CGContextSetLineWidth(context, 5);
    [[UIColor darkGrayColor] set];
    CGFloat lenths[] = {20,5};
    CGContextSetLineDash(context, 0, lenths, 2);
    button.backgroundColor = [UIColor colorWithRed:0.859 green:0.994 blue:1.000 alpha:1.000];
     button1.backgroundColor = [UIColor colorWithRed:0.859 green:0.994 blue:1.000 alpha:1.000];
     button2.backgroundColor = [UIColor colorWithRed:0.859 green:0.994 blue:1.000 alpha:1.000];
    button3.backgroundColor = [UIColor colorWithRed:0.859 green:0.994 blue:1.000 alpha:1.000];
    button4.backgroundColor = [UIColor colorWithRed:0.859 green:0.994 blue:1.000 alpha:1.000];
    button5.backgroundColor = [UIColor colorWithRed:0.859 green:0.994 blue:1.000 alpha:1.000];

    // 绘图
    CGContextDrawPath(context, kCGPathStroke);
    
    [self loadDataSource:arc4random()%20];
    NSLog(@"%u",arc4random()%20);
}
- (void)click:(UIButton *)btn{
//    practiceController *nvc = [[practiceController alloc]init];
    //        practiceController1 *nvc1 = [[practiceController1 alloc]init];

    //        FuckViewController *fc = [[FuckViewController alloc]init];
    
    if (_numberOne ==1) {
        switch (btn.tag) {
            case 100:
            {
                NSLog(@"%@",indexID);
                //            nvc.UID =
                [self.delegate pushNextController:indexID ];
            }
                break;
            case 101:
            {
                NSLog(@"%@",indexID1);
                [self.delegate pushNextController:indexID1 ];
            }
                break;
            case 102:
            {
                NSLog(@"%@",indexID2);
                [self.delegate pushNextController:indexID2 ];
            }
                break;
            case 103:
            {
                NSLog(@"%@",indexID3);
                [self.delegate pushNextController:indexID3 ];
            }
                break;
            case 104:
            {
                NSLog(@"%@",indexID4);
                [self.delegate pushNextController:indexID4 ];
            }
                break;
            case 105:
            {
                NSLog(@"%@",indexID5);
                [self.delegate pushNextController:indexID5 ];
            }
                break;
                
            default:
                break;
        }

    }

    //    [self present];
//    [self.navigationController pushViewController:nvc animated:YES];
}


- (void)loadDataSource:(NSInteger)page{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableSet * set = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    [set addObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = set;
    NSString * url = [NSString stringWithFormat:SHAKEAPI,(long)page];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _numberOne =1;
        NSDictionary * data = responseObject[@"data"];
        NSArray * array = data[@"data"];
        NSInteger number =0;
        for (NSDictionary * dict in array) {
            
            number ++;
//            NSInteger a = arc4random()%3;
//            NSInteger b = arc4random()%3+4;
//            NSInteger c = arc4random()%3+7;
            switch (number) {
                case 1:
                {
                   [button setTitle:dict[@"title"] forState:UIControlStateNormal];
                    indexID = dict[@"id"];
                    
                    
                }
                    break;
                    
                case 2:
                {
                    [button1 setTitle:dict[@"title"] forState:UIControlStateNormal];
                    
                    indexID1 = dict[@"id"];
                    
                }
                    break;
                case 3:
                {
                    [button2 setTitle:dict[@"title"] forState:UIControlStateNormal];
                   
                    indexID2 = dict[@"id"] ;
                    
                }
                    break;
                case 4:
                {
                    [button3 setTitle:dict[@"title"] forState:UIControlStateNormal];
                   indexID3 = dict[@"id"];
                    
                    
                }
                    break;
                case 5:
                {
                    [button4 setTitle:dict[@"title"] forState:UIControlStateNormal];
                   indexID4 = dict[@"id"];
                    
                    
                }
                    break;
                case 6:
                {
                    [button5 setTitle:dict[@"title"] forState:UIControlStateNormal];
                    
                    indexID5 = dict[@"id"];
                    
                }
                    break;
                default:
                    break;
            }
        }
        
        
//        [button setTitle:@"都比" forState:UIControlStateNormal];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
    }];
}


- (void)createButton{
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake((kScreeWidth-255)/4, 330, 85, 85);
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    //        button.cornerRadius = 15;
    button.layer.cornerRadius = 50;
    button.titleLabel.numberOfLines=0;
    [button setTitle:@"撞撞出菜谱" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blackColor]];
    //        button.backgroundColor = [UIColor redColor];
    [self addSubview:button];
    
    button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(2*(kScreeWidth-255)/4+85, 330, 85, 85);
    [button1 setBackgroundColor:[UIColor blackColor]];
    button1.layer.cornerRadius = 50;
    button1.titleLabel.font = [UIFont systemFontOfSize:17];
    [button1 setTitle:@"撞撞出菜谱" forState:UIControlStateNormal];
    button1.titleLabel.numberOfLines=0;
    //        button.backgroundColor = [UIColor redColor];
    [self addSubview:button1];
    
    button2.titleLabel.font = [UIFont systemFontOfSize:17];
    button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.frame = CGRectMake(3*(kScreeWidth-255)/4+170, 330, 85, 85);
    [button2 setBackgroundColor:[UIColor blackColor]];
    button2.layer.cornerRadius = 50;
    [button2 setTitle:@"撞撞出菜谱" forState:UIControlStateNormal];
    button2.titleLabel.numberOfLines=0;
    //        button.backgroundColor = [UIColor redColor];
    [self addSubview:button2];
    
    button3.titleLabel.font = [UIFont systemFontOfSize:17];
    button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    button3.frame = CGRectMake((kScreeWidth-255)/4, 200, 85, 85);
    [button3 setBackgroundColor:[UIColor blackColor]];
    button3.layer.cornerRadius = 50;
    [button3 setTitle:@"撞撞出菜谱" forState:UIControlStateNormal];
    button3.titleLabel.numberOfLines=0;
    //        button.backgroundColor = [UIColor redColor];
    [self addSubview:button3];
    
    
    button4.titleLabel.font = [UIFont systemFontOfSize:17];
    button4 = [UIButton buttonWithType:UIButtonTypeSystem];
    button4.frame = CGRectMake(2*(kScreeWidth-255)/4+85, 200, 85, 85);
    [button4 setBackgroundColor:[UIColor blackColor]];
    button4.layer.cornerRadius = 50;
    [button4 setTitle:@"撞撞出菜谱" forState:UIControlStateNormal];
    button4.titleLabel.numberOfLines=0;
    //        button.backgroundColor = [UIColor redColor];
    [self addSubview:button4];
    
    button5.titleLabel.font = [UIFont systemFontOfSize:17];
    button5 = [UIButton buttonWithType:UIButtonTypeSystem];
    button5.frame = CGRectMake(3*(kScreeWidth-255)/4+170, 200, 85, 85);
    [button5 setBackgroundColor:[UIColor blackColor]];
    button5.layer.cornerRadius = 50;
    [button5 setTitle:@"撞撞出菜谱" forState:UIControlStateNormal];
    button5.titleLabel.numberOfLines=0;
    //        button.backgroundColor = [UIColor redColor];
    [self addSubview:button5];
    

        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [button1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [button2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [button3 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [button4 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [button5 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    
    button.tag = 100;
    button1.tag = 101;
    button2.tag = 102;
    button3.tag = 103;
    button4.tag = 104;
    button5.tag = 105;

}


- (void)createNewLayer{
    
    button.layer.borderWidth = 5;
    button.layer.borderColor =  [UIColor colorWithRed:arc4random_uniform(150)/50.0 green:arc4random_uniform(150)/50.0 blue:arc4random_uniform(150)/50.0 alpha:1].CGColor;
    button.layer.cornerRadius = button.bounds.size.width/2;;
    //超出边框的内容剪裁掉 (注意阴影也会被裁掉 因为阴影在边框外)
    button.layer.masksToBounds = YES;
    
    button.layer.shadowOffset = CGSizeMake(20, 20);
//    button.layer.shadowColor = [UIColor redColor].CGColor;
    button.layer.shadowOpacity = 0.5;
    
    
    button.layer.borderWidth = 5;
    button.layer.borderColor =  [UIColor colorWithRed:arc4random_uniform(255)/256.0 green:arc4random_uniform(255)/256.0 blue:arc4random_uniform(255)/256.0 alpha:1].CGColor;
    button.layer.cornerRadius = button.bounds.size.width/2;;
    //超出边框的内容剪裁掉 (注意阴影也会被裁掉 因为阴影在边框外)
    button.layer.masksToBounds = YES;
    
    button.layer.shadowOffset = CGSizeMake(20, 20);
//    button.layer.shadowColor = [UIColor redColor].CGColor;
    button.layer.shadowOpacity = 0.5;
    
    button1.layer.borderWidth = 5;
    button1.layer.borderColor =  [UIColor colorWithRed:arc4random_uniform(255)/256.0 green:arc4random_uniform(255)/256.0 blue:arc4random_uniform(255)/256.0 alpha:1].CGColor;
    button1.layer.cornerRadius = button.bounds.size.width/2;;
    //超出边框的内容剪裁掉 (注意阴影也会被裁掉 因为阴影在边框外)
    button1.layer.masksToBounds = YES;
    
    button1.layer.shadowOffset = CGSizeMake(20, 20);
//    button1.layer.shadowColor = [UIColor redColor].CGColor;
    button1.layer.shadowOpacity = 0.5;
    
    
    button2.layer.borderWidth = 5;
    button2.layer.borderColor =  [UIColor colorWithRed:arc4random_uniform(255)/256.0 green:arc4random_uniform(255)/256.0 blue:arc4random_uniform(255)/256.0 alpha:1].CGColor;
    button2.layer.cornerRadius = button.bounds.size.width/2;;
    //超出边框的内容剪裁掉 (注意阴影也会被裁掉 因为阴影在边框外)
    button2.layer.masksToBounds = YES;
    
    button2.layer.shadowOffset = CGSizeMake(20, 20);
//    button2.layer.shadowColor = [UIColor redColor].CGColor;
    button2.layer.shadowOpacity = 0.5;
    
    
    button3.layer.borderWidth = 5;
    button3.layer.borderColor =  [UIColor colorWithRed:arc4random_uniform(255)/256.0 green:arc4random_uniform(255)/256.0 blue:arc4random_uniform(255)/256.0 alpha:1].CGColor;
    button3.layer.cornerRadius = button.bounds.size.width/2;;
    //超出边框的内容剪裁掉 (注意阴影也会被裁掉 因为阴影在边框外)
    button3.layer.masksToBounds = YES;
    
    button3.layer.shadowOffset = CGSizeMake(20, 20);
//    button3.layer.shadowColor = [UIColor redColor].CGColor;
    button3.layer.shadowOpacity = 0.5;
    
    
    button4.layer.borderWidth = 5;
    button4.layer.borderColor =  [UIColor colorWithRed:arc4random_uniform(255)/256.0 green:arc4random_uniform(255)/256.0 blue:arc4random_uniform(255)/256.0 alpha:1].CGColor;
    button4.layer.cornerRadius = button.bounds.size.width/2;;
    //超出边框的内容剪裁掉 (注意阴影也会被裁掉 因为阴影在边框外)
    button4.layer.masksToBounds = YES;
    
    button4.layer.shadowOffset = CGSizeMake(20, 20);
//    button4.layer.shadowColor = [UIColor redColor].CGColor;
    button4.layer.shadowOpacity = 0.5;
    
    
    button5.layer.borderWidth = 5;
    button5.layer.borderColor = [UIColor colorWithRed:arc4random_uniform(255)/256.0 green:arc4random_uniform(255)/256.0 blue:arc4random_uniform(255)/256.0 alpha:1].CGColor;
    button5.layer.cornerRadius = button.bounds.size.width/2;;
    //超出边框的内容剪裁掉 (注意阴影也会被裁掉 因为阴影在边框外)
    button5.layer.masksToBounds = YES;
    
    button5.layer.shadowOffset = CGSizeMake(20, 20);
//    button5.layer.shadowColor = [UIColor colorWithRed:arc4random_uniform(150)/50.0 green:arc4random_uniform(150)/50.0 blue:arc4random_uniform(150)/50.0 alpha:1].CGColor;
    button5.layer.shadowOpacity = 0.5;
    
    
}
@end
