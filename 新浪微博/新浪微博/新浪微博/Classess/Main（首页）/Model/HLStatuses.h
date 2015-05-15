//
//  HLStatuses.h
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/27.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLUser.h"
@interface HLStatuses : NSObject
//微博来源
@property (nonatomic, copy) NSString *source;
//微博正文
@property (nonatomic, copy) NSString *text;
//微博发布时间
@property (nonatomic, copy) NSString *created_at;
//微博用户模型
@property (nonatomic, strong) HLUser *user;
//微博配图
@property (nonatomic, strong) NSArray *pic_urls;
//微博ID
@property (nonatomic, copy) NSString *idstr;
//转发微博
@property (nonatomic, strong) HLStatuses *retweeted_status;

//+(instancetype)statusesWithDict:(NSDictionary *)dict;
@end
