//
//  HLStatuses.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/27.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "HLStatuses.h"
#import "HLUser.h"
#import "HLPicUrl.h"
#import "MJExtension.h"
#import "NSDate+Extension.h"
@implementation HLStatuses
//+ (instancetype)statusesWithDict:(NSDictionary *)dict
//{
//    HLStatuses *statuses = [[HLStatuses alloc] init];
//    statuses.text = dict[@"text"];
//    statuses.source = dict[@"source"];
//    NSLog(@"%@",statuses.source);
//    statuses.created_at = dict[@"created_at"];
//    statuses.user = [HLUser userWithDict:dict[@"user"]];
//    return statuses;
//}

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [HLPicUrl class]};
}

//来源处理
- (void)setSource:(NSString *)source
{
    if (source.length) {
        NSInteger loc = [source rangeOfString:@">"].location + 1;
        NSInteger len = [source rangeOfString:@"</"].location - loc;
        source = [source substringWithRange:NSMakeRange(loc, len)];
    } else {
        source = @"新浪微博";
    }
    NSString *sourceStr = @"来自";
    _source = [sourceStr stringByAppendingString:source];
}

//微博创建时间处理
- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss z yyyy";
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [fmt dateFromString:_created_at];
    
//    NSString *str = [fmt stringFromDate:date];
    NSDate *now = [NSDate date];
    if (date.isThisYear) {
        if (date.isToday) {
            NSDateComponents *cmp = [date componentsToDate:now];
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",cmp.hour];
            }else if (cmp.minute >= 1){
                return [NSString stringWithFormat:@"%ld分钟前",cmp.minute];
            }else {
                return [NSString stringWithFormat:@"刚刚"];
            }
        }else if (date.isYesterday){
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:date];
        }else {
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:date];
        }
    }else {
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:date];
    }
}
@end
