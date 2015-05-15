//
//  HLAccount.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/27.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "HLAccount.h"

@implementation HLAccount

#pragma mark - 自定义字典转模型方法
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    HLAccount *account = [[HLAccount alloc] init];
    account.access_token = dict[@"access_token"];
    NSLog(@"%@",account.access_token);
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    account.name = dict[@"name"];
    NSDate *now = [NSDate date];
    account.expires_time = [now dateByAddingTimeInterval:[account.expires_in doubleValue]];
    return account;
}

#pragma mark - 归档读取方法
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.expires_time = [decoder decodeObjectForKey:@"expires_time"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

#pragma mark - 归档存储方法
- (void)encodeWithCoder:(NSCoder *)enCoder
{
    [enCoder encodeObject:self.access_token forKey:@"access_token"];
    [enCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [enCoder encodeObject:self.uid forKey:@"uid"];
    [enCoder encodeObject:self.expires_time forKey:@"expires_time"];
    [enCoder encodeObject:self.name forKey:@"name"];
}
@end
