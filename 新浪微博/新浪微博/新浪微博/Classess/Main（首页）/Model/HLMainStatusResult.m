//
//  HLMainStatusResult.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/28.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "HLMainStatusResult.h"
#import "MJExtension.h"
@implementation HLMainStatusResult

- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [HLStatuses class]};
}
@end
