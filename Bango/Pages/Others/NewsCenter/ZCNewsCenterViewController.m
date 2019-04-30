//
//  ZCNewsCenterViewController.m
//  Bango
//
//  Created by zchao on 2019/4/28.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCNewsCenterViewController.h"
#import "ZCNewsCenterCell.h"
#import "ZCSystemNoticeListVC.h"
#import "ZCSystemNewsVC.h"
#import "ZCPostAssistantListVC.h"

@interface ZCNewsCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end


static NSString *newsCellid = @"ZCNewsCenterCell_id";

@implementation ZCNewsCenterViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}


- (void)configCustomNav {
    [super setupNavBar];
    [self.customNavBar setTitle:@"消息"];
}


#pragma mark - event response

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCNewsCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:newsCellid];
    cell.cellViewModel = self.noticeVM;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        ZCSystemNoticeListVC *noticeList = [[ZCSystemNoticeListVC alloc] init];
        [self.navigationController pushViewController:noticeList animated:YES];
    }else if (indexPath.row == 1) {
        ZCPostAssistantListVC *postVC = [[ZCPostAssistantListVC alloc] init];
        [self.navigationController pushViewController:postVC animated:YES];
    }else if (indexPath.row == 2) {
        ZCSystemNewsVC *newsVC = [[ZCSystemNewsVC alloc] init];
        [self.navigationController pushViewController:newsVC animated:YES];
    }
    
}


#pragma mark - getters and setters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight) style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = WidthRatio(66);
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[ZCNewsCenterCell class] forCellReuseIdentifier:newsCellid];
    }
    return _tableView;
}


#pragma mark - private

@end
