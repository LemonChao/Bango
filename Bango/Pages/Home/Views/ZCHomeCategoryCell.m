//
//  ZCHomeCategoryCell.m
//  Bango
//
//  Created by zchao on 2019/3/30.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCHomeCategoryCell.h"
#import "UIButton+EdgeInsets.h"
#import "ZCCategoryCollectionCell.h"

@interface ZCHomeCategoryCell ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView *collectionView;


@end

static NSString *cellid = @"ZCCategoryCollectionCell_id";

@implementation ZCHomeCategoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, WidthRatio(12), 0, WidthRatio(12)));
        }];
    }
    
    return self;
}



- (void)setCategoryList:(NSArray<__kindof ZCHomeCategoryModel *> *)categoryList {
    _categoryList = categoryList;
    
    [self.collectionView reloadData];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categoryList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCCategoryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    cell.model = self.categoryList[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ZCHomeCategoryModel *model = self.categoryList[indexPath.row];
    if (model.is_game.boolValue) {
        UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
        
        ZCWebViewController *webVC = [[ZCWebViewController alloc] initWithPath:model.game_url parameters:@{@"asstoken":info.asstoken?:@""}];
        webVC.topInset = 0.f;
        webVC.bottomInset = 0.f;
        [[self viewController].navigationController pushViewController:webVC animated:YES];
        return;
    }

    
    NSDictionary *dic = @{@"category_id":model.category_id,@"key_word":model.category_name};
    ZCWebViewController *webVC = [[ZCWebViewController alloc] initWithPath:@"search-result" parameters:dic];
    [[self viewController].navigationController pushViewController:webVC animated:YES];
}



- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(WidthRatio(70), WidthRatio(94));
        layout.minimumInteritemSpacing = WidthRatio(30);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[ZCCategoryCollectionCell class] forCellWithReuseIdentifier:cellid];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}


@end
