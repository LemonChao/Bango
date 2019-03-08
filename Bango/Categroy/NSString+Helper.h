//
//  NSString+Helper.h
//  02.用户登录&注册
//
//  Created by 刘凡 on 13-11-28.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

/**根据秒数来转换成天，时，分，秒*/
+(NSString*)TimeformatFromSeconds:(NSInteger)seconds;

/** 将 nil 的字符串转 @"" */
-(NSString *)EmptyStringByWhitespace;

/**字符串转UTF-8*/
-(NSString *)getRequestString;

/** 清空字符串中的空白字符 */
- (NSString *)trimString;

/** 段前空两格 */
-(NSString *)emptyBeforeParagraph;

/**是否空字符串  YES:是空字符串 NO:不是*/
- (BOOL)isEmptyString;

/** 是否空字符串（object:id类型的数据） YES:是空字符串 NO:不是 */
+(BOOL)isNOTNull:(id)object;

/** 返回沙盒中的文件路径 */
- (NSString *)documentsPath;

/** 写入系统偏好（存入本地内存） */
- (void)saveToNSDefaultsWithKey:(NSString *)key;

/** 读出系统偏好（key:对应的key值） */
+ (NSString *)readToNSDefaultsWithKey:(NSString *)key;

/** 判断是否是邮箱 */
-(BOOL)isValidateEmail;

/** 判断是否是手机号*/
-(BOOL) isValidateMobile;
/** 手机号加密*/
+(NSString *)mobileNumberEncryption:(NSString *)number;
/** 判断是否是手机号或固话 */
-(BOOL) isValidateMobileAndTel;

/** 判断是否是手机号或固话或400 */
-(BOOL) isValidateMobileAndTelAnd400;

/** 银行账号判断 */
 -(BOOL)isValidateBank;

/** 身份证号 */
-(BOOL) isValidateIdentityCard;

/** 判断是否是车牌号 */
-(BOOL) isValidateCarNo;

/** 车型号 */
- (BOOL) isValidateCarType;

/** 昵称 */
- (BOOL) isValidateNickname;

/** 密码（6~20位，数字，字母）NO：不是 YES：是*/
-(BOOL)isValidatePassword;

/** 密码（6-20位数字和字母组成）NO：不是 YES：是*/
-(BOOL)checkPassWord;
#pragma mark - 支付密码

/** 支付密码(6位，数字）NO：不是 YES：是*/
-(BOOL)isPayPassword;

/** 用户名 */
- (BOOL) isValidateUserName;

/** 判断汉字 */
-(BOOL)isChinese;

/** 正整数 */
-(BOOL)isNSInteger;
/** 是否含有非法字符 YES：含有 NO：无 */
- (BOOL)JudgeTheillegalCharacter;

/** 正小数*/
-(BOOL)isDouble;

/** 字符串转日期*/
- (NSDate *)dateFromString;

/** 日期转字符串*/
+ (NSString *)stringFromDate:(NSDate *)date;

/** 日期转字符串（date:时间）*/
+ (NSString *)stringFromDateYearMonthsDay:(NSDate *)date;

/** 手机号加密 */
-(NSString *)EncodeTel;

/** 银行卡号中间加密*/
-(NSString *)EncodeBank;

/** 获取两个时间差（startTime:开始时间字符串  endTime:结束时间字符串）*/
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

/**获取两个是间差精确到天，小时，分 （startTime:开始时间字符串  endTime:结束时间字符串）*/
+ (NSString *)TimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

/** 获取距离现在多久（几分钟前，几小时前，几天前）[str:服务器返回时间] */
+ (NSString *) compareCurrentTime:(NSString *)str;
/** 时间戳转时间 */
- (NSString *)timeStampTurnTime;
/** 将时间字符串的字符清除 */
-(NSString *)formattingDate;
/** 金额处理 */
+ (NSString *)amountProcessing:(NSString *)string;
/** 去除逗号*/
+ (NSString *)getRidofcomma:(NSString *)string;
/** 判断密码强度 0:密码强度低。1:密码强度一般 2:密码强度高 */
+ (NSString*)judgePasswordStrength:(NSString*) _password;

- (BOOL)isValidUrl;
@end
