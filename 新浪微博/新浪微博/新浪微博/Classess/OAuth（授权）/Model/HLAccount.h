//
//  HLAccount.h
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/27.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLAccount : NSObject<NSCoding>
//获取到的access_token
@property (nonatomic, copy) NSString *access_token;
//授权生命周期
@property (nonatomic, copy) NSString *expires_in;
//用户UID
@property (nonatomic, copy) NSString *uid;
//授权过期的时间
@property (nonatomic, strong) NSDate *expires_time;
//用户授权用的名字
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
 