//
//  HLPicUrl.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/29.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "HLPicUrl.h"

@implementation HLPicUrl

- (void)setThumbnail_pic:(NSString *)thumbnail_pic
{
    _thumbnail_pic = [thumbnail_pic copy];
    self.bmiddle_pic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}
@end
