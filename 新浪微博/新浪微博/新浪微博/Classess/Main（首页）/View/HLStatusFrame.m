//
//  HLStatusFrame.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/5/7.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "HLStatusFrame.h"
#import "HLStatuses.h"
#import "HLUser.h"
@implementation HLStatusFrame

- (void)setStatus:(HLStatuses *)status
{
    _status = status;
    
    //屏幕的宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    //头像
    CGFloat iconX = KCellMargin;
    CGFloat iconY = KCellMargin;
    CGFloat iconW = KCellIconSize;
    CGFloat iconH = KCellIconSize;
    _iconViewFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(_iconViewFrame) + KCellMargin;
    CGFloat nameY = iconY;
    CGSize  nameSize = [status.user.name sizeWithAttributes:@{
                                                                NSFontAttributeName : KCellNameFont
                                                              }];
    _nameLabelFrame = (CGRect){{nameX,nameY},nameSize};
    
//    //时间
//    CGFloat timeX = nameX;
//    CGFloat timeY = CGRectGetMaxY(_nameLabelFrame) + KCellSmallMargin;
//    CGSize  timeSize = [status.created_at sizeWithAttributes:@{
//                                                                NSFontAttributeName : KCellTimeFont
//                                                                }];
//    _timeLabelFrame = (CGRect){{timeX,timeY},timeSize};
//    
//    //来源
//    CGFloat sourceX = CGRectGetMaxX(_timeLabelFrame) + KCellMargin;
//    CGFloat sourceY = timeY;
//    CGSize  sourceSize = [status.source sizeWithAttributes:@{
//                                                                NSFontAttributeName : KCellSourceFont
//                                                             }];
//    _sourceLabelFrame = (CGRect){{sourceX,sourceY},sourceSize};
    
    //会员图标
    CGFloat vipX = CGRectGetMaxX(_nameLabelFrame) + KCellSmallMargin;
    CGFloat vipY = nameY;
    CGFloat vipW = KCellVipSize;
    CGFloat vipH = KCellVipSize;
    _vipViewFrame = CGRectMake(vipX, vipY, vipW, vipH);
    
    //好友发送的信息
    CGFloat contentX = iconX;
    CGFloat contentY = CGRectGetMaxY(_iconViewFrame) + KCellMargin;
    CGSize  contentMaxSize = CGSizeMake((screenW - 20), CGFLOAT_MAX);
    //constrainedToSize获取字符串的宽高 自定义label的高度和宽度
    CGSize  contentSize = [status.text sizeWithFont:KCellContentFont constrainedToSize:contentMaxSize];
    _ContentViewFrame = (CGRect){{contentX,contentY},contentSize};
    
    //原创微博视图
    CGFloat orginX = 0;
    CGFloat orginY = 0;
    CGFloat orginW = screenW;
    CGFloat orginH = CGRectGetMaxY(_ContentViewFrame);
    _orginalFrame = CGRectMake(orginX, orginY, orginW, orginH);
    
    //获取转发微博
    HLStatuses *retweetStatus = _status.retweeted_status;
    CGFloat topH = 0.0;
    if (retweetStatus != 0) {
        //转发微博正文
        CGFloat retweetContentX = KCellMargin;
        CGFloat retweetContentY = KCellMargin;
        CGSize retweetContentMaxSize = CGSizeMake(screenW - KCellRetweetMargin, CGFLOAT_MAX);
        CGSize retweetContentSize = [retweetStatus.text sizeWithFont:KCellContentFont constrainedToSize:retweetContentMaxSize];
        _retweetConntentLabelFrame = (CGRect){{retweetContentX,retweetContentY},retweetContentSize};
        
        //转发微博视图
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(_orginalFrame) + KCellSmallMargin;
        CGFloat retweetW = screenW;
        CGFloat retweetH = CGRectGetMaxY(_retweetConntentLabelFrame) + KCellSmallMargin;
        _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        //顶部视图高
        topH = CGRectGetMaxY(_retweetViewFrame);
    }else{
        //顶部视图高
        topH = CGRectGetMaxY(_orginalFrame);
    }
    
    //顶部视图
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topW = screenW;
    _topViewFrame = CGRectMake(topX, topY, topW, topH);
    
    //底部工具条
    CGFloat bottomX = topX;
    CGFloat bottomY = CGRectGetMaxY(_topViewFrame) + KCellMargin;
    CGFloat bottomW = screenW;
    CGFloat bottomH = KCellBottomSize;
    _bottomViewFrame = (CGRect){{bottomX,bottomY},{bottomW,bottomH}};
    
    //cell的行高
    _cellHeight = CGRectGetMaxY(_bottomViewFrame);

}
@end
