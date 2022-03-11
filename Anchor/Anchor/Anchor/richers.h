//
//  richers.h
//  richers
//
//  Created by hk on 2021/9/29.
//

#import <Foundation/Foundation.h>
#import "BodyEncodeResp.h"
#import "NativeCallback.h"
/**
 加密解密类型
 */
typedef enum {
    
    EncodeType_Image,
    EncodeType_Video
    
}EncodeType;

typedef enum {
    
    APP_DEV,
    APP_TEST
    
}EAppModel;
//回调bloack
typedef void(^DomainCheckCallback)(bool ok);


//监听回调
@protocol RichersNativeCallBack <NSObject>

@optional
     
-(BOOL)checkDomain:(NSString*)url;

@end




typedef enum {
    
    Ocdomain_download,
    Ocdomain_notice,
    Ocdomain_appvgrayscale,
    Ocdomain_update,
    Ocdomain_uc,
    Ocdomain_api,
    Ocdomain_im,
    Ocdomain_oss,
    Ocdomain_advertisement,
    Ocdomain_moments,
}OC_DomainType;


typedef enum {
    XTokenType_UC,
    XTokenType_API,
    XTokenType_IM,
    
}XTokenType;


typedef enum {
    
    IOSPackage_Def,
    IOSPackage_Sign,
    IOSPackage_TF
        
}IosPackageType;


@interface richers : NSObject

/// native 初始化
/// @param appPath 需要增加的app路径
+(void)initNative:(NSString*)appPath;


//自定义回调
@property(nonatomic,weak)id<RichersNativeCallBack> delegate;


//native listener
@property(nonatomic,weak)id<NativeListener> nativelistener;

/// 构造
+(richers*)defaultRichers;


/// 加密信息
/// @param body 加密的字节流
+(BodyEncodeResp*)encodeMessage:(NSData*) body;

/// 解密信息
/// @param encodeKey 收到的key
/// @param body 需要解密的字节流
+(BodyEncodeResp*)decodeMessage:(NSString*)encodeKey body:(NSData*)body;

///// 设置uctoken
///// @param ucToken 设置的值
//+(void)setUcToken:(NSString*)ucToken;
//
//
///// 设置apitoken
///// @param apiToken 设置的值
//+(void)setApiToken:(NSString*)apiToken;
//
//
////获取uctoken
//+(NSString*)getUcToken;
//
//
////获取Apitoken
//+(NSString*)getApiToken;




/// 刷新token
/// @param tokenType 类型
/// @param token 值
+(void)refreshToken:(XTokenType)tokenType token:(NSString*)token;



/// 根据类型获取token
/// @param tokenType 类型
+(NSString*)getToken:(XTokenType)tokenType;


//获取会员地址
+(NSString*)getMemberVipUrl;


//获取钱包地址
+(NSString*)getWalletUrl;


//获取钱包余额
+(NSString*)getShowWalletUrl;


//获取分享地址
+(NSString*)getShareAgentUrl;


//获取im聊天地址
+(NSString*)getImUrl;


/// 加密媒体资源数据
/// @param encodeType 加密类型
/// @param src 需要加密的数据
+(NSData*)encodeMedia:(EncodeType)encodeType src:(NSData*)src;



/// 解密媒体资源数据
/// @param encodeType 解密类型
/// @param src 解密数据
+(NSData*)decodeMedia:(EncodeType)encodeType src:(NSData*)src;



/// 通过域名类型获取信息
/// @param type 域名类型
+(NSString*)getCanUseUrl:(OC_DomainType)type;



/// 刷新域名信息
/// @param type 类型
/// @param array 值
+(void)refreshDomainList:(OC_DomainType)type array:(NSMutableArray*)array;



+(void)updateDomainList:(NSMutableArray*)array;

/// 检测域名是否可用
/// @param type 类型
/// @param callback 回调
+(void)checkItem:(OC_DomainType)type callback:(DomainCheckCallback)callback;



/// body加密
/// @param path Api路径
/// @param body pb
/// @param type 域名
+(NSData*)encodeBody:(NSString*)path body:(NSData*)body type:(OC_DomainType)type timeSpan:(NSString*)timeSpan;



/// 解密数据
/// @param data 需要解密的数据
+(NSData*)decodeBody:(NSData*)data type:(OC_DomainType)type;



/// 设置ap类型
/// @param aModel 模式
/// @param debugNetUrl 调试地址
/// @param encodeBody 是否加密body
+(void)setApp:(EAppModel)aModel debugNetUrl:(NSString*)debugNetUrl encodeBody:(bool)encodeBody;



/// 获取请求地址
/// @param type 类型
/// @param apiName api地址
+(NSString*)getRequestUrl:(OC_DomainType)type apiName:(NSString*)apiName;


//获取https证书
+(NSData*)getHttpsP12;

//获取httpscer
+(NSData*)getHttpsCer;



/// base64 解析
/// @param src 原字符串
+(NSData*)base64DecodeToNsData:(NSString*)src;

 

/// 获取域名类型,根据包名
/// @param packageName 包名
+(OC_DomainType)getDomainType:(NSString*)packageName;



/// 是否是加密图片
/// @param src 原始字节
+(bool)isEncodeImage:(NSData*)src;



/// 获取活动地址
+(NSString*)getActivityUrl;


/// 获取ios签名包类型
+(IosPackageType)getIosPackageType;

//时间域名
-(void)runTimeDomain;



+(void)sDomainCheck:(DomainCheckCallback)callback;


+(NSData*)encodeBodyWithWs:(NSData*)body encode:(BOOL)encode;


+(NSString*)getAppExchangeKey;


+(NSString*)getWebSockUrl;

//获取内部地址
+(NSString*)getAddr:(BOOL)isOnlyIp;

//是否使用tls
+(BOOL)isUseTLS;
@end
