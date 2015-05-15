//
//  HLUser.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/27.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "HLUser.h"

@implementation HLUser
//+ (instancetype)userWithDict:(NSDictionary *)dict
//{
//    HLUser *user = [[HLUser alloc] init];
//    user.name = dict[@"name"];
//    user.profile_image_url = dict[@"profile_image_url"];
//    return user;
//}

- (BOOL)isVip
{
    return self.mbrank > 2;
}
@end
