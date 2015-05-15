//
//  HLTableViewCell.h
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/5/11.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLStatusFrame.h"
@interface HLTableViewCell : UITableViewCell

//坐标模型类
@property (nonatomic, strong) HLStatusFrame *statusFrame;

+ (instancetype)cellWithTabel:(UITableView *)tableView;
@end
