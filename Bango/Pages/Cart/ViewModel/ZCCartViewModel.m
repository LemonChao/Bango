//
//  ZCCartViewModel.m
//  Bango
//
//  Created by zchao on 2019/4/10.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartViewModel.h"

@implementation ZCCartViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.totalPrice = @(0);
        self.selectAll = @(0);
        
        @weakify(self);
        [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:cartValueChangedNotification object:nil] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(NSNotification *notif) {
            @strongify(self);
            NSLog(@"object:%@ /nuserInfo:%@", notif,notif.userInfo);
            
            //减1 需要reload ，减到0 删除商品(二次确认)
            if ([notif.object isEqualToString:@"removeGoods"]) {
                [self.netCartCmd execute:nil];
            }
            
            if ([notif.object isEqualToString:@"selectAction"]) { //商品选中事件
                //重新复制一份，改变指针地址，触发VC里的KVO
                [self indexsForSelectGoods];
                self.cartDatas = self.cartDatas.copy;
            }
        }];
        
        
    }
    return self;
}


- (RACCommand *)netCartCmd {
    if (!_netCartCmd) {
        _netCartCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                [NetWorkManager.sharedManager requestWithUrl:kChart_like withParameters:@{} withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    if (kStatusTrue) {
                        
                        
                        NSMutableArray *tempArray = [NSArray modelArrayWithClass:[ZCCartModel class] json:responseObject[@"data"]].mutableCopy;
                        
                        UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
                        if (StringIsEmpty(info.asstoken)) {
                            NSDictionary *goodDic = [BaseMethod readObjectWithKey:ZCGoodsDictionary_UDSKey];
                            
                            if (goodDic.allValues.count) {
                                ZCCartModel *model = [[ZCCartModel alloc] initWithName:@"搬果将店铺" aid:@"" selectAll:NO goods:goodDic.allValues];
                                [tempArray insertObject:model atIndex:0];
                            }
                        }

                        [tempArray enumerateObjectsUsingBlock:^(__kindof ZCCartModel * _Nonnull cartModel, NSUInteger idx, BOOL * _Nonnull stop) {
                            if ([cartModel.shop_name isEqualToString:@"推荐商品"]) {
                                self.onlyTuijian = tempArray.count==1;
                            }
                        }];
                        
                        self.cartDatas = tempArray.copy;
                        [subscriber sendNext:@(1)];
                    }else {
                        kShowMessage;
                        [subscriber sendNext:@(0)];
                    }
                    
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    kShowError;
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _netCartCmd;
}

- (RACCommand *)godsDeleteCmd {
    if (!_godsDeleteCmd) {
        _godsDeleteCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSString * _Nullable cartIds) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                [NetWorkManager.sharedManager requestWithUrl:kGods_deleteCart withParameters:@{@"del_id":cartIds} withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    if (kStatusTrue) {
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
    return _godsDeleteCmd;
}

// 计算选中的总价
-(void)calculateTotalPrice {
    
    [self.cartDatas enumerateObjectsUsingBlock:^(__kindof ZCCartModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        if(!([model.shop_name isEqualToString:@"推荐商品"] || [model.shop_name isEqualToString:@"失效商品"]))  {
            
            NSUInteger totalPrice = 0;
            for (ZCPublicGoodsModel *goods in model.shop_goods) {
                if (goods.isSelected) {
                    totalPrice += goods.promotion_price.integerValue * goods.have_num.intValue;
                }
            }
            self.totalPrice = [NSNumber numberWithUnsignedInteger:totalPrice];
        }
    }];
}



/**
 获取被选中的 indexPath,更新全选，分区选中状态

 @return return indexPath
 */
- (nullable NSArray<NSIndexPath *>*)indexsForSelectGoods {
    
    NSMutableArray *selectedArray = [NSMutableArray array];
    NSMutableArray *cartIds = [NSMutableArray array];
    
    __block BOOL selectAll = YES;
    [self.cartDatas enumerateObjectsUsingBlock:^(__kindof ZCCartModel * _Nonnull model, NSUInteger section, BOOL * _Nonnull stop) {
        
        if(!([model.shop_name isEqualToString:@"推荐商品"] || [model.shop_name isEqualToString:@"失效商品"]))  {
            
            __block BOOL sectionSelect = YES;
            NSMutableArray <ZCPublicGoodsModel *> *shopList = model.shop_goods.mutableCopy;
            ////遍历分区内cell
            [shopList enumerateObjectsUsingBlock:^(ZCPublicGoodsModel * _Nonnull goodsModel, NSUInteger row, BOOL * _Nonnull stop) {
                
                if (goodsModel.isSelected == YES) {
                    NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:section];
                    [selectedArray addObject:index];
                    
                    [cartIds addObject:goodsModel.cart_id];
                }else {
                    sectionSelect = NO;
                }
            }];
            
            model.selectAll = sectionSelect;
            if (model.isSelectAll == NO) {
                selectAll = NO;
            }
        }
    }];
    
    self.selectedCartIds = [cartIds componentsJoinedByString:@","];
    self.selectAll = [NSNumber numberWithBool:selectAll];
    return selectedArray;
}



/**
 根据被选中的indexpath 删除

 @return a new cartDatas
 */
- (NSMutableArray <ZCCartModel *>*)deleteWithSelectedIndexPath:(NSArray<NSIndexPath *> *)indexs {
    
    for (NSIndexPath *indexPath in indexs) {
        
        ZCCartModel *model = self.cartDatas[indexPath.section];
        
        [model.shop_goods removeObjectAtIndex:indexPath.row];
        
        if (model.shop_goods.count == 0) {
            [self.cartDatas removeObject:model];
        }
    }
    
    return self.cartDatas.mutableCopy;
}

@end
