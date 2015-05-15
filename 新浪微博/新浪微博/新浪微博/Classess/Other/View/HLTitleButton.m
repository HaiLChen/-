//
//  HLTitleButton.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/25.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "HLTitleButton.h"
#import "UIView+Extension.h"
@implementation HLTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}

#pragma mark - 设置文字基本属性
- (void)setup
{
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:18.0];
}


@end
