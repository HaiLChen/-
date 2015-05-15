//
//  HLUser.h
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/27.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLUser : NSObject
//用户姓名
@property (nonatomic, copy) NSString *name;
//头像图片
@property (nonatomic, copy) NSString *profile_image_url;
//会员等级
@property (nonatomic, assign) int mbrank;
//会员类型
@property (nonatomic, assign) int mbtype;
//判断是否是会员(YES代表是会员)
@property (nonatomic, assign, getter=isVip) BOOL isVip;
//+ (instancetype)userWithDict:(NSDictionary *)dict;
@end
