//
//  HLOAuthController.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/25.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "HLOAuthController.h"
#import "AFNetworking.h"
#import "HLTabBarController.h"
#import "HLAccount.h"
#import "HLAccountTool.h"
@interface HLOAuthController ()<UIWebViewDelegate>
//显示授权页面的webView
@property (nonatomic, weak) UIWebView *webView;
@end

@implementation HLOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置webView
    [self setWebView];
}

#pragma mark - 设置webView
- (void)setWebView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3308270259&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    self.webView = webView;
    self.webView.delegate = self;
}

#pragma mark - UIWebViewDelegate代理方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
                                                 navigationType:(UIWebViewNavigationType)navigationType
{
    //获取路径
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    if (range.length) {
        NSString *code = [url substringFromIndex:range.location + range.length];
        NSLog(@"%@",code);
        //获取accessToken
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}

#pragma mark - 获取accessToken
- (void)accessTokenWithCode:(NSString *)code
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"3308270259";
    params[@"client_secret"] = @"bd53e4452fdd62cb0863d54df3b761d2";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.baidu.com";
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        //获取沙盒路径
//        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        //拼接路径
//        NSString *path = [doc stringByAppendingPathComponent:@"account.plist"];
//        //将获取到的accessToken放入沙盒path路径
//        [responseObject writeToFile:path atomically:YES];
        
        
        //利用获取到的字典给模型赋值
        HLAccount *account = [HLAccount accountWithDict:responseObject];
        [HLAccountTool save:account];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[HLTabBarController alloc] init];
        
        
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败了");
    }];
}


@end
