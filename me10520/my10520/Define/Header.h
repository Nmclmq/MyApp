//
//  Header.h
//  个人项目
//
//  Created by qianfeng on 16/5/10.
//  Copyright © 2016年 NieManCang. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define TAB_HEIGHT 64
#define kScreeWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//主页接口

#define HomePageAPI @"http://api.izhangchu.com/?methodName=HomeIndex&version="

//热门推荐
#define HomePageHotAPI @"http://api.izhangchu.com/?type=1&page=%ld&token=0&methodName=HomeMore&size=10&version=1.0"
//http://api.izhangchu.com/?type=2&page=4&token=0&methodName=HomeMore&size=10&version=1.0
//新品推荐
#define HomePageNewsAPI @"http://api.izhangchu.com/?type=2&page=%ld&token=0&methodName=HomeMore&size=10&version=1.0"

//排行榜
#define HomePageRankingAPI @"http://api.izhangchu.com/?page=%ld&methodName=TopList&size=10&version=4.02&"
//菜系接口
#define CuisineAPI @"http://api.izhangchu.com/?page=2&methodName=HomeSerial&size=10&version=1.0&serial_id=%ld"
//热门推荐
//做法
#define HotAPI @"http://api.izhangchu.com/?user_id=&token=&methodName=DishesView&dishes_id=%@&version=1.0"
//菜谱
#define MenuAPI @"http://api.izhangchu.com/?methodName=CategoryIndex&version=4.02&"
//点击菜谱
#define touchMenuAPI @"http://api.izhangchu.com/?cat_id=%@&page=%ld&token=&user_id=&type=1&methodName=CategorySearch&size=10&version=1.0"

//食材
#define IngredientsAPI @"http://api.izhangchu.com/?methodName=MaterialSubtype&version=4.02&"
//点击食材
#define touchIngredientsAPI @"http://api.izhangchu.com/?material_id=%@&methodName=MaterialDishes&page=%ld&size=6&version=1.0"
//选购 营养 百科
#define touchDetailedAPI @"http://api.izhangchu.com/?material_id=%@&methodName=MaterialView&version=1.0"


//排行榜
#define neibuAPI @"http://api.izhangchu.com/?user_id=&token=&methodName=DishesView&dishes_id=%@&version=1.0"

//详情做法
#define MECOOKAPI @"http://api.izhangchu.com/?user_id=&token=&methodName=DishesView&dishes_id=%@&version=1.0"
//详情食材
#define MEINGREDIENTSAPI @"http://api.izhangchu.com/?user_id=&token=&methodName=DishesMaterial&dishes_id=%@&version=1.0"
//详情相关知识
#define  MERELEVANTAPI @"http://api.izhangchu.com/?user_id=&token=&methodName=DishesCommensense&dishes_id=%@&version=1.0"
//详情相克相宜
#define MEDETAILSAPI @"http://api.izhangchu.com/?user_id=&token=&methodName=DishesSuitable&dishes_id=%@&version=1.0"
#define SHAKEAPI @"http://api.izhangchu.com/?type=2&page=%ld&token=0&methodName=HomeMore&size=10&version=1.0"

#endif /* Header_h */
