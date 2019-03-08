//
//   NetWorkHelper.m
//
//  Created by 张海彬 on 2018/1/23.
//  Copyright © 2018年 张海彬. All rights reserved.
//

#import "NetWorkHelper.h"
//#import "JSONKit.h"
#import "AFNetworkActivityIndicatorManager.h"
@implementation  NetWorkHelper
//是否开启日志打印
static BOOL _isOpenLog;
//所有的请求
static NSMutableArray *_allSessionTask;
//请求类
static AFHTTPSessionManager *_sessionManager;
#pragma mark ===开始监听网络情况====
+(void)networkStatusWithBlock:(NetworkStatus)networkStatus{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                networkStatus ? networkStatus(NetworkStatusUnknown):nil;
                if (_isOpenLog) NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                networkStatus ? networkStatus( NetworkStatusNotReachable) : nil;
                if (_isOpenLog) NSLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                networkStatus ? networkStatus( NetworkStatusReachableViaWiFi) : nil;
                if (_isOpenLog) NSLog(@"WIFI");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                networkStatus ? networkStatus( NetworkStatusReachableViaWWAN) : nil;
                if (_isOpenLog) NSLog(@"手机自带网络");
                break;
        }
    }];
}
#pragma mark ===是否有网络===
+(BOOL)isNetWork{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}
#pragma mark ===是否是手机网络===
+(BOOL)isWWANNetwork{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}
#pragma mark ===是否是WiFi===
+(BOOL)isWiFiNetwork{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}
#pragma mark ===开启日志打印===
+(void)openLog{
    _isOpenLog = YES;
}
#pragma mark ===关闭日子打印===
+(void)closeLog{
    _isOpenLog = NO;
}
#pragma mark ===取消全部网络请求===
+(void)cancaeAllRequest{
    @synchronized(self){
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}
#pragma mark ===取消指定的网络请求===
+(void)cancaeAllRequestWithURL:(NSString *)URL{
    if([NSString isNOTNull:URL]){return;}
    @synchronized(self){
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}
#pragma mark ===存储所有请求的task数组===
+(NSMutableArray *)allSessionTask{
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}
#pragma mark ====初始化AFHTTPSessionManager相关属性==========================================================
#pragma mark 开始监测网络状态
+(void)load{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
#pragma mark 调用系统方法初始化类
+(void)initialize{
    //增加这几行代码；
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
//    [securityPolicy setAllowInvalidCertificates:YES];
//    securityPolicy.allowInvalidCertificates = NO;
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    _sessionManager.requestSerializer.timeoutInterval = 30.f;
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",@"text/html", nil];
    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}
#pragma mark 重置AFHTTPSessionManager的对象
+ (void)setAFHTTPSessionManagerProperty:(void (^)(AFHTTPSessionManager *))sessionManager {
    sessionManager ? sessionManager(_sessionManager) : nil;
}
#pragma mark  设置网络请求参数的格式
+ (void)setRequestSerializer:( RequestSerializer)requestSerializer {
    _sessionManager.requestSerializer = requestSerializer== RequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}
#pragma mark  设置服务器响应数据格式
+ (void)setResponseSerializer:( RequestSerializer)responseSerializer {
    _sessionManager.responseSerializer = responseSerializer== ResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}
#pragma mark 设置请求超时时间
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    _sessionManager.requestSerializer.timeoutInterval = time;
}
#pragma mark 设置请求头
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}
#pragma mark 是否打开网络状态转圈菊花
+ (void)openNetworkActivityIndicator:(BOOL)open {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}
#pragma mark 配置自建证书的Https请求
+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName {
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    // 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 如果需要验证自建证书(无效证书)，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    // 是否需要验证域名，默认为YES;
    securityPolicy.validatesDomainName = validatesDomainName;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    
    [_sessionManager setSecurityPolicy:securityPolicy];
}
#pragma mark - 上传文件
+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                             parameters:(id)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                               progress:( HttpProgress)progress
                                success:( HTTPResponseBlock)success{
    
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSError *error = nil;
        [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:name error:&error];
        (success && error) ? success(NO,error) : nil;
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (_isOpenLog) {NSLog(@"responseObject = %@",responseObject);}
        [[self allSessionTask] removeObject:task];
        success ? success(YES,responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_isOpenLog) {NSLog(@"error = %@",error);}
        [[self allSessionTask] removeObject:task];
        success ? success(NO,error.localizedDescription) : nil;
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 上传多张图片
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                    names:(NSArray<NSString *> *)names
                                   images:(NSArray<UIImage *> *)images
                                imagesDict:(NSDictionary *)imagesDict
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:( HttpProgress)progress
                                  success:( HTTPResponseBlock)success{
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
//    if (![NSString isNOTNull: [HeaderToken getAccessToken]]) {
        //添加token 例如：
        NSDictionary *headerFieldValueDictionary = @{@"token":@"123"
                                    
                                                     };
        if (headerFieldValueDictionary != nil) {
            for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
                NSString *value = headerFieldValueDictionary[httpHeaderField];
                [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
            }
        }
        manager.requestSerializer = requestSerializer;
//    }else{
////        [[NSNotificationCenter defaultCenter] postNotificationName:LOG_BACK_IN object:nil userInfo:nil];
//        return nil;
//    }
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];

    NSURLSessionTask *sessionTask = [manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (images.count > 0 && images != nil) {
            for (NSUInteger i = 0; i < images.count; i++) {
                // 图片经过等比压缩后得到的二进制文件
                NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
                // 默认图片的文件名, 若fileNames为nil就使用
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *imageFileName = [NSString stringWithFormat:@"%@%ld.%@",str,i,imageType?:@"jpg"];
                NSString *name = @"";
                if (i < names.count) {
                    name = names[i];
                }
                [formData appendPartWithFileData:imageData
                                            name:name
                                        fileName:fileNames ? StringFormat(@"%@.%@",fileNames[i],imageType?:@"jpg") : imageFileName
                                        mimeType:StringFormat(@"image/%@",imageType ?: @"jpg")];
            }
        }else if (imagesDict != nil && imagesDict.allKeys.count > 0){
            [imagesDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[NSArray class]]) {
                    NSArray *imageDatas =(NSArray *)obj;
                    for (NSUInteger i = 0; i < imageDatas.count; i++) {
                        // 图片经过等比压缩后得到的二进制文件
                        NSData *imageData = UIImageJPEGRepresentation(imageDatas[i], imageScale ?: 1.f);
                        // 默认图片的文件名, 若fileNames为nil就使用
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        formatter.dateFormat = @"yyyyMMddHHmmss";
                        NSString *str = [formatter stringFromDate:[NSDate date]];
                        NSString *imageFileName = StringFormat(@"%@%lu.%@",str,(unsigned long)i,imageType?:@"jpg");
                        NSString *name = StringFormat(@"%@",key);
                        
                        [formData appendPartWithFileData:imageData
                                                    name:name
                                                fileName:fileNames ? StringFormat(@"%@.%@",fileNames[i],imageType?:@"jpg") : imageFileName
                                                mimeType:StringFormat(@"image/%@",imageType ?: @"jpg")];
                    }
                }else if([obj isKindOfClass:[UIImage class]]){
                    NSData *imageData = UIImageJPEGRepresentation(obj, imageScale ?: 0.7f);
                    
                    
  
                    NSLog(@"length = = %lu",[imageData length]/1024);
                    // 默认图片的文件名, 若fileNames为nil就使用
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    formatter.dateFormat = @"yyyyMMddHHmmss";
                    NSString *str = [formatter stringFromDate:[NSDate date]];
                    NSString *imageFileName = StringFormat(@"%@.%@",str,imageType?:@"png");
                    NSString *name = StringFormat(@"%@",key);
                    [formData appendPartWithFileData:imageData
                                                name:name
                                            fileName:imageFileName
                                            mimeType:StringFormat(@"image/%@",imageType ?: @"jpg/png/jpeg")];
                }
            }];
        }
       
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            progress ? progress(uploadProgress) : nil;
//        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (_isOpenLog) {NSLog(@"responseObject = %@",responseObject);}
        [[self allSessionTask] removeObject:task];
        id results ;
        if ([responseObject isKindOfClass:[NSData class]]) {
            results = [NetWorkHelper handleResponseObject:responseObject];
            NSLog(@"result = %@",results);
        }else{
            results = responseObject;
        }
        success ? success(YES,results) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_isOpenLog) {NSLog(@"error = %@",error);}
        NSData *data =(NSData *)error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString * str  =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"str = %@",str);
        [[self allSessionTask] removeObject:task];
        success ? success(NO,@"数据上传失败") : nil;
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:( HttpProgress)progress
                              success:( HTTPResponseBlock)success{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    __block NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [[self allSessionTask] removeObject:downloadTask];
        if(success && error) {success(NO,error) ; return ;};
        success ? success(YES,filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    //开始下载
    [downloadTask resume];
    // 添加sessionTask到数组
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil ;
    
    return downloadTask;
}

#pragma mark ====数据处理====
+ (id)handleResponseObject:(NSData *)data {
    
    NSDictionary *dictionary = [NetWorkHelper returnDictionaryWithDataPath:data];
    NSLog(@"dictionary = %@",dictionary);
    //将获取的二进制数据转成字符串
//    NSString *str =    [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    //去掉字符串里的转义字符
//    NSString *str1 = [str stringByReplacingOccurrencesOfString:@"\\" withString:@""];
//    //去掉头和尾的引号“”
//    NSString *str2 = [str1 substringWithRange:NSMakeRange(1, str1.length-2)];
    //最终str2为json格式的字符串，将其转成需要的字典和数组
//    id object = [str objectFromJSONString];
    
    return [NetWorkHelper dictionaryWithJsonString:result];
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return dic;
}
+(NSDictionary*)returnDictionaryWithDataPath:(NSData*)data{
         //  NSData* data = [[NSMutableData alloc]initWithContentsOfFile:path]; 拿路径文件
    NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    NSDictionary* myDictionary = [unarchiver decodeObjectForKey:@"talkData"];
    [unarchiver finishDecoding];
    return myDictionary;
}
@end




/**

 上传文件
 
 @param data 上传的数据
 @param name 上传图片的文件夹名
 @param fileName 上传图片的名字
 @param mimeType 图片格式
 
- (void)appendPartWithFileData:(NSData *)data
                          name:(NSString *)name
                      fileName:(NSString *)fileName
                      mimeType:(NSString *)mimeType;
 */


























































