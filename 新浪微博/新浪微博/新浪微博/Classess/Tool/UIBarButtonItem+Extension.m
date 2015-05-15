//
//  HLTitleButton.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/25.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (instancetype)itemWithImg:(NSString *)img highImg:(NSString *)highImg target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImg] forState:UIControlStateHighlighted];
//    button.size = button.currentBackgroundImage.size;
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //为了让导航按钮有高亮图片显示，使用initWithCustomView这个方法可以传入一个View，我们传入button即可。
    return [[self alloc] initWithCustomView:button];
}
@end
