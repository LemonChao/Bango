//
//  ZCHomeViewModel.m
//  Bango
//
//  Created by zchao on 2019/4/2.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCHomeViewModel.h"

@implementation ZCHomeViewModel


- (RACCommand *)homeCmd {
    if (!_homeCmd) {
        @weakify(self);
        _homeCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSString   * _Nullable useCache) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                [NetWorkManager.sharedManager requestWithUrl:kIndex_home withParameters:@{} withRequestType:POSTTYPE responseCache:^(id  _Nonnull responseObject) {
                    @strongify(self);
                    if (kStatusTrue && [useCache boolValue]) {
                        ZCHomeModel *model = [ZCHomeModel modelWithDictionary:responseObject[@"data"]];
                        self.home = model;
                        self.advImages = [self buildAdvImagesWithModel:model];
                        self.dataArray = [self buildDataArrayWithModel:model];
                        [subscriber sendNext:@(2)];
                    }
                } withSuccess:^(id  _Nonnull responseObject) {
                    @strongify(self);
                    if (kStatusTrue) {
                        ZCHomeModel *model = [ZCHomeModel modelWithDictionary:responseObject[@"data"]];
                        self.home = model;
                        self.advImages = [self buildAdvImagesWithModel:model];
                        self.dataArray = [self buildDataArrayWithModel:model];
                        [subscriber sendNext:@(1)];
                        
                    }else {
                        kShowMessage
                        [subscriber sendNext:@(0)];
                    }
                    
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    kShowError
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _homeCmd;
}

- (NSArray *)buildDataArrayWithModel:(ZCHomeModel *)model {
    NSMutableArray *mArray = [NSMutableArray array];
    if (model.noticeList.count) {
        ZCHomeEverygodsModel *everyGods = [[ZCHomeEverygodsModel alloc] init];
        everyGods.category_alias = @"公告";
        everyGods.goods_list = model.noticeList;
        everyGods.rowHeight = WidthRatio(34);
        everyGods.headerHeight = 0.001;
        everyGods.footerHeight = 0.001;
        everyGods.rows = 1;
        [mArray addObject:everyGods];
    }

    if (model.categoryList.count) {
        ZCHomeEverygodsModel *everyGods = [[ZCHomeEverygodsModel alloc] init];
        everyGods.category_alias = @"分类";
        everyGods.goods_list = model.categoryList;
        everyGods.rowHeight = WidthRatio(95);
        everyGods.headerHeight = WidthRatio(10);
        everyGods.footerHeight = WidthRatio(15);
        everyGods.rows = 1;
        [mArray addObject:everyGods];
    }
    if (model.tuijianList.count) {
        ZCHomeEverygodsModel *everyGods = [[ZCHomeEverygodsModel alloc] init];
        everyGods.goods_list = model.tuijianList;
        everyGods.rowHeight = WidthRatio(135);
        everyGods.category_alias = @"爆款推荐";
        everyGods.category_id = @"tuijian";
        everyGods.headerHeight = WidthRatio(32);
        everyGods.footerHeight = WidthRatio(25);
        everyGods.rows = 1;
        [mArray addObject:everyGods];
    }
    if (model.pintuanList.count) {
        ZCHomeEverygodsModel *everyGods = [[ZCHomeEverygodsModel alloc] init];
        everyGods.goods_list = model.pintuanList;
        everyGods.rowHeight = WidthRatio(115)*((model.pintuanList.count+1)/2) + WidthRatio(5);
        everyGods.category_alias = @"大家一起拼";
        everyGods.category_id = @"pintuan";
        everyGods.headerHeight = WidthRatio(32);
        everyGods.footerHeight = WidthRatio(25);
        everyGods.rows = 1;
        [mArray addObject:everyGods];
    }
    self.tuan = model.pintuanList.count;
    if (model.bango.goods_list.count) {
        model.bango.rowHeight = WidthRatio(110);
        model.bango.category_alias = @"成为搬果小将";
        model.bango.headerHeight = WidthRatio(32);
        model.bango.footerHeight = WidthRatio(25);
        model.bango.rows = model.bango.goods_list.count;
        [mArray addObject:model.bango];
    }
    if (model.everyGods.count) {
        for (ZCHomeEverygodsModel *item in model.everyGods) {
            if (item.goods_list.count) {
                item.rowHeight = WidthRatio(160);
                item.headerHeight = WidthRatio(32);
                item.footerHeight = WidthRatio(25);
                item.rows = item.goods_list.count;
                [mArray addObject:item];
            }
        }
    }
    
    return mArray.copy;
}

- (NSArray *)buildAdvImagesWithModel:(ZCHomeModel *)model {
    if (!model.lunbo.count) return nil;
    
    NSMutableArray *mArray = [NSMutableArray array];
    for (ZCHomeAdvModel *item in model.lunbo) {
        [mArray addObject:item.adv_image];
    }
    
    return mArray.copy;
}

@end
