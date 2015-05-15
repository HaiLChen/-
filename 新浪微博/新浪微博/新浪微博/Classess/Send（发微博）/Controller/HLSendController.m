//
//  HLSendController.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/5/4.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "HLSendController.h"
#import "HLTextView.h"
#import "HLAccountTool.h"
#import "UIView+Extension.h"
#import "HLTextView.h"
#import "AFNetworking.h"
#import "HLSendToolbar.h"
@interface HLSendController ()<UITextViewDelegate,HLSendToolbarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
//自定义输入文字视图
@property (nonatomic, weak) HLTextView *textView;
//自定义工具条
@property (nonatomic,weak) HLSendToolbar *toolbar;
@end

@implementation HLSendController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setNav];
    //设置textView
    [self setupTextView];
}

#pragma mark - 视图即将出现的时候调用
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //将导航栏右边的发送按钮设置为不可用
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
    //将textView设置为键盘的第一响应者
    [self.textView becomeFirstResponder];
}

#pragma mark - 视图即将消失的时候调用
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //使textView失去键盘的第一响应者身份
    [self.textView resignFirstResponder];
}

#pragma mark - 设置导航栏
- (void)setNav
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{
                                   NSForegroundColorAttributeName : [UIColor orangeColor]
                                  } forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{
                                   NSForegroundColorAttributeName : [UIColor lightGrayColor]
                                   } forState:UIControlStateDisabled];
    //设置当前控制器view的背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    //发送按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    //返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    NSString *prefix = @"发微博";
    NSString *name = [HLAccountTool account].name;
    if (name) {
        UILabel *label = [[UILabel alloc] init];
        self.navigationItem.titleView = label;
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.height = 44;
        
        NSString *text = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
        [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0,prefix.length)];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[text rangeOfString:name]];
        label.attributedText = string;
    }else{
        self.title = prefix;
    }
}

#pragma mark - 设置textView
- (void)setupTextView
{
    HLTextView *textView = [[HLTextView alloc] init];
    textView.placehoder = @"分享新鲜事...";
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:20];
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    //创建自定义工具条
    HLSendToolbar *toolbar = [[HLSendToolbar alloc] init];
    toolbar.height = 44;
    toolbar.delegate = self;
    self.textView.inputAccessoryView = toolbar;
    self.toolbar = toolbar;
}

#pragma mark - 点击发送按钮调用
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 点击返回按钮调用
- (void)send
{
    [self back];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [HLAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    [mgr GET:@"https://api.weibo.com/2/statuses/update.json" parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"发布成功");
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"发送失败");
   }];
}

#pragma mark - textView系统代理方法
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

#pragma mark - 自定义toolbar代理方法
- (void)sendToolbar:(HLSendToolbar *)sendToolbar didClickButton:(HLSendToolbarButtonType)buttonType
{
    switch (buttonType) {
        case HLSendToolbarButtonTypeCamera:
            NSLog(@"拍照");
            break;
        case HLSendToolbarButtonTypePicture:
            [self openAlbum];
            break;
        case HLSendToolbarButtonTypeMention:
            NSLog(@"@");
            break;
        case HLSendToolbarButtonTypeTrend:
            NSLog(@"#");
            break;
        case HLSendToolbarButtonTypeEmotion:
            NSLog(@"表情");
            break;
        default:
            break;
    }
}

#pragma mark - 工具栏上按钮事件
- (void)openAlbum
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:ipc animated:YES completion:nil];
    ipc.delegate = self;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(10, 100, 100, 100);
    imageView.image = image;
    [self.textView addSubview:imageView];
    NSLog(@"%@",info);
}
@end
