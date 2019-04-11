//
//  ZCCartEmptyViewController.m
//  Bango
//
//  Created by zchao on 2019/4/10.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartEmptyViewController.h"
#import "ZCCartEmptyCollectionCell.h"
#import "ZCCollectionSectionHeader.h"
#import "ZCCartViewModel.h"
#import "ZCCartViewController.h"

@interface ZCCartEmptyViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) ZCCartViewModel *viewModel;

@end

static NSString *cellid = @"ZCCartEmptyCollectionCell_id";
static NSString *headerid = @"ZCCollectionSectionHeader_id";

@implementation ZCCartEmptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD showActivityText:nil];
    [self getData];
}

- (void)configCustomNav {
    self.title = @"购物车";
}
- (void)configViews {
    [self.view addSubview:self.collectionView];
    ZCCartViewController *vc = [[ZCCartViewController alloc] init];
    [self addChildViewController:vc];
    vc.view.frame = self.view.bounds;
    [self.view addSubview:vc.view];
    
//    vc.view.hidden = YES;
    
    
    @weakify(self);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getData];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:nil];
}

- (void)addChildVC {
    ZCCartViewController *vc = [[ZCCartViewController alloc] init];
    [self addChildViewController:vc];
    vc.view.frame = self.view.bounds;
    [self.view addSubview:vc.view];
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ZCCollectionSectionHeader *view;
    if (kind == UICollectionElementKindSectionHeader) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerid forIndexPath:indexPath];
    }
    
    return view;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.tuijianDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCCartEmptyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    ZCCartTuijianModel *model = self.viewModel.tuijianDatas[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)getData {
    @weakify(self);
    [[self.viewModel.emptyCartCmd execute:nil] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x boolValue]) {
            [MBProgressHUD hideHud];
            [self.collectionView reloadData];
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self.collectionView.mj_footer resetNoMoreData];
        }
        
        [self.collectionView.mj_header endRefreshing];
    } error:^(NSError * _Nullable error) {
        [self.collectionView.mj_header endRefreshing];
    }];
    
}

#pragma mark - setter && getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(((SCREEN_WIDTH- WidthRatio(29))/2), WidthRatio(300));
        layout.minimumLineSpacing = WidthRatio(5);
        layout.minimumInteritemSpacing = WidthRatio(5);
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, WidthRatio(290));
        layout.sectionInset = UIEdgeInsetsMake(WidthRatio(5), WidthRatio(12), 0, WidthRatio(12));
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TabBarHeight-NavBarHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = BackGroundColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[ZCCartEmptyCollectionCell class] forCellWithReuseIdentifier:cellid];
        [_collectionView registerClass:[ZCCollectionSectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerid];
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
