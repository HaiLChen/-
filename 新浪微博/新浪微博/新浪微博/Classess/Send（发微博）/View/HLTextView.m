//
//  HLTextView.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/5/4.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "HLTextView.h"

@implementation HLTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    //重绘
    [self setNeedsDisplay];
}

- (void)setPlacehoder:(NSString *)placehoder
{
    _placehoder = [placehoder copy];
    //重绘
    [self setNeedsDisplay];
}

#pragma mark - 添加通知
- (void)setup
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNeedsDisplay)
                                                 name:UITextViewTextDidChangeNotification object:self];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)drawRect:(CGRect)rect
{
    //文字属性
    if (self.hasText) return;
    NSMutableDictionary *atrrs = [NSMutableDictionary dictionary];
    atrrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    if (self.font) {
        atrrs[NSFontAttributeName] = self.font;
    }
    
    //画文字
    CGRect placehoder;
    placehoder.origin = CGPointMake(5, 7);
    CGFloat w = rect.size.width - 2 * placehoder.origin.x;
    CGFloat h = rect.size.height;
    placehoder.size = CGSizeMake(w, h);
    [self.placehoder drawInRect:placehoder withAttributes:atrrs];
}
@end
