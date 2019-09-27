//
//  ZCHomeViewController.m
//  Bango
//
//  Created by zchao on 2019/3/30.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCHomeViewController.h"
#import "UIButton+EdgeInsets.h"
#import "ZCHomeNoticeCell.h"
#import "ZCHomeCategoryCell.h"
#import "ZCHomeRecommendCell.h"
#import "ZCHomeTuanCell.h"
#import "ZCHomeBangoCell.h"
#import "ZCCategoryEverygodsCell.h"
#import "ScrollTopButton.h"
#import "ZCHomeViewModel.h"
#import "SDCycleScrollView.h"
#import "ZCHomeTableHeaderFooterView.h"
#import "DHGuidePageHUD.h"
#import "UpdataViewModel.h"
#import "WRNavigationBar.h"
#import "ZCHomePagedFlowView.h"
#import "ZCNewsCenterViewController.h"
#import "UIView+BadgeValue.h"
#import "ZCSystemNoticeVM.h"

@interface ZCHomeViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
/** 轮播图 */
@property (nonatomic, strong) SDCycleScrollView *cycleView;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) ZCHomeViewModel *viewModel;
@property(nonatomic, strong) ZCSystemNoticeVM *noticeViewModel;
@end

static NSString *noticeCellid = @"ZCHomeNoticeCell_id";
static NSString *categoryCellid = @"ZCHomeCategoryCell_id";
static NSString *recommendCellid = @"ZCHomeRecommendCell_id";
static NSString *tuanCellid = @"ZCHomeTuanCell_id";
static NSString *bangoCellid = @"ZCHomeBangoCell_id";
static NSString *everygodsCellid = @"ZCCategoryEverygodsCell_id";
static NSString *blankHeaderid = @"ZCBlankTableHeaderFooterView_id";
static NSString *homeHeaderid = @"ZCHomeTableHeaderView_id";
static NSString *homeFooterid = @"ZCHomeTableFooterView_id";


@implementation ZCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:showGuidePageKey]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:showGuidePageKey];
        DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:@[@"guide_1",@"guide_2",@"guide_3"] buttonIsHidden:NO];
        [[UIApplication sharedApplication].keyWindow addSubview:guidePage];
    }else {
        [MBProgressHUD showActivityText:nil];
        [[[UpdataViewModel alloc]init].updateCmd execute:nil];
    }
    
    [self getDataWithCaches:@"1"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [[self.noticeViewModel.noticeCmd execute:nil] subscribeNext:^(NSNumber  *_Nullable x) {
        
        UIView *newsView = self.navigationItem.rightBarButtonItems.firstObject.customView;
        newsView.badgeValue = StringFormat(@"%@", x.boolValue?@"-1":@"0");
    } error:^(NSError * _Nullable error) {
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)configCustomNav {
//    [super setupNavBar];
    UIBarButtonItem *newsItem = [[UIBarButtonItem alloc] initWithCustomView:[self buttonItemWithImage:ImageNamed(@"home_news") title:@"消息" target:self action:@selector(newsButtonItemAction:)]];
    UIBarButtonItem *signItem = [[UIBarButtonItem alloc] initWithCustomView:[self buttonItemWithImage:ImageNamed(@"home_signIn") title:@"签到" target:self action:@selector(signButtonItemAction:)]];

    UIButton *searchButton = [UITool richButton:UIButtonTypeCustom title:@"搜索" titleColor:AssistColor font:MediumFont(14) bgColor:LineColor image:ImageNamed(@"home_search")];
    searchButton.frame = CGRectMake(WidthRatio(12), 7, SCREEN_WIDTH-88-20-WidthRatio(12+20), 30);
    MMViewBorderRadius(searchButton, WidthRatio(4), 0, [UIColor clearColor]);
    [searchButton setImagePosition:ZCImagePositionLeft spacing:WidthRatio(6)];
    [searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:searchButton];

    self.navigationItem.rightBarButtonItems = @[newsItem,signItem];
}

- (void)configViews {
    [self.view addSubview:self.tableView];
    CGFloat DefaultW = WidthRatio(40);
    ScrollTopButton *button = [[ScrollTopButton alloc] initWithFrame:CGRectMake(self.view.width-DefaultW-WidthRatio(10), self.view.height-TabBarHeight-NavBarHeight-WidthRatio(100), DefaultW, DefaultW) ScrollView:self.tableView];
    [self.view addSubview:button];
    
    @weakify(self);
    
    self.tableView.mj_header = [MJStaticImageHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getDataWithCaches:@"0"];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:nil];
}


/**
 请求数据

 @param caches 是否应用缓存 @"0"不应用
 */
- (void)getDataWithCaches:(NSString *)caches {
    
    @weakify(self);
    [[self.viewModel.homeCmd execute:caches] subscribeNext:^(NSNumber *_Nullable x) {
        @strongify(self);
        if ([x boolValue]) {
            [MBProgressHUD hideHud];
            [self.tableView reloadData];
            
            if (self.viewModel.advImages.count) {
//                self.cycleView.imageURLStringsGroup = self.viewModel.advImages;
                [(ZCHomePagedFlowView *)self.tableView.tableHeaderView setLunbos:self.viewModel.home.lunbo];
                [self.tableView reloadData];

            }
        }
        
        if (x.integerValue == 1) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } error:^(NSError * _Nullable error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    ZCHomeEverygodsModel *everyModel = self.viewModel.dataArray[section];
    return everyModel.headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    ZCHomeEverygodsModel *everyModel = self.viewModel.dataArray[section];
    return everyModel.footerHeight;

}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section < 2) {
        ZCHomeBlankTableHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:blankHeaderid];
        return header;
    }else {
        ZCHomeTableHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:homeHeaderid];
        header.model = self.viewModel.dataArray[section];
        return header;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section < 2) {
        ZCHomeBlankTableHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:blankHeaderid];
        return footer;
    }else {
        ZCHomeTableFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:homeFooterid];
        return footer;
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger index = self.viewModel.hasTuan ? 3 : 2;
    if (section < index) {
        return 1;
    }else {
        ZCHomeEverygodsModel *everyModel = self.viewModel.dataArray[section];
        return everyModel.goods_list.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    ZCHomeEverygodsModel *everyModel = self.viewModel.dataArray[indexPath.section];
    return everyModel.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ZCHomeEverygodsModel *model = self.viewModel.dataArray[indexPath.section];

    if (self.viewModel.hasTuan) { //存在拼团
        if (indexPath.section == 0) {
            ZCHomeNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:noticeCellid];
            cell.notics = model.goods_list;
            return cell;
        }
        else if (indexPath.section == 1) {
            ZCHomeCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellid];
            cell.categoryList = model.goods_list;
            return cell;
        }
        else if (indexPath.section == 2) {
            
            ZCHomeRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCellid];
            cell.tuijianList = model.goods_list;
            return cell;
        }
        else if (indexPath.section == 3) {
            
            ZCHomeTuanCell *cell = [tableView dequeueReusableCellWithIdentifier:tuanCellid];
            cell.pintuanList = model.goods_list;
            return cell;
        }else if (indexPath.section == 4){//4
            ZCHomeBangoCell *cell = [tableView dequeueReusableCellWithIdentifier:bangoCellid];
            cell.model = model.goods_list[indexPath.row];
            return cell;
        }
        else {
            ZCCategoryEverygodsCell *cell = [tableView dequeueReusableCellWithIdentifier:everygodsCellid];
            cell.model = model.goods_list[indexPath.row];
            cell.lineView.hidden = indexPath.row == model.goods_list.count-1;
            return cell;
        }
    }
    else {
        if (indexPath.section == 0) {
            ZCHomeNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:noticeCellid];
            cell.notics = model.goods_list;
            return cell;
        }
        else if (indexPath.section == 1) {
            ZCHomeCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellid];
            cell.categoryList = model.goods_list;
            return cell;
        }
        else if (indexPath.section == 2) {
            
            ZCHomeRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCellid];
            cell.tuijianList = model.goods_list;
            return cell;
        }
        else if (indexPath.section == 3) {
            
            ZCHomeBangoCell *cell = [tableView dequeueReusableCellWithIdentifier:bangoCellid];
            cell.model = model.goods_list[indexPath.row];
            return cell;
        }
        else {
            ZCCategoryEverygodsCell *cell = [tableView dequeueReusableCellWithIdentifier:everygodsCellid];
            cell.model = model.goods_list[indexPath.row];
            cell.lineView.hidden = indexPath.row == model.goods_list.count-1;
            return cell;
        }
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZCHomeEverygodsModel *model = self.viewModel.dataArray[indexPath.section];
    
    if (self.viewModel.hasTuan) {
        if (indexPath.section >= 4) {
            ZCPublicGoodsModel *goods = model.goods_list[indexPath.row];
            NSDictionary *dic = @{@"goods_id":goods.goods_id};
            ZCWebViewController *webVC = [[ZCWebViewController alloc] initWithPath:@"goods-detail" parameters:dic];
            [self.navigationController pushViewController:webVC animated:YES];
        }
    }
    else {
        if (indexPath.section >= 3) {
            ZCPublicGoodsModel *goods = model.goods_list[indexPath.row];
            NSDictionary *dic = @{@"goods_id":goods.goods_id};
            ZCWebViewController *webVC = [[ZCWebViewController alloc] initWithPath:@"goods-detail" parameters:dic];
            [self.navigationController pushViewController:webVC animated:YES];
        }
    }

}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static float newy = 0;
    static float oldy = 0;
    static BOOL expland = YES;
    newy= scrollView.contentOffset.y;
    if ((newy - oldy >= 8)&& newy > 0 && expland) { //上滚(非反弹上滚)，速度合格,展开状态
        [UIView animateWithDuration:0.3 animations:^{
            [self setNavigationBarTransformProgress:1];
        } completion:^(BOOL finished) {
            expland = NO;
        }];
    }

    if (oldy-newy >= 8 && !expland) {//下拉,速度合格,收回状态
        [UIView animateWithDuration:0.3 animations:^{
            [self setNavigationBarTransformProgress:0];
        } completion:^(BOOL finished) {
            expland = YES;
        }];
    }
    oldy = newy;
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
    [self.navigationController.navigationBar wr_setTranslationY:(-44 * progress)];
    self.tableView.top = -44 * progress;
    self.tableView.height = SCREEN_HEIGHT-NavBarHeight-TabBarHeight+44*progress;
    // 有系统的返回按钮，所以 hasSystemBackIndicator = YES
    [self.navigationController.navigationBar wr_setBarButtonItemsAlpha:(1 - progress) hasSystemBackIndicator:YES];
}



#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSDictionary *dic = @{@"goods_id":@"12"};
    
    ZCWebViewController *webView = [[ZCWebViewController alloc] initWithPath:@"goods-detail" parameters:dic];
    [self.navigationController pushViewController:webView animated:YES];
}

- (void)searchButtonAction:(UIButton *)button {
    ZCWebViewController *webView = [[ZCWebViewController alloc] initWithPath:@"search" parameters:nil];
    [self.navigationController pushViewController:webView animated:YES];
}

- (void)newsButtonItemAction:(UIBarButtonItem *)item {
    ZCNewsCenterViewController *newsVC = [[ZCNewsCenterViewController alloc] init];
    newsVC.noticeVM = self.noticeViewModel;
    [self.navigationController pushViewController:newsVC animated:YES];
}

- (void)signButtonItemAction:(UIBarButtonItem *)item {
    ZCWebViewController *webVC = [[ZCWebViewController alloc] initWithPath:@"sign-in" parameters:@{}];
    [self.navigationController pushViewController:webVC animated:YES];
}


#pragma mark - setter && getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-TabBarHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        ZCHomePagedFlowView *header = [[ZCHomePagedFlowView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthRatio(164))];
        _tableView.tableHeaderView = header;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ZCHomeNoticeCell class] forCellReuseIdentifier:noticeCellid];
        [_tableView registerClass:[ZCHomeCategoryCell class] forCellReuseIdentifier:categoryCellid];
        [_tableView registerClass:[ZCHomeRecommendCell class] forCellReuseIdentifier:recommendCellid];
        [_tableView registerClass:[ZCHomeTuanCell class] forCellReuseIdentifier:tuanCellid];
        [_tableView registerClass:[ZCHomeBangoCell class] forCellReuseIdentifier:bangoCellid];
        [_tableView registerClass:[ZCCategoryEverygodsCell class] forCellReuseIdentifier:everygodsCellid];
        [_tableView registerClass:[ZCHomeBlankTableHeaderFooterView class] forHeaderFooterViewReuseIdentifier:blankHeaderid];
        [_tableView registerClass:[ZCHomeTableHeaderView class] forHeaderFooterViewReuseIdentifier:homeHeaderid];
        [_tableView registerClass:[ZCHomeTableFooterView class] forHeaderFooterViewReuseIdentifier:homeFooterid];
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = HEX_COLOR(0xf5f5f5);
    }
    return _tableView;
}

- (SDCycleScrollView *)cycleView {
    if (!_cycleView) {
        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(WidthRatio(12), WidthRatio(10), SCREEN_WIDTH-WidthRatio(24), WidthRatio(144)) delegate:self placeholderImage:nil];
        _cycleView.backgroundColor = [UIColor whiteColor];
        _cycleView.showPageControl = NO;
        _cycleView.autoScrollTimeInterval = 4;
    }
    return _cycleView;
}

- (ZCHomeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZCHomeViewModel alloc] init];
    }
    return _viewModel;
}

- (ZCSystemNoticeVM *)noticeViewModel {
    if (!_noticeViewModel) {
        _noticeViewModel = [[ZCSystemNoticeVM alloc] init];
    }
    return _noticeViewModel;
}

- (UIButton *)buttonItemWithImage:(UIImage *)image title:(NSString *)title target:(nullable id)target action:(nullable SEL)action {
    UIButton *button = [UITool richButton:UIButtonTypeCustom title:title titleColor:HEX_COLOR(0xaaaaaa) font:[UIFont systemFontOfSize:11] bgColor:[UIColor whiteColor] image:image];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setImagePosition:ZCImagePositionTop spacing:4];
    return button;
}

@end
