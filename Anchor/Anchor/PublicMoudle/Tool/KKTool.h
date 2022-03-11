//
//  KKTool.h
//  KK
//
//  Created by zhou on 2021/7/2.
//

#import <Foundation/Foundation.h>
#import "SGPagingView.h"

#import "Anchor-Swift.h" 


#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
 
#define IOS_CELLULAR    @"pdp_ip0"
//有些分配的地址为en0 有些分配的en1
#define IOS_WIFI2       @"en2"
#define IOS_WIFI1       @"en1"
#define IOS_WIFI        @"en0"
//#define IOS_VPN       @"utun0"  vpn很少用到可以注释
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

NS_ASSUME_NONNULL_BEGIN
typedef void(^CallBlack)(void);

typedef void(^AmountBlock)(CGFloat  totalAmount);

@interface KKTool : NSObject

///获取当前控制器
+ (UIViewController *)getCurrentVC;

///分词
+ (NSMutableArray *)participleWithString:(NSString *)originalString;

///系统自带警告框
+ (void)showSystemAlertWithTitle:(NSString *)title message:(nullable NSString *)message isShowCancel:(BOOL)isShowCancel completion:(nullable void (^)(void))completion cancel:(nullable void (^)(void))cancel;


+ (void)showSystemAlertWithTitle:(nullable  NSString *)title message:(nullable NSString *)message leftText:(nullable NSString *)leftText rightText:(nullable  NSString *)rightText isShowCancel:(BOOL)isShowCancel leftAction:(nullable void (^)(void))leftAction rightAction:(nullable void (^)(void))rightAction;

///从本地读取json
+ (NSArray *)readLocalFileWithName:(NSString *)name;

///分段控制配置
+ (SGPageTitleViewConfigure *)getPageTitleViewConfigureisCenter:(BOOL)isCenter;

/// 是否是第一次安装app
+(BOOL)isFirstInstall;

/// 手机号是否正确(正则表达式)(13 14 15 17 18)
+ (BOOL)isPhoneNum:(NSString *)phone;

///格式化数字 （万w 亿y）
+ (NSString *)formatNumber:(NSInteger)number;

// 去除小数点后  无用的0
+ (NSString *)changeFloatWithFloat:(CGFloat)floatValue;

//获取UUID，将获取的UUID保存到钥匙串里，保证了UUID的唯一不变性
+ (NSString *)getUUIDByKeyChain;

//格式化时间
+ (NSString *)formatTime:(NSInteger)time;
// 处理用户昵称
+ (NSString *)dealNikeName:(NSString *)nikeName;

///网址转二维码
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(NSString *)urlString withSize:(CGFloat)size;

///JSON字符串转化为字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

///字典转json字符串方法
+ (NSString *)convertToJsonData:(NSDictionary *)dict;


///跳转到客服
+ (void)intoServerChat;

///通过时间戳比较是否过期
+ (BOOL)isPastDueByComparisonTimestamp:(long)timestamp;
///视频byte去反处理
+(NSData*)encode:(NSData*)src;

///转换data
+ (NSData*)convert:(NSData*)data type:(Byte)type;

///删除第一个字节
+ (NSData *)removeFirstByte:(NSData *)data;

///获取第一个字节
+ (Byte)getFirstByte:(NSData *)data;

/// 获取分享链接
+ (NSString *)getShareUrl;

+(void)clearUDID;

+ (void)getVideoGYCommentTextViewStyle:(GYCommentTextView *)view;

+ (void)getGYCommentTextViewStyle:(GYCommentTextView *)view;

+ (void)getKKChatSendViewStyle:(KKChatSendView *)view;
///是否是深色模式（黑色调主题）
+ (BOOL)isDarkMode;
///通过颜色判断是否是深色模式  YES 深色 NO浅色
+ (BOOL)isDarkModeWith:(UIColor *)color;
///通过颜色获取状态栏颜色模式
+ (UIStatusBarStyle)statusBarStyleWith:(UIColor *)color;
+ (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font;


///字符串截取转换
+ (NSString *)stringInterceptionConversion:(NSString *)temp;
+(NSString *)getNowTimeTimestamp2;
+(NSString *)getNowTimeTimestamp3;
+ (NSURLCredential *)myUrlCredential;
+ (OSStatus)extractIdentity:(CFDataRef)inP12Data toIdentity:(SecIdentityRef*)identity;


+ (UIImage *)imageWithColor:(UIColor *)color;

+(BOOL)stringIsNilWithString:(NSString *)str;
+(NSString*)RemoveHeadAndTailWSpacesithString:(NSString *)str;

/// 字符串是否全部空格 YES 为全部空格，NO不是
/// @param str 字符串
+ (BOOL)isStringAllSpace:(NSString *)str;

+ (NSString *)deviceIPAdress;

+ (NSString *)getDeviceUUID;

//解密资源文件
+(id)decodeResourceFileImageName:(NSString *)imageName;

+(NSData *)getHttpsP12;

//获取httpscer
+(NSData*)getHttpsCer;

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

/// 获取活动地址
+(NSString*)getActivityUrl;

+(void)popNoNetworkConnection:(CallBlack)block;

/// 根据接口获取后台返回的钱包余额
+(void)getWalleTotalAmount:(AmountBlock)block;

/*
 时长转换
 **/
+(NSString *)SecondFormatFonversion:(NSInteger)time;

///view从右向左平移
+ (void)translationAnimationWithView:(UIView *)view completion:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
