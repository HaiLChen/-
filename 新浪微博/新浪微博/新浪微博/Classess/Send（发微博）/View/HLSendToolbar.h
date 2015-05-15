//
//  HLSendToolbar.h
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/5/6.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HLSendToolbarButtonTypeCamera,  //拍照
    HLSendToolbarButtonTypePicture, //相册
    HLSendToolbarButtonTypeMention, //@
    HLSendToolbarButtonTypeTrend,  //#
    HLSendToolbarButtonTypeEmotion  //表情
} HLSendToolbarButtonType;

@class HLSendToolbar;
@protocol HLSendToolbarDelegate <NSObject>
@required
- (void)sendToolbar:(HLSendToolbar *)sendToolbar didClickButton:(HLSendToolbarButtonType)buttonType;
@end
@interface HLSendToolbar : UIView
@property (nonatomic, weak) id<HLSendToolbarDelegate>delegate;
@end
