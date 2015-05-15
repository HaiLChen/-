//
//  AppDelegate.m
//  新浪微博
//
//  Created by 陈海龙 on 15/4/24.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "AppDelegate.h"
#import "HLTabBarController.h"
#import "HLOAuthController.h"
#import "HLAccountTool.h"
#import "HLAccount.h"
#import "HLOAuthSDKController.h"

#define Kpath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] \
stringByAppendingPathComponent:@"account.data"]

#define KAppKey @"3308270259"

@interface AppDelegate ()
@property (nonatomic, copy) NSString *wbtoken;
@property (nonatomic, copy) NSString *wbCurrentUserID;

@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:KAppKey];
    //创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;

    //判断沙盒是否有模型
    if ([HLAccountTool account]) {
        //设置窗口的根控制器（沙盒有accessToken）
        self.window.rootViewController = [[HLTabBarController alloc] init];;
    }else {
        //设置窗口的根控制器（沙盒没有accessToken）
        self.window.rootViewController = [[HLOAuthSDKController alloc] init];
    }
    
    //将self.window设置为主窗口
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark - 微博SDK代理方法
//收到请求
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

//收到返回数据
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            self.wbtoken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.wbCurrentUserID = userID;
        }
        [alert show];
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        //转换为授权回复
        WBAuthorizeResponse *authorizeResponse = (WBAuthorizeResponse *)response;
        
        HLAccount *account = [HLAccount accountWithDict:authorizeResponse.userInfo];
        [HLAccountTool save:account];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[HLTabBarController alloc] init];
        
        NSLog(@"%@",authorizeResponse.accessToken);
    }
    

}

//开发1
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}
//开发2
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self ];
}
@end
