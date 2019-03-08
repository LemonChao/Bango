//
//   NetWorkHelper.h
//
//  Created by 张海彬 on 2018/1/23.
//  Copyright © 2018年 张海彬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "HttpRequestAPI.h"
#import "AFNetworking.h"
//#import "HeaderToken.h"
//#import "SFHFKeychainUtils.h"
//#import "AFHTTPSessionManager"
//网络情况类型
typedef NS_ENUM(NSUInteger,NetWorkStatusType) {
    /// 未知网络
    NetworkStatusUnknown,
    /// 无网络
    NetworkStatusNotReachable,
    /// 手机网络
    NetworkStatusReachableViaWWAN,
    /// WIFI网络
    NetworkStatusReachableViaWiFi
};

//网络请求数据格式
typedef NS_ENUM(NSUInteger, RequestSerializer) {
    /// 设置请求数据为JSON格式
     RequestSerializerJSON,
    /// 设置请求数据为二进制格式
     RequestSerializerHTTP,
};
//网络数据响应格式
typedef NS_ENUM(NSUInteger,  ResponseSerializer) {
    /// 设置响应数据为JSON格式
     ResponseSerializerJSON,
    /// 设置响应数据为二进制格式
     ResponseSerializerHTTP,
};
/**定义请求完成的block(isOk=YES,请求成功，isOk=NO，请求失败)*/
typedef void (^ HTTPResponseBlock)(BOOL isOk, id responseObject);
/**定义缓存的block*/
typedef void (^ HTTPRequestCache)(id responseObject);
/// 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小
typedef void (^ HttpProgress)(NSProgress *progress);
/// 网络状态的Block
typedef void(^ NetworkStatus)(NetWorkStatusType status);

@class AFHTTPSessionManager;
@interface  NetWorkHelper : NSObject
/**是否有网络（YES：有 NO：无）*/
+(BOOL)isNetWork;
/**手机网络:YES：是 NO：不是*/
+(BOOL)isWWANNetwork;
/**是否是WiFi：YES：是 NO：不是*/
+(BOOL)isWiFiNetwork;
/** 开启日志打印 (Debug级别) */
+ (void)openLog;
/** 关闭日志打印,默认关闭 */
+ (void)closeLog;
/**取消全部的网络请求*/
+(void)cancaeAllRequest;
/**取消指定的网络请求*/
+(void)cancaeAllRequestWithURL:(NSString *)URL;
/**实时获取网络状态,通过Block回调实时获取(此方法可多次调用)*/
+(void)networkStatusWithBlock:( NetworkStatus)networkStatus;

/**
 文件上传

 @param URL 请求地址
 @param parameters 请求参数
 @param name 上传文件的名字
 @param filePath 文件的地址
 @param progress 上传进度
 @param success 请求成功回调
 @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                             parameters:(id)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                               progress:( HttpProgress)progress
                                success:( HTTPResponseBlock)success;


/**
  上传单/多张图片

 @param URL 请求地址
 @param parameters 请求参数
 @param names 图片对应服务器上的字段（一般是存放图片文件夹的名字，也有可能是服务器所需要key的名字）
 @param images 图片数组，
 @param imagesDict 图片字典（和图片数组对立，二者一个为nil）
 @param fileNames 图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
 @param imageScale 图片文件压缩比 范围 (0.f ~ 1.f)
 @param imageType 图片文件的类型,例:png、jpg(默认类型)....
 @param progress 上传进度信息
 @param success 请求完成的回调
 @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                    names:(NSArray<NSString *> *)names
                                   images:(NSArray<UIImage *> *)images
                               imagesDict:(NSDictionary *)imagesDict
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:( HttpProgress)progress
                                  success:( HTTPResponseBlock)success;


/**
  下载文件

 @param URL 请求地址
 @param fileDir 文件存储目录(默认存储目录为Download)
 @param progress 文件下载的进度信息
 @param success 请求完成的回调(回调参数filePath:文件的路径)
 @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:( HttpProgress)progress
                              success:( HTTPResponseBlock)success;
#pragma mark =============分割线===================
/**
 在开发中,如果以下的设置方式不满足项目的需求,就调用此方法获取AFHTTPSessionManager实例进行自定义设置
 (注意: 调用此方法时在要导入AFNetworking.h头文件,否则可能会报找不到AFHTTPSessionManager的❌)
 @param sessionManager AFHTTPSessionManager的实例
 */
+ (void)setAFHTTPSessionManagerProperty:(void(^)(AFHTTPSessionManager *sessionManager))sessionManager;

/**
 *  设置网络请求参数的格式:默认为二进制格式
 *
 *  @param requestSerializer  RequestSerializerJSON(JSON格式), RequestSerializerHTTP(二进制格式),
 */
+ (void)setRequestSerializer:( RequestSerializer)requestSerializer;

/**
 *  设置服务器响应数据格式:默认为JSON格式
 *
 *  @param responseSerializer  ResponseSerializerJSON(JSON格式), ResponseSerializerHTTP(二进制格式)
 */
+ (void)setResponseSerializer:( RequestSerializer)responseSerializer;

/**
 *  设置请求超时时间:默认为30S
 *
 *  @param time 时长
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time;

/** 设置请求头 */
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

/**
 *  是否打开网络状态转圈菊花:默认打开
 *
 *  @param open YES(打开), NO(关闭)
 */
+ (void)openNetworkActivityIndicator:(BOOL)open;

/**
 配置自建证书的Https请求, 参考链接: http://blog.csdn.net/syg90178aw/article/details/52839103
 
 @param cerPath 自建Https证书的路径
 @param validatesDomainName 是否需要验证域名，默认为YES. 如果证书的域名与请求的域名不一致，需设置为NO; 即服务器使用其他可信任机构颁发
 的证书，也可以建立连接，这个非常危险, 建议打开.validatesDomainName=NO, 主要用于这种情况:客户端请求的是子域名, 而证书上的是另外
 一个域名。因为SSL证书上的域名是独立的,假如证书上注册的域名是www.google.com, 那么mail.google.com是无法验证通过的.
 */
+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName;
@end












































