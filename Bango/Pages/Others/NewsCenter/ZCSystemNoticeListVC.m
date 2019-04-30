//
//  ZCSystemNoticeListVC.m
//  Bango
//
//  Created by zchao on 2019/4/29.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCSystemNoticeListVC.h"
#import "ZCSystemNoticeListCell.h"

@interface ZCSystemNoticeListVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end

static NSString *noticeListCellid = @"ZCSystemNoticeListCell_id";

@implementation ZCSystemNoticeListVC

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    //https://mr-bango.cn/html-src/dist/#/notice-detail?id=7
    [self.view addSubview:self.tableView];
    
}

- (void)configCustomNav {
    [super setupNavBar];
    [self.customNavBar setTitle:@"系统公告"];
}


#pragma mark - event response

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCSystemNoticeListCell *cell = [tableView dequeueReusableCellWithIdentifier:noticeListCellid];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZCWebViewController *webVC = [[ZCWebViewController alloc] initWithPath:@"notice-detail" parameters:@{@"id":@"7"}];
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight) style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = WidthRatio(43);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = LineColor;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[ZCSystemNoticeListCell class] forCellReuseIdentifier:noticeListCellid];
    }
    return _tableView;
}


#pragma mark - private



@end
