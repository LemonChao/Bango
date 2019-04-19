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
            if ([notif.object isEqualToString:@"refreshNetCart"]) {
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
                        kHidHud
                        NSMutableArray *tempArray = [NSArray modelArrayWithClass:[ZCCartModel class] json:responseObject[@"data"]].mutableCopy;
                        
                        UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
                        if (StringIsEmpty(info.asstoken)) {
                            
                            NSArray *locals = [BaseMethod shopGoodsFromeUserDefaults];
                            if (locals.count) {
                                ZCCartModel *model = [[ZCCartModel alloc] initWithName:@"搬果将店铺" aid:@"" selectAll:NO goods:locals];
                                [tempArray insertObject:model atIndex:0];
                            }
                        }

                        [tempArray enumerateObjectsUsingBlock:^(__kindof ZCCartModel * _Nonnull cartModel, NSUInteger idx, BOOL * _Nonnull stop) {
                            if ([cartModel.shop_name isEqualToString:@"推荐商品"]) {
                                self.onlyTuijian = tempArray.count==1;
                            }
                            
                            [cartModel.shop_goods enumerateObjectsUsingBlock:^(__kindof ZCPublicGoodsModel * _Nonnull goods, NSUInteger idx, BOOL * _Nonnull stop) {
                                NSMutableArray *marray = [NSMutableArray array];
                                
                                if ([goods.is_hot boolValue]) {
                                    [marray addObject:@"cart_hotsell"];
                                }
                                if ([goods.shipping_fee boolValue]) {
                                    [marray addObject:@"cart_bubaoyou"];
                                }else {
                                    [marray addObject:@"cart_baoyou"];
                                }
                                goods.tagArray = marray.copy;
                            }];
                            
                        }];
                        
                        self.cartDatas = tempArray.copy;
                        self.selectAll = [NSNumber numberWithBool:NO];
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
                
                [NetWorkManager.sharedManager requestWithUrl:kGods_deleteCart withParameters:@{@"del_id":self.selectedCartIds} withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    if (kStatusTrue) {
                        [subscriber sendNext:@(1)];
                        [self.netCartCmd execute:nil];
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


- (RACCommand *)addCartCmd {
    if (!_addCartCmd) {
        _addCartCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                [NetWorkManager.sharedManager requestWithUrl:kGod_uploadCartFromLocal withParameters:@{@"goods_id":[self goodsIds]} withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    
                    if (kStatusTrue) {
                        [BaseMethod deleteObjectForKey:ZCGoodsDictionary_UDSKey];
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
    return _addCartCmd;
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
    NSMutableArray *goodIds = [NSMutableArray array];
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
                    [goodIds addObject:goodsModel.goods_id];
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
    self.selectedGoodsIds = goodIds.copy;
    return selectedArray;
}

- (NSString *)jieSuanCartIds {
    NSMutableArray *jieSuanIds = [NSMutableArray array];
    [self.cartDatas enumerateObjectsUsingBlock:^(__kindof ZCCartModel * _Nonnull model, NSUInteger section, BOOL * _Nonnull stop) {
        
        if(!([model.shop_name isEqualToString:@"推荐商品"] || [model.shop_name isEqualToString:@"失效商品"]))  {
            
            NSMutableArray <ZCPublicGoodsModel *> *shopList = model.shop_goods.mutableCopy;
            ////遍历分区内cell
            [shopList enumerateObjectsUsingBlock:^(ZCPublicGoodsModel * _Nonnull goodsModel, NSUInteger row, BOOL * _Nonnull stop) {
                
                if (goodsModel.isSelected == YES && goodsModel.goods_id) {
                    NSString *tempString = StringFormat(@"%@:%@", goodsModel.goods_id,goodsModel.have_num);
                    [jieSuanIds addObject:tempString];
                }
            }];
        }
    }];
    return [jieSuanIds componentsJoinedByString:@","];
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


/**
 本地商品id，，支持批量上传

 @return 拼接的上传参数
 */
- (NSString *)goodsIds {
    NSArray *tempArray = [BaseMethod shopGoodsFromeUserDefaults];
    if (!tempArray.count) return @"";
    
    NSMutableArray *mArray = [NSMutableArray array];
    [tempArray enumerateObjectsUsingBlock:^(ZCPublicGoodsModel *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *item = StringFormat(@"%@:%@", obj.goods_id,obj.have_num);
        [mArray addObject:item];
        
    }];
    
    return [mArray componentsJoinedByString:@","];
}


@end
