//
//  HLTabBar.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/24.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "HLTabBar.h"
#import "HLSendController.h"

@interface HLTabBar ()
//中间的加号按钮
@property (nonatomic, weak) UIButton *plusBtn;
@end

@implementation HLTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        NSLog(@"%s",__func__);
        [self setPlusBtn];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    NSLog(@"%s",__func__);
    //索引
    int index = 0;
    
    CGFloat btnW = self.frame.size.width / 5;
    CGFloat btnH = self.frame.size.height;
    
    for (UIView *child in self.subviews) {
        //调用方法时我们自定义的按钮已经添加进去了，所以要用if去掉。因为UITabBarItem不让用，我们就用他的父类判断
        if (![child isKindOfClass:[UIButton class]] && [child isKindOfClass:[UIControl class]]) {
            CGFloat btnX = index * btnW;
            child.frame = CGRectMake(btnX, 0, btnW, btnH);
            index ++;
            if (index == 2) {
                index ++;
            }
        }
    }
    self.plusBtn.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    [self.plusBtn sizeToFit];
}
#pragma 添加加号按钮

- (void)setPlusBtn
{
    UIButton *plusBtn = [[UIButton alloc] init];
    //设置按钮的图片属性
    [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"]
                  forState:UIControlStateNormal];
    [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"]
                  forState:UIControlStateNormal];
    
    //设置按钮的背景图
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"]
                            forState:UIControlStateNormal];
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"]
                            forState:UIControlStateHighlighted];
    [plusBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:plusBtn];
    self.plusBtn = plusBtn;
}

#pragma mark - 点击底部中间按钮

- (void)sendMessage
{
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    HLSendController *sendVc = [[HLSendController alloc] init];
    [root presentViewController:[[UINavigationController alloc] initWithRootViewController:sendVc] animated:YES completion:nil];

}
@end
