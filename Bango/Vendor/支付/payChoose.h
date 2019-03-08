//
//  payChoose.h
//  ShanDianPaoTui
//
//  Created by 张海彬 on 2017/11/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSUInteger, PayManagerType) {
    AliPayType=0,//支付宝支付
    WXPayType ,//微信支付
};
@interface payChoose : UIView

+(payChoose *)showPayChooseViewOrderDict:(NSDictionary *)orderData payTheCallback:(void (^) (BOOL isPaySucceed))payTheCallback;
/**
 订单ID
 */
@property (nonatomic,strong)NSString *orderID;

@property (nonatomic,strong)NSDictionary *orderData;

/**
 支付价钱
 */
@property (nonatomic,strong)NSString *paymentAmount;

/**
 支付完成后回调
 */
@property (nonatomic, copy) void (^payTheCallback) (BOOL isPaySucceed);
@end
