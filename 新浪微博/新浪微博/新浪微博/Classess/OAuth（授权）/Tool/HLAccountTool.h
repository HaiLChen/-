//
//  HLAccountTool.h
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/27.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLAccount.h"
@interface HLAccountTool : NSObject
//存到模型沙盒
+ (void)save:(HLAccount *)account;
//从沙盒获取模型
+ (HLAccount *)account;
@end
