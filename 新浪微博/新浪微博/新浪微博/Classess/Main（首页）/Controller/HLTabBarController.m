//
//  HLTabBarController.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/24.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "HLTabBarController.h"
#import "HLMainController.h"
#import "HLMessageController.h"
#import "HLDiscoverController.h"
#import "HLMineController.h"
#import "HLTabBar.h"

#define KrandomColor [UIColor colorWithRed:arc4random_uniform(255) / 255.0 \
                                     green:arc4random_uniform(255) / 255.0 \
                                      blue:arc4random_uniform(255) / 255.0 \
                                     alpha:1];
@interface HLTabBarController ()

@end

@implementation HLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置视图方法
    
    //1.设置首页
    [self setTabBarVcWithVc:[[HLMainController alloc] init]
                      title:@"首页"
                      image:@"tabbar_main"
                selectImage:@"tabbar_main_selected"];
    
    //2.设置消息页
    [self setTabBarVcWithVc:[[HLMessageController alloc] init]
                      title:@"消息"
                      image:@"tabbar_message_center"
                selectImage:@"tabbar_message_center_selected"];
    
    //3.设置发现页
    [self setTabBarVcWithVc:[[HLDiscoverController alloc] init]
                      title:@"发现"
                      image:@"tabbar_discover"
                selectImage:@"tabbar_discover_selected"];
    
    //4.设置 我 页
    [self setTabBarVcWithVc:[[HLMineController alloc] init]
                      title:@"我"
                      image:@"tabbar_mine"
                selectImage:@"tabbar_mine_selected"];
    
    //利用KVC将系统的赋值给自定义的tabBar
    [self setValue:[[HLTabBar alloc] init] forKeyPath:@"tabBar"];
}


#pragma 设置视图方法
//设置主界面
- (void)setTabBarVcWithVc:(UITableViewController *)vc
                    title:(NSString *)title
                    image:(NSString *)image
              selectImage:(NSString *)selectImage
{
    //设置tabBar按钮字体颜色
    [vc.tabBarItem setTitleTextAttributes:@{
                                            NSForegroundColorAttributeName : [UIColor orangeColor]
                                            }
                                 forState:UIControlStateSelected];
    [vc.tabBarItem setTitleTextAttributes:@{
                                            NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                            }
                                 forState:UIControlStateNormal];
    //设置属性
    vc.title = title;
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    vc.tabBarItem.image = [UIImage imageNamed:image];
    
    //设置随机色
    vc.view.backgroundColor = KrandomColor;
    //创建导航控制器并且添加子视图
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}
@end
