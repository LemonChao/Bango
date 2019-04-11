//
//  ZCCartViewController.m
//  Bango
//
//  Created by zchao on 2019/3/29.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartViewController.h"
#import "ZCCartValueGodsCell.h"
#import "ZCCartViewModel.h"


@interface ZCCartViewController()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) ZCCartViewModel *viewModel;

@end

static NSString *cellid = @"ZCCartValueGodsCell_id";

@implementation ZCCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
}


- (void)configViews {
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:nil];
}

- (void)getData {
    [[self.viewModel.netCartCmd execute:nil] subscribeNext:^(id  _Nullable x) {
        if ([x boolValue]) {
            [MBProgressHUD hideHud];
            [self.tableView reloadData];
        }
        
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [self.tableView.mj_header endRefreshing];
    }error:^(NSError * _Nullable error) {
        [self.tableView.mj_header endRefreshing];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.cartDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCCartValueGodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    ZCCartGodsModel *godModel = self.viewModel.cartDatas[indexPath.row];
    cell.model = godModel;
    return cell;
}

#pragma mark - setter && getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.estimatedRowHeight = WidthRatio(98);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerClass:[ZCCartValueGodsCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}

- (ZCCartViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZCCartViewModel alloc] init];
    }
    return _viewModel;
}

@end
