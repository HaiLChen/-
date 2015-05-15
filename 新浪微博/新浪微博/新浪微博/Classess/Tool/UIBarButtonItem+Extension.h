//
//  HLTitleButton.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/25.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**
 *  通过一个按钮创建一个UIBarButtonItem
 *
 *  @param bg     背景图片
 *  @param highBg 高亮背景图片
 *  @param target 谁来监听按钮点击
 *  @param action 点击按钮会调用的方法
 */
+ (instancetype)itemWithImg:(NSString *)img highImg:(NSString *)highImg target:(id)target action:(SEL)action;
@end
