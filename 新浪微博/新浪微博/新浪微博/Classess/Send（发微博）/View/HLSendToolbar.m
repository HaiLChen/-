//
//  HLSendToolbar.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/5/6.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "HLSendToolbar.h"
#import "UIView+Extension.h"

@implementation HLSendToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置背景图
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        //拍照
        [self addBtn:@"compose_camerabutton_background" hightImage:@"compose_camerabutton_background_highlighted" type:HLSendToolbarButtonTypeCamera];
        //相册
        [self addBtn:@"compose_toolbar_picture" hightImage:@"compose_toolbar_picture_highlighted" type:HLSendToolbarButtonTypePicture];
        //@
        [self addBtn:@"compose_mentionbutton_background" hightImage:@"compose_mentionbutton_background_highlighted" type:HLSendToolbarButtonTypeMention];
        //#
        [self addBtn:@"compose_trendbutton_background" hightImage:@"compose_trendbutton_background_highlighted" type:HLSendToolbarButtonTypeTrend];
        //表情
        [self addBtn:@"compose_emoticonbutton_background" hightImage:@"compose_emoticonbutton_background_highlighted" type:HLSendToolbarButtonTypeEmotion];
    }
    return self;
}

#pragma mark - 添加按钮
- (UIButton *)addBtn:(NSString *)image hightImage:(NSString *)hightImage type:(HLSendToolbarButtonType)type
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    [self addSubview:btn];
    return btn;
}

- (void)layoutSubviews
{
    NSInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.x = btnW * i;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
}

#pragma mark - 点击按钮调用方法
- (void)clickBtn:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(sendToolbar:didClickButton:)]) {
        [self.delegate sendToolbar:self didClickButton:(HLSendToolbarButtonType)btn.tag];
    }
}
@end
