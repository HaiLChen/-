//
//  HLAccountTool.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/27.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "HLAccountTool.h"
#import "HLAccount.h"

#define Kpath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] \
               stringByAppendingPathComponent:@"account.data"]

@implementation HLAccountTool

#pragma mark - 存储账号
+ (void)save:(HLAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:Kpath];
}

+ (HLAccount *)account
{
    HLAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:Kpath];
    NSLog(@"%@",account.expires_in);
    NSLog(@"%@",account.name);
    if ([[NSDate date] compare:account.expires_time] == NSOrderedDescending) {
        NSLog(@"授权过期了");
    }
    return account;
}
@end
