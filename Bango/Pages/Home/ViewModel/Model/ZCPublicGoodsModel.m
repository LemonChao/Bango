//
//  ZCPublicGoodsModel.m
//  Bango
//
//  Created by zchao on 2019/4/13.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCPublicGoodsModel.h"

@implementation ZCPublicGoodsModel
- (void)encodeWithCoder:(NSCoder *)encoder {
//    [self modelEncodeWithCoder:encoder];
    [encoder encodeObject:self.colonel_content forKey:@"colonel_content"];
    [encoder encodeObject:self.point_exchange forKey:@"point_exchange"];
    [encoder encodeObject:self.point_exchange_type forKey:@"point_exchange_type"];
    [encoder encodeObject:self.shipping_fee forKey:@"shipping_fee"];
    [encoder encodeObject:self.cart_id forKey:@"cart_id"];
    [encoder encodeObject:self.buyer_id forKey:@"buyer_id"];
    [encoder encodeObject:self.shop_name forKey:@"shop_name"];
    [encoder encodeObject:self.goods_name forKey:@"goods_name"];
    [encoder encodeObject:self.introduction forKey:@"introduction"];
    [encoder encodeObject:self.stock forKey:@"stock"];
    [encoder encodeObject:self.max_buy forKey:@"max_buy"];
    [encoder encodeObject:self.min_buy forKey:@"min_buy"];
    [encoder encodeObject:self.promotion_price forKey:@"promotion_price"];
    [encoder encodeObject:self.show_promotion_price forKey:@"show_promotion_price"];
    [encoder encodeObject:self.pic_cover_big forKey:@"pic_cover_big"];
    [encoder encodeObject:self.pic_cover_mid forKey:@"pic_cover_mid"];
    [encoder encodeBool:self.selected forKey:@"selected"];
    [encoder encodeObject:self.tagArray forKey:@"tagArray"];
    //推荐商品
    [encoder encodeObject:self.market_price forKey:@"market_price"];
    [encoder encodeObject:self.show_market_price forKey:@"show_market_price"];
    [encoder encodeObject:self.goods_type forKey:@"goods_type"];
    [encoder encodeObject:self.pic_id forKey:@"pic_id"];
    [encoder encodeObject:self.is_hot forKey:@"is_hot"];
    [encoder encodeObject:self.is_recommend forKey:@"is_recommend"];
    [encoder encodeObject:self.is_new forKey:@"is_new"];
    [encoder encodeObject:self.sales forKey:@"sales"];
    [encoder encodeObject:self.pic_cover_small forKey:@"pic_cover_small"];
    // baseGoodsModel
    [encoder encodeObject:self.have_num forKey:@"have_num"];
    [encoder encodeBool:self.is_pin forKey:@"is_pin"];
    [encoder encodeBool:self.hide forKey:@"hide"];
    [encoder encodeObject:self.goods_id forKey:@"goods_id"];
    [encoder encodeBool:self.deleteEnsure forKey:@"deleteEnsure"];

}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.colonel_content = [decoder decodeObjectForKey:@"colonel_content"];
        self.point_exchange = [decoder decodeObjectForKey:@"point_exchange"];
        self.point_exchange_type = [decoder decodeObjectForKey:@"point_exchange_type"];
        self.shipping_fee = [decoder decodeObjectForKey:@"shipping_fee"];
        self.cart_id = [decoder decodeObjectForKey:@"cart_id"];
        self.buyer_id = [decoder decodeObjectForKey:@"buyer_id"];
        self.shop_name = [decoder decodeObjectForKey:@"shop_name"];
        self.goods_name = [decoder decodeObjectForKey:@"goods_name"];
        self.introduction = [decoder decodeObjectForKey:@"introduction"];
        self.stock = [decoder decodeObjectForKey:@"stock"];
        self.max_buy = [decoder decodeObjectForKey:@"max_buy"];
        self.min_buy = [decoder decodeObjectForKey:@"min_buy"];
        self.promotion_price = [decoder decodeObjectForKey:@"promotion_price"];
        self.show_promotion_price = [decoder decodeObjectForKey:@"show_promotion_price"];
        self.pic_cover_big = [decoder decodeObjectForKey:@"pic_cover_big"];
        self.pic_cover_mid = [decoder decodeObjectForKey:@"pic_cover_mid"];
        self.selected = [decoder decodeBoolForKey:@"selected"];
        self.tagArray = [decoder decodeObjectForKey:@"tagArray"];
        // 推荐商品
        self.market_price = [decoder decodeObjectForKey:@"market_price"];
        self.show_market_price = [decoder decodeObjectForKey:@"show_market_price"];
        self.goods_type = [decoder decodeObjectForKey:@"goods_type"];
        self.pic_id = [decoder decodeObjectForKey:@"pic_id"];
        self.is_hot = [decoder decodeObjectForKey:@"is_hot"];
        self.is_recommend = [decoder decodeObjectForKey:@"is_recommend"];
        self.is_new = [decoder decodeObjectForKey:@"is_new"];
        self.sales = [decoder decodeObjectForKey:@"sales"];
        self.pic_cover_small = [decoder decodeObjectForKey:@"pic_cover_small"];
        // baseGoodsModel
        self.have_num = [decoder decodeObjectForKey:@"have_num"];
        self.is_pin = [decoder decodeBoolForKey:@"is_pin"];
        self.hide = [decoder decodeBoolForKey:@"hide"];
        self.goods_id = [decoder decodeObjectForKey:@"goods_id"];
        self.deleteEnsure = [decoder decodeBoolForKey:@"deleteEnsure"];
    }
    
    return self;
}


// 当 JSON 转为 Model 完成后，该方法会被调用。
// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
// 你也可以在这里做一些自动转换不能完成的工作。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _show_promotion_price = StringFormat(@"￥%@",_promotion_price);
    _show_market_price = StringFormat(@"￥%@",_market_price);

    NSString *cart_id = [NSString stringWithFormat:@"%@",dic[@"cart_id"]];
    
    if (StringIsEmpty(cart_id)) {
        cart_id = @"0";
    }
    _cart_id = cart_id;
    
    NSString *have_num = [NSString stringWithFormat:@"%@",dic[@"have_num"]];
    
    self.hide = ![have_num boolValue];
    return YES;
}


@end
