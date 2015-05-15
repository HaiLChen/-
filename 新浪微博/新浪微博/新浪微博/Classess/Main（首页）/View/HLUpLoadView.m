//
//  HLUpLoadView.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/5/4.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "HLUpLoadView.h"

@implementation HLUpLoadView

+ (UIView *)footer
{
    UIView *upLoadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    UILabel *loadLabel = [[UILabel alloc] initWithFrame:upLoadView.bounds];
    loadLabel.text = @"正在努力加载......";
    loadLabel.textAlignment = NSTextAlignmentCenter;
    [upLoadView addSubview:loadLabel];
    return upLoadView;
}

@end
