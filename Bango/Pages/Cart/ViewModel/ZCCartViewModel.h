//
//  ZCCartViewModel.h
//  Bango
//
//  Created by zchao on 2019/4/10.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseViewModel.h"
#import "ZCCartModel.h"

NS_ASSUME_NONNULL_BEGIN

//选中商品后无法监测到选中状况，无法计算总价
@interface ZCCartViewModel : ZCBaseViewModel



@property(nonatomic, strong) RACCommand *netCartCmd;

/** 购物车商品总数据 */
@property(nonatomic, copy) NSMutableArray <__kindof ZCCartModel *> *cartDatas;

/** 只有推荐 */
@property(nonatomic, assign) BOOL onlyTuijian;

/** 购物车-删除商品 多商品逗号拼接cart_id "4,5" */
@property(nonatomic, strong) RACCommand *godsDeleteCmd;

/** 选中商品的总价 */
@property(nonatomic, copy) NSNumber *totalPrice;

/** 选中的商品cartIds */
@property(nonatomic, copy) NSString *selectedCartIds;

/** 选中购物车是否全部商品 */
@property(nonatomic, strong) NSNumber *selectAll;

/** 选中商品的 goodsIds */
@property(nonatomic, copy) NSArray *selectedGoodsIds;


/** 添加到购物车，支持批量 (本地保存的商品上传) */
@property(nonatomic, strong) RACCommand *addCartCmd;

/** 计算商品总价 */
-(void)calculateTotalPrice;

/**
 获取被选中的 indexPath
 
 @return return indexPath
 */
- (nullable NSArray<NSIndexPath *>*)indexsForSelectGoods;

/**
 根据被选中的indexpath 删除
 
 @return a new cartDatas
 */
- (NSMutableArray <ZCCartModel *>*)deleteWithSelectedIndexPath:(NSArray<NSIndexPath *> *)indexs;





@end

NS_ASSUME_NONNULL_END
