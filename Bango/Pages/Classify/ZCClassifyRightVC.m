//
//  ZCClassifyRightVC.m
//  Bango
//
//  Created by zchao on 2019/4/8.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCClassifyRightVC.h"
#import "ZCClassifyRightCell.h"


@interface ZCClassifyRightVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) UITableView *rightTableView;

@end

static NSString *rightCellid = @"ZCClassifyRightCell_id";

@implementation ZCClassifyRightVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)configViews {
    [self.view addSubview:self.rightTableView];
    
    [self.rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WidthRatio(160);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCClassifyRightCell *cell = [tableView dequeueReusableCellWithIdentifier:rightCellid];
    ZCClassifyGodsModel *godsModel = self.dataArray[indexPath.row];
    cell.model = godsModel;
    return cell;
}

#pragma mark - setter && getter

- (void)setDataArray:(NSArray<__kindof ZCClassifyGodsModel *> *)dataArray {
    if (_dataArray == dataArray || [_dataArray isEqual:dataArray]) return;
    
    _dataArray = dataArray;
    [self.rightTableView reloadData];
    [self.rightTableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionTop animated:NO];
}


- (UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_rightTableView registerClass:[ZCClassifyRightCell class] forCellReuseIdentifier:rightCellid];
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTableView.dataSource = self;
        _rightTableView.delegate = self;
    }
    return _rightTableView;
}
@end
