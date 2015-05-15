//
//  HLOAuthSDKController.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/29.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "HLOAuthSDKController.h"
#import "WeiboSDK.h"
@interface HLOAuthSDKController ()
@property (nonatomic, weak) UIButton *loginBtn;
@end

@implementation HLOAuthSDKController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [loginBtn setTitle:@"点我登陆授权" forState:UIControlStateNormal];
//    [loginBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
//    [loginBtn addTarget:self action:@selector(authroized) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:loginBtn];
//    self.loginBtn = loginBtn;
//    [self authroized];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self authroized];
}
#pragma mark - 微博SDK授权

- (void)authroized
{
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = @"http://www.sina.com";
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"HLOAuthSDKController"};
    [WeiboSDK sendRequest:request];
}
@end
