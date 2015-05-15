//
//  HLTableViewCell.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/5/11.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "HLTableViewCell.h"
#import "HLUser.h"
#import "HLStatuses.h"
#import "UIImageView+WebCache.h"
#define KCellNameFont    [UIFont systemFontOfSize:16]
#define KCellTimeFont    [UIFont systemFontOfSize:13]
#define KCellSourceFont  KCellTimeFont
#define KCellContentFont KCellNameFont

@interface HLTableViewCell ()
//顶部视图
@property (nonatomic, weak) UIView *topView;

/**原创微博视图**/
@property (nonatomic, weak) UIView *orginalView;
//头像
@property (nonatomic, weak) UIImageView *iconView;
//昵称
@property (nonatomic, weak) UILabel *nameLabel;
//会员图标
@property (nonatomic ,weak) UIImageView *vipView;
//发布时间
@property (nonatomic, weak) UILabel *timeLabel;
//来源
@property (nonatomic, weak) UILabel *sourceLabel;
//正文内容
@property (nonatomic, weak) UILabel *contentLabel;

/**转发微博视图**/
@property (nonatomic, weak) UIView *retweentView;
//转发正文
@property (nonatomic, weak) UILabel *retweentContentLabel;

//底部视图
@property (nonatomic, weak) UIView *bottomView;
@end
@implementation HLTableViewCell

+ (instancetype)cellWithTabel:(UITableView *)tableView
{
    static NSString *ID = @"customCell";
    HLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置顶部视图
        [self setupTopView];
        //设置底部视图
        [self setupBottomView];
    }
    return self;
}

#pragma mark - 设置顶部视图
- (void)setupTopView
{
    //顶部视图
    UIView *topView = [[UIView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    //初始化原创微博视图
    [self setupOrginalView];
    //初始化转发微博视图
    [self setupRetweetView];
}

#pragma mark - 设置原创微博视图
- (void)setupOrginalView
{
    //原创微博视图
    UIView *orginalView = [[UIView alloc] init];
    [self.topView addSubview:orginalView];
    self.orginalView = orginalView;
    
    //头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [orginalView addSubview:iconView];
    self.iconView = iconView;
    
    //昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    [orginalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    self.nameLabel.font = KCellNameFont;
    
    //会员图标
    UIImageView *vipView = [[UIImageView alloc] init];
    [orginalView addSubview:vipView];
    self.vipView = vipView;
    
    //发布时间
    UILabel *timeLabel = [[UILabel alloc] init];
    [orginalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    self.timeLabel.font = KCellTimeFont;
    
    //来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    [orginalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    self.sourceLabel.font = KCellSourceFont;
    
    //正文内容
    UILabel *contentLabel = [[UILabel alloc] init];
    [orginalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = KCellContentFont;
}

#pragma mark - 设置转发微博视图
- (void)setupRetweetView
{
    //转发微博
    UIView *retweetView = [[UIView alloc] init];
    [self.topView addSubview:retweetView];
    self.retweentView = retweetView;
    self.retweentView.backgroundColor = [UIColor lightGrayColor];
    
    //转发微博正文
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    [retweetView addSubview:retweetContentLabel];
    self.retweentContentLabel = retweetContentLabel;
    self.retweentContentLabel.font = KCellContentFont;
    self.retweentContentLabel.numberOfLines = 0;
}

#pragma mark - 设置底部视图
- (void)setupBottomView
{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:bottomView];
    self.bottomView = bottomView;
}

- (void)setStatusFrame:(HLStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    //设置数据
    [self setupData];
    //设置坐标
    [self setupFrame];
}

#pragma mark - 设置数据
- (void)setupData
{
    HLStatuses *status = self.statusFrame.status;
    HLUser *user = status.user;
    
    //头像
    NSURL *iconUrl = [NSURL URLWithString:user.profile_image_url];
    [self.iconView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    //昵称
    self.nameLabel.text = user.name;
    
    //vip
    if (user.isVip) {
        NSString *vipImage = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipImage];
        self.vipView.hidden = NO;
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }

    
    //发布时间
    self.timeLabel.text = status.created_at;
    self.timeLabel.textColor = [UIColor orangeColor];
    
    //来源
    self.sourceLabel.text = status.source;
    NSLog(@"%@",self.sourceLabel.text);
    
    //正文
    self.contentLabel.text = status.text;
    
    //转发微博正文
    self.retweentContentLabel.text = [NSString stringWithFormat:@"@%@:%@",status.retweeted_status.user.name,status.retweeted_status.text];
}

#pragma mark - 设置坐标
- (void)setupFrame;
{
    //顶部视图
    self.topView.frame = self.statusFrame.topViewFrame;
    //头像
    self.iconView.frame = self.statusFrame.iconViewFrame;
    //昵称
    self.nameLabel.frame = self.statusFrame.nameLabelFrame;
    //vip
    self.vipView.frame = self.statusFrame.vipViewFrame;
    HLStatuses *status = self.statusFrame.status;
    //时间
    CGFloat timeX = self.statusFrame.nameLabelFrame.origin.x;
    CGFloat timeY = CGRectGetMaxY(self.statusFrame.nameLabelFrame) + KCellSmallMargin;
    CGSize  timeSize = [status.created_at sizeWithAttributes:@{
                                                               NSFontAttributeName : KCellTimeFont
                                                               }];
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + KCellMargin;
    CGFloat sourceY = timeY;
    CGSize  sourceSize = [status.source sizeWithAttributes:@{
                                                             NSFontAttributeName : KCellSourceFont
                                                             }];
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    //正文
    self.contentLabel.frame = self.statusFrame.ContentViewFrame;
    //原创微博视图
    self.orginalView.frame = self.statusFrame.orginalFrame;
    //转发微博正文
    self.retweentContentLabel.frame = self.statusFrame.retweetConntentLabelFrame;
    //转发微博视图
    self.retweentView.frame = self.statusFrame.retweetViewFrame;
    //底部视图
    self.bottomView.frame = self.statusFrame.bottomViewFrame;
}
@end
