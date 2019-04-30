//
//  ZCSystemNewsVC.m
//  Bango
//
//  Created by zchao on 2019/4/29.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCSystemNewsVC.h"

#import "ZCSystemNewsCell.h"

@interface ZCSystemNewsVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end

static NSString *newsCellid = @"ZCSystemNewsCell_id";

@implementation ZCSystemNewsVC

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (void)configCustomNav {
    [super setupNavBar];
    [self.customNavBar setTitle:@"系统消息"];
}


#pragma mark - event response

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCSystemNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:newsCellid];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight) style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = WidthRatio(106);
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[ZCSystemNewsCell class] forCellReuseIdentifier:newsCellid];
    }
    return _tableView;
}


#pragma mark - private

@end
