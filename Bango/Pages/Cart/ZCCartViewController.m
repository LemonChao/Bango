//
//  ZCCartEmptyViewController.m
//  Bango
//
//  Created by zchao on 2019/4/10.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartViewController.h"
#import "ZCCartTuijianCollectionCell.h"
#import "ZCCartEmptySectionHeader.h"
#import "ZCCartViewModel.h"
#import "ZCCartViewController.h"
#import "ZCCartValueCollectionCell.h"
#import "ZCCartBottomView.h"
#import "LCAlertTools.h"

@interface ZCCartViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) ZCCartViewModel *viewModel;

@end

static NSString *cellid = @"ZCCartTuijianCollectionCell_id";
static NSString *valueCellid = @"ZCCartValueCollectionCell_id";
static NSString *headerid = @"ZCCartEmptySectionHeader_id";
static NSString *sysFooterid = @"UICollectionReusableView_id";
static NSString *tuijianHeaderid = @"ZCCartTuijianSectionHeader_id";
static NSString *shopHeaderid = @"ZCCartShopNameSctionHeader_id";
static NSString *invaluedHeaderid = @"ZCCartInvaluedSectionHeader_id";

@implementation ZCCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteGodsToRefreshCart:) name:deleteGodsToRefreshCartNotification object:nil];
//    [MBProgressHUD showActivityText:nil];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self getData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)configCustomNav {
    self.title = @"购物车";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction:)];
    [rightItem setTitleTextAttributes:@{NSForegroundColorAttributeName:AssistColor} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)configViews {
    
    ZCCartBottomView *bottomView = [[ZCCartBottomView alloc] init];
    bottomView.viewModel = self.viewModel;
    [self.view addSubview:bottomView];
    [self.view addSubview:self.collectionView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(WidthRatio(50));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(bottomView.mas_top);
    }];

    @weakify(self);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getData];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:nil];
}


- (void)bindViewModel {
    @weakify(self);
    [RACObserve(self, viewModel.cartDatas) subscribeNext:^(NSArray <__kindof ZCCartModel *> *  _Nullable cartDatas) {
        @strongify(self);
        if (!cartDatas.count) return;
        [self.viewModel calculateTotalPrice];
        [self.collectionView reloadData];
    }];
    
}


- (void)getData {
    @weakify(self);
    [[self.viewModel.netCartCmd execute:nil] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x boolValue]) {
            [MBProgressHUD hideHud];
        }
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    } error:^(NSError * _Nullable error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }];
    
}

//- (void)executeDeleteCmd:(NSString *)cartids {
//    kShowActivity
//
//    [[self.viewModel.godsDeleteCmd execute:cartids] subscribeNext:^(id  _Nullable x) {
//        if ([x boolValue]) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:cartValueChangedNotification object:@"refreshNetCart"];
//        }
//    } error:^(NSError * _Nullable error) {
//
//    }];
//}
//

- (void)rightBarButtonAction:(UIBarButtonItem *)item {
    NSArray *selectItems = [self.viewModel indexsForSelectGoods];
    
    if (!selectItems.count) {
        [MBProgressHUD showText:@"您尚未选中任何商品"];
         return;
    }
    
    [LCAlertTools showTipAlertViewWith:self title:@"您确定要删除该商品" message:nil cancelTitle:@"确定" cancelHandler:^{
        
        UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
        if (StringIsEmpty(info.asstoken)) {
            [BaseMethod deleteGoodsModelForKeys:self.viewModel.selectedGoodsIds];
            [[NSNotificationCenter defaultCenter] postNotificationName:cartValueChangedNotification object:@"refreshNetCart"];

        }else {
//            [self executeDeleteCmd:self.viewModel.selectedCartIds];
            [self.viewModel.godsDeleteCmd execute:nil];
        }
        
    }];
}




/** 清空商品刷新购物车通知 */
- (void)deleteGodsToRefreshCart:(NSNotification *)notif {
    kShowActivity
    [self getData];
}

#pragma mark - collection layout

//item size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCCartModel *model = self.viewModel.cartDatas[indexPath.section];
    
    if ([model.shop_name isEqualToString:@"推荐商品"]) {
        return CGSizeMake(floorf(((SCREEN_WIDTH-WidthRatio(29))/2)), floorf(WidthRatio(300)));
    }else {
        return CGSizeMake(SCREEN_WIDTH, WidthRatio(122));
    }
    
}

// header size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (self.viewModel.onlyTuijian) {//只有推荐
        return CGSizeMake(SCREEN_WIDTH, WidthRatio(290));
    }else {
        return CGSizeMake(SCREEN_WIDTH, WidthRatio(44));
    }
    
}

// footer size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, WidthRatio(8));
}
// minimumLineSpacing
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    ZCCartModel *model = self.viewModel.cartDatas[section];
    
    if ([model.shop_name isEqualToString:@"推荐商品"]) {
        return WidthRatio(5);
    }else {
        return 1;
    }
}
// minimumInteritemSpacing
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return WidthRatio(5);
}

// insetForSection
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    ZCCartModel *model = self.viewModel.cartDatas[section];
    
    if ([model.shop_name isEqualToString:@"推荐商品"]) {
        return UIEdgeInsetsMake(WidthRatio(5), WidthRatio(12), 0, WidthRatio(12));
    }else {
        return UIEdgeInsetsZero;
    }
}

#pragma mark - collection delegate

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        ZCCartModel *model = self.viewModel.cartDatas[indexPath.section];
        
        if ([model.shop_name isEqualToString:@"推荐商品"]) {
            
            if (self.viewModel.onlyTuijian) {//只有推荐
                return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerid forIndexPath:indexPath];
            }else {
                return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:tuijianHeaderid forIndexPath:indexPath];
            }
            
        }else if([model.shop_name isEqualToString:@"失效商品"]) {
            return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:invaluedHeaderid forIndexPath:indexPath];
        }else {
            ZCCartShopNameSctionHeader *shopHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:shopHeaderid forIndexPath:indexPath];
            shopHeader.model = model;
            return shopHeader;
        }
    }
    else {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:sysFooterid forIndexPath:indexPath];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.viewModel.cartDatas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ZCCartModel *model = self.viewModel.cartDatas[section];
    return model.shop_goods.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCCartModel *model = self.viewModel.cartDatas[indexPath.section];
    ZCPublicGoodsModel *godModel = model.shop_goods[indexPath.row];
    
    if ([model.shop_name isEqualToString:@"推荐商品"]) {
        ZCCartTuijianCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
        cell.model = godModel;
        return cell;
    }else {
        ZCCartValueCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:valueCellid forIndexPath:indexPath];
        cell.model = godModel;
        cell.indexPath = indexPath;
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCCartModel *cartModel = self.viewModel.cartDatas[indexPath.section];
    ZCPublicGoodsModel *goodsModel = cartModel.shop_goods[indexPath.row];
    NSDictionary *dic = @{@"goods_id":goodsModel.goods_id};
    ZCWebViewController *webVC = [[ZCWebViewController alloc] initWithPath:@"goods-detail" parameters:dic];
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - setter && getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TabBarHeight-NavBarHeight) collectionViewLayout:layout];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = BackGroundColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.allowsMultipleSelection = YES;
        [_collectionView registerClass:[ZCCartValueCollectionCell class] forCellWithReuseIdentifier:valueCellid];
        [_collectionView registerClass:[ZCCartTuijianCollectionCell class] forCellWithReuseIdentifier:cellid];
        [_collectionView registerClass:[ZCCartEmptySectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerid];
        [_collectionView registerClass:[ZCCartTuijianSectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:tuijianHeaderid];
        [_collectionView registerClass:[ZCCartShopNameSctionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:shopHeaderid];
        [_collectionView registerClass:[ZCCartInvaluedSectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:invaluedHeaderid];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:sysFooterid];
    }
    return _collectionView;
}

- (ZCCartViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZCCartViewModel alloc] init];
    }
    return _viewModel;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:deleteGodsToRefreshCartNotification object:nil];
    
}

@end
