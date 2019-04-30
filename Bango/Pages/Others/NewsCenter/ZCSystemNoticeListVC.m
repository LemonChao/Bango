//
//  ZCSystemNoticeListVC.m
//  Bango
//
//  Created by zchao on 2019/4/29.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCSystemNoticeListVC.h"
#import "ZCSystemNoticeListCell.h"
#import "ZCSystemNoticeVM.h"


@interface ZCSystemNoticeListVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) ZCSystemNoticeVM *viewModel;

@end

static NSString *noticeListCellid = @"ZCSystemNoticeListCell_id";

@implementation ZCSystemNoticeListVC

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)configCustomNav {
    [super setupNavBar];
    [self.customNavBar setTitle:@"系统公告"];
}

- (void)configViews {
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

#pragma mark - event response


- (void)getData {
    [[self.viewModel.noticeListCmd execute:nil] subscribeNext:^(id  _Nullable x) {
        if ([x boolValue]) {
            kHidHud
            [self.tableView reloadData];
        }
        
        [self.tableView.mj_header endRefreshing];
    }error:^(NSError * _Nullable error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
}



#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCSystemNoticeListCell *cell = [tableView dequeueReusableCellWithIdentifier:noticeListCellid];
    ZCSystemNoticeModel *model = self.viewModel.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZCSystemNoticeModel *model = self.viewModel.dataArray[indexPath.row];
    ZCWebViewController *webVC = [[ZCWebViewController alloc] initWithPath:@"notice-detail" parameters:@{@"id":model.aid}];
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

- (ZCSystemNoticeVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZCSystemNoticeVM alloc] init];
    }
    return _viewModel;
}

#pragma mark - private



@end
