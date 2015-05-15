//
//  HLStatusFrame.h
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/5/7.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define KCellMargin        10;
#define KCellSmallMargin   5;
#define KCellNameFont      [UIFont systemFontOfSize:16]
#define KCellTimeFont      [UIFont systemFontOfSize:13]
#define KCellSourceFont    KCellTimeFont
#define KCellContentFont   KCellNameFont
#define KCellIconSize      35
#define KCellVipSize       14
#define KCellBottomSize    KCellIconSize
#define KCellRetweetMargin 20
@class HLStatuses;
@interface HLStatusFrame : NSObject

//status模型
@property (nonatomic, strong) HLStatuses *status;
//顶部容器
@property (nonatomic, assign, readonly) CGRect topViewFrame;

//原创微博
@property (nonatomic, assign, readonly) CGRect orginalFrame;
//头像
@property (nonatomic, assign, readonly) CGRect iconViewFrame;
//昵称
@property (nonatomic, assign, readonly) CGRect nameLabelFrame;
//会员图标
@property (nonatomic, assign, readonly) CGRect vipViewFrame;
//时间
@property (nonatomic, assign, readonly) CGRect timeLabelFrame;
//来源
@property (nonatomic, assign, readonly) CGRect sourceLabelFrame;
//好友发送的信息（包括正文和图片）
@property (nonatomic, assign, readonly) CGRect ContentViewFrame;

//转发微博
@property (nonatomic, assign, readonly) CGRect retweetViewFrame;
//转发微博正文
@property (nonatomic, assign, readonly) CGRect retweetConntentLabelFrame;
//底部的工具条
@property (nonatomic, assign, readonly) CGRect bottomViewFrame;
//cell的高度
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@end
