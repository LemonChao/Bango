//
//  NSString+Helper.m
//  02.用户登录&注册
//
//  Created by 刘凡 on 13-11-28.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)
+(NSString*)TimeformatFromSeconds:(NSInteger)seconds
{
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    if ([str_hour integerValue]>24) {
       
        format_time = [NSString stringWithFormat:@"%@天%02ld:%@:%@", [NSNumber numberWithInteger:[str_hour integerValue] /24],[str_hour integerValue]%24,str_minute,str_second];
    }

    return format_time;
}
-(NSString *)EmptyStringByWhitespace{
    NSString *str=@"";
    if (self && self.length>0) {
        str=[self stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
        str=[str stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    }
    return [str trimString];
}
#pragma mark - Get请求转换
-(NSString *)getRequestString{
    if ([self isEmptyString])
    {
        return [@"" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    }

    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    //[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}
#pragma mark 清空字符串中的空白字符
- (NSString *)trimString
{
    NSString *trim=[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [trim stringByReplacingOccurrencesOfString:@" " withString:@""];
}
#pragma mark 段前空两格
-(NSString *)emptyBeforeParagraph
{
    NSString *content=[NSString stringWithFormat:@"\t%@",self];
    content=[content stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    return [content stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
}
#pragma mark 是否空字符串
- (BOOL)isEmptyString
{
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }else if ([self isKindOfClass:[NSNull class]]){
        return YES;
    }else if (self==nil){
        return YES;
    }else if ([self isEqualToString:@""] ||[self isEqualToString:@" "]){
        return YES;
    }else if ([self isEqualToString:@"null"] || [self isEqualToString:@"NULL"]){
        return YES;
    }else if ([[self  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0){
        return YES;
    }
    return (!self || self.length <1  || [self isEqualToString:@"(null)"] || [self isEqualToString:@"<null>"]);
    return NO;
}
+(BOOL)isNOTNull:(id)object{
        // 判断是否为空串
    if ([object isEqual:[NSNull null]]) {
            return YES;
    }else if ([object isKindOfClass:[NSNull class]]){
            return YES;
    }else if (object==nil){
            return YES;
    }else if ([(NSString *)object isEqualToString:@""] ||[(NSString *)object isEqualToString:@" "]){
            return YES;
    }else if ([(NSString *)object isEqualToString:@"null"] || [(NSString *)object isEqualToString:@"NULL"]){
            return YES;
    }else if ([(NSString *)object isEqualToString:@"<null>"] || [(NSString *)object isEqualToString:@"<NULL>"]){
        return YES;
    }else if ([(NSString *)object isEqualToString:@"(null)"] || [(NSString *)object isEqualToString:@"(NULL)"]){
        return YES;
    }else if ([[(NSString *)object  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0){
        return YES;
    }
 
    return NO;
}
#pragma mark 返回沙盒中的文件路径
- (NSString *)documentsPath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [path stringByAppendingString:self];
}

#pragma mark 写入系统偏好
- (void)saveToNSDefaultsWithKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:self forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark 读出系统偏好
+ (NSString *)readToNSDefaultsWithKey:(NSString *)key
{
   return  [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
#pragma mark 邮箱验证 MODIFIED BY HELENSONG
-(BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
#pragma mark  银行账号判断
-(BOOL)isValidateBank
{
    NSString *bankNo=@"^\\d{16}|\\d{19}+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNo];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:self];
}
#pragma mark 手机号码验证 MODIFIED BY HELENSONG
-(BOOL) isValidateMobile
{
    if ([self isEmptyString]) {
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
//    NSString *phoneRegex = @"^((1[3578][0-9])|(14[57])|(17[0678]))\\d{8}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[30678])\\d{8}$";
    NSString *MOBILE = @"^1(3[0-9]|4[0-9]|5[0-9]|6[0-9]|7[0-9]|8[0-9]|9[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];


    return [regextestmobile evaluateWithObject:self];
}
+(NSString *)mobileNumberEncryption:(NSString *)number{
    NSString *numberString = [number stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return numberString;
}
#pragma mark- 判断是否是手机号或固话
-(BOOL) isValidateMobileAndTel{
    if ([self isEmptyString]) {
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((\\d{7,8})|(0\\d{2,3}\\d{7,8})|(1[34578]\\d{9}))$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}
#pragma mark-  判断是否是手机号或固话或400
-(BOOL) isValidateMobileAndTelAnd400{
    if ([self isEmptyString]) {
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((\\d{7,8})|(0\\d{2,3}\\d{7,8})|(1[34578]\\d{9})|(400\\d{7}))$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}
#pragma mark 身份证号
-(BOOL) isValidateIdentityCard
{
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])+$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}


#pragma mark 车牌号验证 MODIFIED BY HELENSONG
-(BOOL) isValidateCarNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}

#pragma mark 车型号
- (BOOL) isValidateCarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:self];
}
#pragma mark 用户名
- (BOOL) isValidateUserName
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{3,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:self];
}
#pragma mark 密码
-(BOOL) isValidatePassword
{
    NSString *passWordRegex = @"^[a-zA-Z0-9~!@#$%^&*.]{5,12}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}
-(BOOL)checkPassWord
{
    //6-20位数字和字母组成
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) {
        return YES ;
    }else
        return NO;
}
#pragma mark 检测是否含有非法字符（YES：有 NO：无）
- (BOOL)JudgeTheillegalCharacter{
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}
#pragma mark - 支付密码
-(BOOL)isPayPassword{
    NSString *passWordRegex = @"^[0-9]{6}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}
#pragma mark 昵称
- (BOOL) isValidateNickname
{
    NSString *nicknameRegex = @"^[a-zA-Z0-9\u4e00-\u9fa5]{1,6}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}
#pragma mark - 判断汉子
-(BOOL)isChinese{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

/**
 *正整数
 */
-(BOOL)isNSInteger{
    NSString *match=@"^[1-9]/d*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
/**
 *正小数
 */
-(BOOL)isDouble{
   NSString *match=@"^[1-9]/d*/./d*|0/./d*[1-9]/d*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
#pragma mark - 字符串转日期
- (NSDate *)dateFromString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
      [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    //[dateFormatter setDateFormat: @"MM/dd/yyyy HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:self];
    if (!destDate) {
          [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
        destDate= [dateFormatter dateFromString:self];
    }
    return destDate;
}
#pragma mark - 日期转字符串
+ (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
#pragma mark - 日期转字符串
+ (NSString *)stringFromDateYearMonthsDay:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
#pragma mark - 获取距离现在多久（几分钟前，几小时前，几天前）
+ (NSString *) compareCurrentTime:(NSString *)str
{
//    //把字符串转为NSdate
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *timeDate = [dateFormatter dateFromString:str];
//    //得到与当前时间差
//    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
//    timeInterval = -timeInterval;
//    //标准时间和北京时间差8个小时
//    timeInterval = timeInterval - 8*60*60;
//    long temp = 0;
//    NSString *result;
//    if (timeInterval < 60) {
//        result = [NSString stringWithFormat:@"刚刚"];
//    }
//    else if((temp = timeInterval/60) <60){
//        result = [NSString stringWithFormat:@"%ld分钟前",temp];
//    }
//
//    else if((temp = temp/60) <24){
//        result = [NSString stringWithFormat:@"%ld小时前",temp];
//    }
//
//    else if((temp = temp/24) <30){
//        result = [NSString stringWithFormat:@"%ld天前",temp];
//    }
//
//    else if((temp = temp/30) <12){
//        result = [NSString stringWithFormat:@"%ld月前",temp];
//    }
//    else{
//        temp = temp/12;
//        result = [NSString stringWithFormat:@"%ld年前",temp];
//    }
//
//    return  result;
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval time = fabs([[NSDate date] timeIntervalSinceDate:timeDate]);
    
    NSString *returnString = @"";
    if(time < 60)
        returnString = @"刚刚";
    else if(time >=60 && time < 3600)
        returnString = [NSString stringWithFormat:@"%.0f分钟前",time/60];
    else if(time >= 3600 && time < 3600 * 24)
        returnString = [NSString stringWithFormat:@"%.0f小时前",time/(60 * 60)];
    else if(time >= 3600 * 24 && time < 3600 * 24 * 30)
        returnString = [NSString stringWithFormat:@"%.0f天前",time/(60 * 60 * 24)];
    else if(time >= 3600 * 24 * 30 && time < 3600 * 24 * 30 * 12)
        returnString = [NSString stringWithFormat:@"%.0f月前",time/(60 * 60 * 24 * 30)];
    else if(time >= 3600 * 24 * 30 * 12)
        returnString = [NSString stringWithFormat:@"%.0f年前",time/(60 * 60 * 24 * 30 * 12)];
    
    return returnString;
}
#pragma mark - 手机号加密
/**
 *手机号加密
 */
-(NSString *)EncodeTel{
    NSString *Tel=self;
    if (Tel.length>7) {
         Tel=[Tel stringByReplacingCharactersInRange:NSMakeRange(3,Tel.length-7) withString:@"****"];
    }
    return Tel;
}
#pragma mark - 银行卡号加密
/**
 *银行卡号加密
 *
 */
-(NSString *)EncodeBank{
    NSString *Bank=self;
    if (Bank.length>4) {
         Bank=[Bank stringByReplacingCharactersInRange:NSMakeRange(0,Bank.length-4) withString:@"**** **** **** "];
    }
    return Bank;
}

#pragma mark - 获取两个是间差--
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startD =[date dateFromString:startTime];
    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    return [NSString stringWithFormat:@"%f",value];
}
#pragma mark - 获取两个是间差精确到天，小时，分--
+ (NSString *)TimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSCalendar *cal=[NSCalendar currentCalendar];
    unsigned int unitFlags= NSCalendarUnitYear| NSCalendarUnitMonth| NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *d = [cal components:unitFlags fromDate:[date dateFromString:startTime] toDate:[date dateFromString:endTime] options:0];
    NSLog(@"%ld天%ld小时%ld分钟%ld秒",(long)[d day],(long)[d hour],(long)[d minute],(long)[d second]);
    long second = [d second];//秒
    long minute = [d minute];
    long house = [d hour];
    long day = [d day];
    NSString *str = @"";
    if (day > 0) {
        str = [NSString stringWithFormat:@"还剩%ld天",(long)day];
    }else if (day <=0 && house > 0) {
//        str = [NSString stringWithFormat:@"%d小时%d分",house,minute];
        str = [NSString stringWithFormat:@"还剩%ld小时",(long)house];
    }else if (day<= 0 && house <= 0 && minute > 0) {
        str = [NSString stringWithFormat:@"还剩%ld分钟",(long)minute];
    }else if(day <= 0 && house <= 0 && minute <= 0 && second > 0){
        str = [NSString stringWithFormat:@"还剩%ld秒",(long)second];
    }
    if (str.length == 0) {
        str = @"已过期";
    }
     return [NSString stringWithFormat:@"%@",str];
}
#pragma mark -计算天数后的新日期--
- (NSString *)computeDateWithDays:(NSInteger)days
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *myDate = [NSDate date];
    NSDate *newDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * days];
    
    return [dateFormatter stringFromDate:newDate];
}
- (NSString *)timeStampTurnTime{
    if ([NSString isNOTNull:self]) {
        return @"";
    }
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    = [self doubleValue] ;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    NSLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
    return dateString;
}
#pragma mark ===将时间字符串的字符清除===
-(NSString *)formattingDate{
    NSString *str = self;
    if ([NSString isNOTNull:self]) {
        return @"";
    }
    str  = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
    str  = [str stringByReplacingOccurrencesOfString:@":" withString:@""];
    str  = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}
- (BOOL)isValidUrl
{
    NSString *regex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}
#pragma mark ===金额处理（添加金额逗号）===
+ (NSString *)amountProcessing:(NSString *)string{
    
    
    NSNumberFormatter *moneyFormatter= [[NSNumberFormatter alloc] init];
    moneyFormatter.positiveFormat = @"###,###";
//   return  [moneyFormatter stringFromNumber:@([self floatValue])];
//    return newAmount;
    if ([NSString isNOTNull:string]) {
        return @"";
    }
    
    NSArray *array = [string componentsSeparatedByString:@"."];
    NSString *oneString = array[0];
    long count = oneString.length/3;
    long count1 = oneString.length%3;
    NSMutableArray *stringArray = [NSMutableArray array];
    NSString *reverseString = [NSString reverseWordsInString:oneString];
    for (int i = 0; i < count; i++) {
        NSString *str;
        if (count1 != 0) {
            str = [reverseString substringWithRange:NSMakeRange(i*3,3)];//str2 = "name"
            [stringArray addObject:str];
            
        }else{
            if (i == count - 1) {
                str = [reverseString substringFromIndex:i*3];//str4 = "jiemu"
            }else{
                str = [reverseString substringWithRange:NSMakeRange(i*3,3)];//str2 = "name"
            }
            [stringArray addObject:str];
        }
        
    }
    if (count1 != 0) {
        NSString *str = [reverseString substringFromIndex:count*3];
        [stringArray addObject:str];
    }
    NSString *string1 = @"";
    for (NSString *str in stringArray) {
        if (string1.length == 0) {
            string1 = str;
        }else{
           
            string1 =  [NSString stringWithFormat:@"%@,%@",string1,str];
        }
    }
    
    string1 = [NSString reverseWordsInString:string1];
    if ([string rangeOfString:@"."].location != NSNotFound) {
        
        return [NSString stringWithFormat:@"%@.%@",string1,array[1]];
    }else{
        
        return [NSString stringWithFormat:@"%@.00",string1];
    }

//    if (oneString.length/3) {
//
//    }
//    NSString *str2 = [str substringWithRange:NSMakeRange(3,4)];//str2 = "name"
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
//    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
//    NSString *newAmount = [moneyFormatter stringFromNumber:@([oneString floatValue])];
   
//    if ([string rangeOfString:@"."].location != NSNotFound) {
//        return MMNSStringFormat(@"%@.%@",newAmount,array[1]);
//    }else{
//         return MMNSStringFormat(@"%@.00",newAmount);
//    }
//    NSString *sign = nil;
//    if ([string hasPrefix:@"-"]||[string hasPrefix:@"+"]) {
//        sign = [string substringToIndex:1];
//        string = [string substringFromIndex:1];
//    }
//
//    NSString *pointLast = [string substringFromIndex:[string length]-3];
//    NSString *pointFront = [string substringToIndex:[string length]-3];
//
//    int commaNum = ([pointFront length]-1)/3;
//    NSMutableArray *arr = [NSMutableArray array];
//    for (int i = 0; i < commaNum+1; i++) {
//        int index = [pointFront length] - (i+1)*3;
//        int leng = 3;
//        if(index < 0)
//        {
//            leng = 3+index;
//            index = 0;
//
//        }
//        NSRange range = {index,leng};
//        NSString *stq = [pointFront substringWithRange:range];
//        [arr addObject:stq];
//    }
//    NSMutableArray *arr2 = [NSMutableArray array];
//    for (int i = [arr count]-1; i>=0; i--) {
//
//        [arr2 addObject:arr[i]];
//    }
//    NSString *commaString = [[arr2 componentsJoinedByString:@","] stringByAppendingString:pointLast];
//    if (sign) {
//        commaString = [sign stringByAppendingString:commaString];
//    }
//    return commaString;

}
+ (NSString*)reverseWordsInString:(NSString*)oldStr{
    
    NSMutableString *newStr = [[NSMutableString alloc] initWithCapacity:oldStr.length];
    
    for (int i = (int)oldStr.length - 1; i >= 0; i --) {
        
            unichar character = [oldStr characterAtIndex:i];
        
            [newStr appendFormat:@"%c",character];
        
    }
    
    return newStr;
    
}
- (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}
+ (NSString *) judgePasswordStrength:(NSString*) _password{
    
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    NSArray* termArray1 = [[NSArray alloc] initWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil];
    
    NSArray* termArray2 = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
    
    NSArray* termArray3 = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    
//    NSArray* termArray4 = [[NSArray alloc] initWithObjects:@"~",@"`",@"@",@"#",@"$",@"%",@"^",@"&",@"*",@"(",@")",@"-",@"_",@"+",@"=",@"{",@"}",@"[",@"]",@"|",@":",@";",@"“",@"'",@"‘",@"<",@",",@".",@">",@"?",@"/",@"、", nil];
    
    
    
    NSString* result1 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray1 Password:_password]];
    
    NSString* result2 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray2 Password:_password]];
    
    NSString* result3 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray3 Password:_password]];
    
//    NSString* result4 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray4 Password:_password]];
    
    [resultArray addObject:[NSString stringWithFormat:@"%@",result1]];
    
    [resultArray addObject:[NSString stringWithFormat:@"%@",result2]];
    
    [resultArray addObject:[NSString stringWithFormat:@"%@",result3]];
    
//    [resultArray addObject:[NSString stringWithFormat:@"%@",result4]];
    
    
    
    int intResult=0;
    
    for (int j=0; j<[resultArray count]; j++)
        
    {
        
        
        
        if ([[resultArray objectAtIndex:j] isEqualToString:@"1"])
            
        {
            intResult++;
        }
    }
    
    NSString* resultString = [[NSString alloc] init];
    
    if (intResult <2)
    {
//        resultString = @"密码强度低，建议修改";
        resultString = @"0";
    }
    
    else if (intResult == 2&&[_password length]>=6)
    {
//        resultString = @"密码强度一般";
        resultString = @"1";
    }
    
    if (intResult > 2&&[_password length]>=6)
    {
//        resultString = @"密码强度高";
        resultString = @"2";
    }
    return resultString;
}
#pragma mark - 判断密码强度函数
/*
 声明：包含大写/小写/数字/特殊字符
 两种以下密码强度低
 两种密码强度中
 大于两种密码强度高
 密码强度标准根据需要随时调整
 */
    //判断是否包含
+ (BOOL) judgeRange:(NSArray*) _termArray Password:(NSString*) _password
{
    NSRange range;
    BOOL result =NO;
    for(int i=0; i<[_termArray count]; i++)
    {
        range = [_password rangeOfString:[_termArray objectAtIndex:i]];
        if(range.location != NSNotFound)
        {
            result =YES;
        }
    }
    return result;
}
+ (NSString *)getRidofcomma:(NSString *)string{
   return  [string stringByReplacingOccurrencesOfString:@"," withString:@""];
}
@end
