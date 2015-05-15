//
//  HLMainStatusResult.h
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/28.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLStatuses.h"
@interface HLMainStatusResult : NSObject
//微博状态模型
@property (nonatomic, strong) NSArray *statuses;
//微博状态总数
//@property (nonatomic, assign) int *total_number;
@end
