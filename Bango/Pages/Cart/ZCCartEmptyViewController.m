//
//  ZCCartEmptyViewController.m
//  Bango
//
//  Created by zchao on 2019/4/10.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartEmptyViewController.h"
#import "ZCCartTuijianCollectionCell.h"
#import "ZCCartEmptySectionHeader.h"
#import "ZCCartViewModel.h"
#import "ZCCartViewController.h"
#import "ZCCartValueCollectionCell.h"

@interface ZCCartEmptyViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

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

@implementation ZCCartEmptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MBProgressHUD showActivityText:nil];
    [self getData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)configCustomNav {
    self.title = @"购物车";
}
- (void)configViews {
    [self.view addSubview:self.collectionView];
    
    @weakify(self);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getData];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:nil];
}


- (void)getData {
    @weakify(self);
    [[self.viewModel.netCartCmd execute:nil] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x boolValue]) {
            [MBProgressHUD hideHud];
            [self.collectionView reloadData];
        }
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    } error:^(NSError * _Nullable error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }];
    
}

#pragma mark - collection layout

//item size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCCartModel *model = self.viewModel.cartDatas[indexPath.section];

    if ([model.shop_name isEqualToString:@"推荐商品"]) {
        return CGSizeMake(((SCREEN_WIDTH-WidthRatio(29))/2), WidthRatio(300));
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
    ZCCartGodsModel *godModel = model.shop_goods[indexPath.row];

     if ([model.shop_name isEqualToString:@"推荐商品"]) {
         ZCCartTuijianCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
         
         cell.model = godModel;
         return cell;
     }else {
         ZCCartValueCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:valueCellid forIndexPath:indexPath];
         
         cell.model = godModel;
         return cell;
     }
}


#pragma mark - setter && getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TabBarHeight-NavBarHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = BackGroundColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
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

@end
