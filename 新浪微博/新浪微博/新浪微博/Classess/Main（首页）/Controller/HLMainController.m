//
//  HLMainController.m
//  Sina micro-blog
//
//  Created by 陈海龙 on 15/4/24.
//  Copyright (c) 2015年 chenhailong. All rights reserved.
//

#import "HLMainController.h"
#import "UIBarButtonItem+Extension.h"
#import "HLTitleButton.h"
#import "AFNetworking.h"
#import "HLAccountTool.h"
#import "HLStatuses.h"
#import "HLMainStatusResult.h"
#import "MJExtension.h"
#import "HLUpLoadView.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"
#import "HLStatusFrame.h"
#import "HLTableViewCell.h"

@interface HLMainController ()<UITableViewDataSource,UITableViewDelegate>
//自定义可变数组 用来存放微博模型
@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation HLMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏内容
    [self setNav];
    
//    //获取微博数据模型
//    [self loadStatus];
    
    //设置tabView的属性
    [self setTableView];
    
    //添加刷新控件
    [self addRefresh];
    
    //获取用户数据
    [self loadUser];
}

#pragma  mark - 懒加载
- (NSMutableArray *)statuses
{
    if (_statuses == nil ) {
        _statuses = [[NSMutableArray alloc] init];
    }
    return _statuses;
}

#pragma  mark - 设置导航栏内容
- (void)setNav
{
    //设置左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImg:@"navigationbar_friendsearch"
                                                                 highImg:@"navigationbar_friendsearch_highlighted"
                                                                  target:self
                                                                  action:@selector(add)];
    //设置右边的按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImg:@"navigationbar_pop"
                                                                  highImg:@"navigationbar_pop_highlighted"
                                                                   target:self
                                                                   action:@selector(pop)];
    //设置中间按钮
    HLTitleButton *titleBtn = [[HLTitleButton alloc] init];
    [titleBtn setTitle:@"西门抽筋  " forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    self.navigationItem.titleView = titleBtn;
}

#pragma mark - 设置tableView属性
- (void)setTableView
{
    //设置tableView的数据源代理
    self.tableView.dataSource = self;
    //设置tableView的代理
    self.tableView.delegate = self;
    //设置tableView的属性
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - 添加刷新控件
- (void)addRefresh
{
    //下拉刷新
    UIRefreshControl *rfControl = [[UIRefreshControl alloc] init];
    [rfControl addTarget:self action:@selector(refreshControlGetChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:rfControl];
    
    //进入刷新状态
    [rfControl beginRefreshing];
    [self refreshControlGetChange:rfControl];
    
    //添加tableView的底部View
    self.tableView.tableFooterView = [HLUpLoadView footer];
    self.tableView.tableFooterView.hidden = YES;
}

#pragma mark - 获取用户数据
- (void)loadUser
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    HLAccount *account = [HLAccountTool account];
    NSMutableDictionary *prarms = [NSMutableDictionary dictionary];
    prarms[@"access_token"] = account.access_token;
    prarms[@"uid"] = account.uid;
    
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:prarms
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          NSLog(@"%@",responseObject);
          HLUser *user = [HLUser objectWithKeyValues:responseObject];
          //设置导航栏的titleView
          HLTitleButton *titleButton = (HLTitleButton *)self.navigationItem.titleView;
          [titleButton setTitle:user.name forState:UIControlStateNormal];
          
          //存储用户名
          if ([account.name isEqualToString:user.name]) return;
          account.name = user.name;
          [HLAccountTool save:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"连接失败-%@",error);
    }];
}

#pragma mark - 刷新控件的值改变时调用
- (void)refreshControlGetChange:(UIRefreshControl *)control
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [HLAccountTool account].access_token;
    HLStatusFrame *frame = [self.statuses firstObject];
    HLStatuses *statuses = frame.status;
    if (statuses) {
//        NSLog(@"111111111%@",[[self.statuses firstObject] idstr]);
        params[@"since_id"] = @([[statuses idstr] doubleValue]);
//        NSLog(@"%@",[[self.statuses firstObject] idstr]);
    }
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json"
  parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"%@",responseObject);
        NSLog(@"成功了");
        HLMainStatusResult *result = [HLMainStatusResult objectWithKeyValues:responseObject];
         NSArray *frameModels = [self frameModelWithStatus:result.statuses];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, frameModels.count)];
        [self.statuses insertObjects:frameModels atIndexes:indexSet];
         [self.tableView reloadData];
            //结束刷新
            [control endRefreshing];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败了。。。原因：%@",error);
        //结束刷新
        [control endRefreshing];

    }];
}

#pragma mark - 点击导航栏按钮调用方法

- (void)pop
{
    NSLog(@"扫描");
}

- (void)add
{
    NSLog(@"添加用户");
}


#pragma mark - 获取微博数据模型方法
- (void)loadStatus
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [HLAccountTool account].access_token;
    HLStatusFrame *frame = [self.statuses firstObject];
    HLStatuses *status = frame.status;
    if (status) {
//        params[@"max_id"] = @([[[self.statuses lastObject] idstr] longLongValue] - 1);
        params[@"max_id"] = @([[status idstr] doubleValue]);
    }
    
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"成功");
        HLMainStatusResult *result = [HLMainStatusResult objectWithKeyValues:responseObject];
//        NSLog(@"%@",responseObject);
         NSArray *frameModels = [self frameModelWithStatus:result.statuses];
        [self.statuses addObjectsFromArray:frameModels];
        [self.tableView reloadData];
        self.tableView.tableFooterView.hidden = YES;
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
        self.tableView.tableFooterView.hidden = YES;
    }];
}

#pragma mark - 字典转模型
- (NSArray *)frameModelWithStatus:(NSArray *)statuses
{
    NSMutableArray *frameModels = [NSMutableArray arrayWithCapacity:statuses.count];
    for (HLStatuses *status in statuses) {
        HLStatusFrame *frame = [[HLStatusFrame alloc] init];
        frame.status = status;
        [frameModels addObject:frame];
    }
    return frameModels;
}

#pragma mark - Table view data source 数据源代理方法

//返回每组的列数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.statuses.count;
}

//static NSString *ID = @"statusCell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:ID];
//    }
//    HLStatuses *statuses = self.statuses[indexPath.row];
//    NSString *mainText = [NSString stringWithFormat:@"%@ %@%@%@",statuses.created_at,statuses.source,@"\n",statuses.text];
//    cell.detailTextLabel.text = mainText;
//    cell.detailTextLabel.numberOfLines = 0;
//    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
//    cell.textLabel.text = statuses.user.name;
//    NSLog(@"%@",statuses.source);
//    NSLog(@"%@",statuses.created_at);
//    NSString *image = statuses.user.profile_image_url;
//    NSLog(@"%@",statuses.user.name);
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:image]
//                      placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
//
////    NSLog(@"%@",image);
    
    HLTableViewCell *cell = [HLTableViewCell cellWithTabel:tableView];
    cell.statusFrame = self.statuses[indexPath.row];
    return cell;
}


#pragma mark - 代理方法

//返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HLStatusFrame *frame = self.statuses[indexPath.row];
    
    return frame.cellHeight;
}

#pragma mark - 监听scrollerView的contentOffset
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%d",self.tableView.tableFooterView.hidden);
    if (self.statuses.count == 0 || self.tableView.tableFooterView.hidden == NO) return;
    //滑动到最底部的距离
    CGFloat judgeY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    
    if (scrollView.contentOffset.y >= judgeY) {
        self.tableView.tableFooterView.hidden = NO;
        [self loadStatus];
    }
}
@end
