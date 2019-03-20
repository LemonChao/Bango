//
//  UserInfoModel.m
//  Bango
//
//  Created by zchao on 2019/3/15.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "UserInfoModel.h"


@implementation UserInfoModel

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.asstoken forKey:@"asstoken"];
    [encoder encodeObject:self.txPwdStatus forKey:@"txPwdStatus"];
    [encoder encodeObject:self.loginType forKey:@"loginType"];
    [encoder encodeObject:self.loginNum forKey:@"loginNum"];
    [encoder encodeObject:self.avatar forKey:@"avatar"];
    [encoder encodeObject:self.avatarhead forKey:@"avatarhead"];
    [encoder encodeObject:self.userName forKey:@"userName"];
    [encoder encodeObject:self.userTel forKey:@"userTel"];
    [encoder encodeObject:self.userTelIsset forKey:@"userTelIsset"];
    [encoder encodeObject:self.nickName forKey:@"nickName"];
    [encoder encodeObject:self.userPasswordStatus forKey:@"userPasswordStatus"];

}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.asstoken = [decoder decodeObjectForKey:@"asstoken"];
        self.txPwdStatus = [decoder decodeObjectForKey:@"txPwdStatus"];
        self.loginType = [decoder decodeObjectForKey:@"loginType"];
        self.loginNum = [decoder decodeObjectForKey:@"loginNum"];
        self.avatar = [decoder decodeObjectForKey:@"avatar"];
        self.avatarhead = [decoder decodeObjectForKey:@"avatarhead"];
        self.userName = [decoder decodeObjectForKey:@"userName"];
        self.userTel = [decoder decodeObjectForKey:@"userTel"];
        self.userTelIsset = [decoder decodeObjectForKey:@"userTelIsset"];
        self.nickName = [decoder decodeObjectForKey:@"nickName"];
        self.userPasswordStatus = [decoder decodeObjectForKey:@"userPasswordStatus"];

    }
    return self;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"avatar" : @"user_headimg",
             @"txPwdStatus" : @"tx_pwd_status",
             @"loginType" : @"login_type",
             @"loginNum" : @"login_num",
             @"userName" : @"user_name",
             @"userTel" : @"user_tel",
             @"userTelIsset" : @"user_tel_isset",
             @"nickName" : @"nick_name",
             @"userPasswordStatus" : @"user_password_status",
             };
}

@end
