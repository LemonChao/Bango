//
//  ZCHomeViewController.m
//  Bango
//
//  Created by zchao on 2019/3/30.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCHomeViewController.h"
#import "UIButton+EdgeInsets.h"
#import "ZCHomeCategoryCell.h"
#import "ZCHomeRecommendCell.h"
#import "ZCHomeTuanCell.h"
#import "ZCHomeBangoCell.h"
#import "ZCCategoryEverygodsCell.h"


@interface ZCHomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

static NSString *categoryCellid = @"ZCHomeCategoryCell_id";
static NSString *recommendCellid = @"ZCHomeRecommendCell_id";
static NSString *tuanCellid = @"ZCHomeTuanCell_id";
static NSString *bangoCellid = @"ZCHomeBangoCell_id";
static NSString *everygodsCellid = @"ZCCategoryEverygodsCell_id";


@implementation ZCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)configCustomNav {
    
    UIBarButtonItem *newsItem = [[UIBarButtonItem alloc] initWithCustomView:[self buttonItemWithImage:ImageNamed(@"home_news") title:@"消息" target:self action:@selector(newsButtonItemAction:)]];
    UIBarButtonItem *signItem = [[UIBarButtonItem alloc] initWithCustomView:[self buttonItemWithImage:ImageNamed(@"home_signIn") title:@"签到" target:self action:@selector(signButtonItemAction:)]];
    
    self.navigationItem.rightBarButtonItems = @[newsItem,signItem];
}

- (void)configViews {
    self.view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1 || section == 2) {
        return 1;
    }
    else if (section == 3) {
        return 3;
    }
    else if (section == 4) {
        return 3;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return WidthRatio(100);
    }
    else if (indexPath.section == 1) {
        return WidthRatio(125);
    }
    else if (indexPath.section == 2) {
        return WidthRatio(350);
    }
    else if (indexPath.section == 3) {
        return WidthRatio(110);
    }
    else if (indexPath.section == 4) {
        return WidthRatio(160);
    }
    return WidthRatio(100);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZCHomeCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellid];
        return cell;
    }
    else if (indexPath.section == 1) {
        ZCHomeRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCellid];
        return cell;
    }
    else if (indexPath.section == 2) {
        ZCHomeTuanCell *cell = [tableView dequeueReusableCellWithIdentifier:tuanCellid];
        return cell;
    }
    else if (indexPath.section == 3) {
        ZCHomeBangoCell *cell = [tableView dequeueReusableCellWithIdentifier:bangoCellid];
        return cell;
    }else {
        ZCCategoryEverygodsCell *cell = [tableView dequeueReusableCellWithIdentifier:everygodsCellid];
        return cell;
    }
    
    return nil;
}





- (void)newsButtonItemAction:(UIBarButtonItem *)item {
    
}

- (void)signButtonItemAction:(UIBarButtonItem *)item {
    
}


#pragma mark - setter && getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ZCHomeCategoryCell class] forCellReuseIdentifier:categoryCellid];
        [_tableView registerClass:[ZCHomeRecommendCell class] forCellReuseIdentifier:recommendCellid];
        [_tableView registerClass:[ZCHomeTuanCell class] forCellReuseIdentifier:tuanCellid];
        [_tableView registerClass:[ZCHomeBangoCell class] forCellReuseIdentifier:bangoCellid];
        [_tableView registerClass:[ZCCategoryEverygodsCell class] forCellReuseIdentifier:everygodsCellid];
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}


- (UIButton *)buttonItemWithImage:(UIImage *)image title:(NSString *)title target:(nullable id)target action:(nullable SEL)action {
    UIButton *button = [UITool richButton:UIButtonTypeCustom title:title titleColor:HEX_COLOR(0xaaaaaa) font:[UIFont systemFontOfSize:11] bgColor:[UIColor whiteColor] image:image];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setImagePosition:ZCImagePositionTop spacing:4];
    return button;
}

@end
