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
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.asstoken = [decoder decodeObjectForKey:@"asstoken"];
        self.txPwdStatus = [decoder decodeObjectForKey:@"txPwdStatus"];
        self.loginType = [decoder decodeObjectForKey:@"loginType"];
        self.loginNum = [decoder decodeObjectForKey:@"loginNum"];
        self.avatar = [decoder decodeObjectForKey:@"avatar"];
    }
    return self;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"avatar" : @"user_headimg",
             @"txPwdStatus" : @"tx_pwd_status",
             @"loginType" : @"login_type",
             @"loginNum" : @"login_num"};
}

@end
