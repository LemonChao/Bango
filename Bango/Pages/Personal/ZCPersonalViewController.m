//
//  ZCPersonalViewController.m
//  Bango
//
//  Created by zchao on 2019/3/29.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCPersonalViewController.h"
#import "ZCPersonalOrderCell.h"
#import "ZCPersonalTableHeadView.h"
#import "ZCPersonalBalanceCell.h"
#import "ZCPersonalOrderCell.h"
#import "ZCPersonalwelfareCell.h"
#import "ZCPersonalDataCell.h"
#import "ZCPersonalCenterVM.h"


#define NAVBAR_COLORCHANGE_POINT (WidthRatio(84)-NavBarHeight)

@interface ZCPersonalViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) ZCPersonalCenterVM *viewModel;

@property(nonatomic, assign) BOOL changeDefault;
@end

static NSString *tableHeaderid = @"UITableViewHeaderView_id";
static NSString *tableFooterid = @"UITableViewFooterView_id";
static NSString *orderCellid = @"ZCPersonalOrderCell_id";
static NSString *balanceCellid = @"ZCPersonalBalanceCell_id";
static NSString *welfareCellid = @"ZCPersonalwelfareCell_id";
static NSString *dataCellid = @"ZCPersonalDataCell_id";


@implementation ZCPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self getData];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)configCustomNav {
    [super setupNavBar];

    self.customNavBar.barBackgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setRightButtonWithImage:ImageNamed(@"pesonal_header_set")];
    self.customNavBar.titleLabelColor = ImportantColor;
    @weakify(self);
    [self.customNavBar setOnClickRightButton:^{
        @strongify(self);
        ZCWebViewController *webVC = [[ZCWebViewController alloc] initWithPath:@"set" parameters:nil];
        [self.navigationController pushViewController:webVC animated:YES];
    }];
    
}

- (void)configViews {
    [self.view addSubview:self.tableView];
    
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.tableView.mj_header = [MJStaticImageHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getData];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.changeDefault) {
        return UIStatusBarStyleDefault;
    }
    return UIStatusBarStyleLightContent;
}


- (void)getData {
    [[self.viewModel.memberCmd execute:nil] subscribeNext:^(id  _Nullable x) {
        if ([x boolValue]) {
            kHidHud;
        }
        [(ZCPersonalTableHeadView *)self.tableView.tableHeaderView setModel:self.viewModel.model];
        [self.tableView reloadData];

        [self.tableView.mj_header endRefreshing];
    } error:^(NSError * _Nullable error) {
        [self.tableView.mj_header endRefreshing];
    }];
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.001;
    }else {
        return WidthRatio(8);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:tableHeaderid];
    header.backgroundView.backgroundColor = [UIColor clearColor];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:tableFooterid];
    return footer;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return WidthRatio(85);
    }
    else if (indexPath.section == 1) {
        return WidthRatio(130);
    }
    else if (indexPath.section == 2) {
        if ([self.viewModel.model.guo_open boolValue]) {
            return WidthRatio(218);
        }else {
            return WidthRatio(138);
        }
    }
    else if (indexPath.section == 3) {
        return WidthRatio(214)+2;
    }
    return 0.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZCPersonalBalanceCell *cell = [tableView dequeueReusableCellWithIdentifier:balanceCellid];
        cell.model = self.viewModel.model;
        return cell;
    }
    else if (indexPath.section == 1) {
        ZCPersonalOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCellid];
        cell.model = self.viewModel.model;
        return cell;
    }
    else if (indexPath.section == 2) {
        ZCPersonalwelfareCell *cell = [tableView dequeueReusableCellWithIdentifier:welfareCellid];
        cell.model = self.viewModel.model;
        return cell;
    }
    else if(indexPath.section == 3) {
        ZCPersonalDataCell *cell = [tableView dequeueReusableCellWithIdentifier:dataCellid];
        return cell;
    }
    return nil;
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    static BOOL needUpdate = NO;
    needUpdate = offsetY > (WidthRatio(84)-NavBarHeight/2);
    if (needUpdate != self.changeDefault) {//减少调用次数
        self.changeDefault = needUpdate;
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    if (offsetY < NAVBAR_COLORCHANGE_POINT || offsetY == 0)
    {
        [self.customNavBar wr_setBackgroundAlpha:0];
        [self.customNavBar wr_setTintColor:[UIColor whiteColor]];
        self.customNavBar.title = nil;
    }
    else
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NavBarHeight;
        [self.customNavBar wr_setBackgroundAlpha:alpha];
        [self.customNavBar wr_setTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        self.customNavBar.title = @"会员中心";
    }

}


#pragma mark - setter && getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        ZCPersonalTableHeadView *header = [[ZCPersonalTableHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthRatio(84)+NavBarHeight)];
        _tableView.tableHeaderView = header;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableView registerClass:[ZCPersonalOrderCell class] forCellReuseIdentifier:orderCellid];
        [_tableView registerClass:[ZCPersonalBalanceCell class] forCellReuseIdentifier:balanceCellid];
        [_tableView registerClass:[ZCPersonalwelfareCell class] forCellReuseIdentifier:welfareCellid];
        [_tableView registerClass:[ZCPersonalDataCell class] forCellReuseIdentifier:dataCellid];
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:tableHeaderid];
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:tableFooterid];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (ZCPersonalCenterVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZCPersonalCenterVM alloc] init];
    }
    return _viewModel;
}

@end
