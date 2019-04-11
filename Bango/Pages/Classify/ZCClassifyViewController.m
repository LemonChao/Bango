//
//  ZCClassifyViewController.m
//  Bango
//
//  Created by zchao on 2019/3/29.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCClassifyViewController.h"
#import "UIButton+EdgeInsets.h"
#import "ZCClassifyViewModel.h"
#import "ZCClassifyLeftCell.h"
#import "ZCClassifyRightVC.h"


@interface ZCClassifyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) ZCClassifyViewModel *viewModel;

@property(nonatomic, strong) UITableView *leftTableView;

@property(nonatomic, strong) ZCClassifyRightVC *rightVC;

@end

static NSString *leftCellid = @"ZCClassifyLeftCell_id";

@implementation ZCClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)configCustomNav {
    
    UIBarButtonItem *newsItem = [[UIBarButtonItem alloc] initWithCustomView:[self buttonItemWithImage:ImageNamed(@"home_news") title:@"消息" target:self action:@selector(newsButtonItemAction:)]];
    UIBarButtonItem *signItem = [[UIBarButtonItem alloc] initWithCustomView:[self buttonItemWithImage:ImageNamed(@"home_signIn") title:@"签到" target:self action:@selector(signButtonItemAction:)]];

    self.navigationItem.rightBarButtonItems = @[newsItem,signItem];
}

- (void)configViews {
    [self.view addSubview:self.leftTableView];
    
    self.rightVC = [[ZCClassifyRightVC alloc] init];
    [self addChildViewController:self.rightVC];
    [self.view addSubview:self.rightVC.view];
    
    
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.width.mas_equalTo(85);
    }];
    
    [self.rightVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.view);
        make.left.equalTo(self.leftTableView.mas_right);
    }];
}


- (void)getData {
//    [[self.viewModel.classifyCmd execute:nil] subscribeNext:^(id  _Nullable x) {
//
//    } error:^(NSError * _Nullable error) {
//
//    }];
    
    [[[self.viewModel.classifyCmd execute:nil] doNext:^(id  _Nullable x) {
        
    }] subscribeNext:^(id  _Nullable x) {
        if ([x boolValue]) {
            [self.leftTableView reloadData];
        }
    } error:^(NSError * _Nullable error) {
        
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCClassifyLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCellid];
    ZCClassifyModel *model = self.viewModel.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WidthRatio(54);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCClassifyModel *model = self.viewModel.dataArray[indexPath.row];
    
    self.rightVC.dataArray = model.good_list;
}









- (void)newsButtonItemAction:(UIBarButtonItem *)item {
    
}

- (void)signButtonItemAction:(UIBarButtonItem *)item {
    
}

#pragma mark - setter && getter

- (ZCClassifyViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZCClassifyViewModel alloc] init];
    }
    return _viewModel;
}

- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_leftTableView registerClass:[ZCClassifyLeftCell class] forCellReuseIdentifier:leftCellid];
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableView.backgroundColor = RGBA(245, 245, 245, 1);
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
    }
    return _leftTableView;
}


- (UIButton *)buttonItemWithImage:(UIImage *)image title:(NSString *)title target:(nullable id)target action:(nullable SEL)action {
    UIButton *button = [UITool richButton:UIButtonTypeCustom title:title titleColor:HEX_COLOR(0xaaaaaa) font:[UIFont systemFontOfSize:11] bgColor:[UIColor whiteColor] image:image];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setImagePosition:ZCImagePositionTop spacing:4];
    return button;
}


@end