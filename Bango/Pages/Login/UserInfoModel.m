//
//  UserInfoModel.m
//  Bango
//
//  Created by zchao on 2019/3/15.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

///** 加密token */
//@property(nonatomic, copy) NSString *asstoken;
//
///** 提现密码状态 0:未设置  1:已设置 */
//@property(nonatomic, copy) NSString *txPwdStatus;
//
///** 登陆类型 0:微信登陆  1:支付宝登陆(存在本地)  2:普通登陆 */
//@property(nonatomic, copy) NSString *loginType;
//
///** 登陆次数 新用户次数为1, */
//@property(nonatomic, copy) NSString *loginNum;
//
///** 头像 */
//@property(nonatomic, copy) NSString *avatar;
//
//
//
//- (void)encodeWithCoder:(NSCoder *)encoder {
//    [encoder encodeObject:self.asstoken forKey:@"username"];
//    [encoder encodeObject:self.user_id forKey:@"user_id"];
//    [encoder encodeObject:self.bumen forKey:@"bumen"];
//    [encoder encodeObject:self.zhiwu forKey:@"zhiwu"];
//    [encoder encodeObject:self.tel forKey:@"tel"];
//    [encoder encodeObject:self.city forKey:@"city"];
//    [encoder encodeObject:self.danwei forKey:@"danwei"];
//    [encoder encodeObject:self.avatar forKey:@"avatar"];
//    [encoder encodeObject:self.email forKey:@"email"];
//    [encoder encodeObject:self.sex forKey:@"sex"];
//    [encoder encodeObject:self.personcard forKey:@"personcard"];
//    [encoder encodeObject:self.real_name forKey:@"real_name"];
//    [encoder encodeInteger:self.is_auth forKey:@"is_auth"];
//}
//
//- (instancetype)initWithCoder:(NSCoder *)decoder {
//    self = [super init];
//    if (self) {
//        self.asstoken = [decoder decodeObjectForKey:@"username"];
//        self.user_id = [decoder decodeObjectForKey:@"user_id"];
//        self.bumen = [decoder decodeObjectForKey:@"bumen"];
//        self.zhiwu = [decoder decodeObjectForKey:@"zhiwu"];
//        self.tel = [decoder decodeObjectForKey:@"tel"];
//        self.city = [decoder decodeObjectForKey:@"city"];
//        self.danwei = [decoder decodeObjectForKey:@"danwei"];
//        self.avatar = [decoder decodeObjectForKey:@"avatar"];
//        self.email = [decoder decodeObjectForKey:@"email"];
//        self.sex = [decoder decodeObjectForKey:@"sex"];
//        self.personcard = [decoder decodeObjectForKey:@"personcard"];
//        self.real_name = [decoder decodeObjectForKey:@"real_name"];
//        self.is_auth = [decoder decodeIntegerForKey:@"is_auth"];
//    }
//    return self;
//}



@end
