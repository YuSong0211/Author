//
//  KKTool.m
//  KK
//
//  Created by zhou on 2021/7/2.
//

#import "KKTool.h"
// 刷新控件
#import <MJRefresh/MJRefresh.h>
#import "RNOpenSSLDecryptor.h"
static NSString * const keyChainUUIDService = @"keyChainUUIDService";
static NSString * const keyChainAccount = @"keyChainAccount";

#define RESOURCE_PASS_WORD @"richers@.@123456"

@implementation KKTool

+ (UIViewController *)getCurrentVC {
    //获得当前活动窗口的根视图
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

+ (NSMutableArray *)participleWithString:(NSString *)originalString {
    
    CFLocaleRef locale; //分词工具
    CFRange range; //使用范围
    {
        if (!originalString.length) return nil;
        range = CFRangeMake(0, [originalString length]);
        locale = CFLocaleCopyCurrent(); //要CFRelease!
    }
    
    CFStringTokenizerRef tokenizer; // token解析 (要CFRelease!)
    tokenizer = CFStringTokenizerCreate(kCFAllocatorDefault, (CFStringRef)originalString, range, kCFStringTokenizerUnitWordBoundary, locale);   //初始化
    
    CFStringTokenizerTokenType tokenType; //token状态(监听分词进程)
    tokenType = CFStringTokenizerGoToTokenAtIndex(tokenizer, 0);
    NSMutableArray *participleArray = [NSMutableArray array];
    
    while (tokenType != kCFStringTokenizerTokenNone) {
        
        //获取当前使用范围
        range = CFStringTokenizerGetCurrentTokenRange(tokenizer);
        
        CFTypeRef tokenTag; //token标记 (要CFRelease!)
        //将标记存储
        tokenTag = CFStringTokenizerCopyCurrentTokenAttribute(tokenizer, kCFStringTokenizerAttributeLatinTranscription);
        
        [participleArray addObject:[originalString substringWithRange:NSMakeRange(range.location, range.length)]];
        
        CFRelease(tokenTag);
        
        //获取当前进程
        tokenType = CFStringTokenizerAdvanceToNextToken(tokenizer);
    }
    
    //释放
    CFRelease(locale);
    CFRelease(tokenizer);
    
    return participleArray;
}

+ (void)showSystemAlertWithTitle:(NSString *)title message:(nullable NSString *)message isShowCancel:(BOOL)isShowCancel completion:(nullable void (^)(void))completion cancel:(nullable void (^)(void))cancel {
    [self showSystemAlertWithTitle:title message:message leftText:@"取消" rightText:@"确定" isShowCancel:isShowCancel leftAction:cancel rightAction:completion];
}

+ (void)showSystemAlertWithTitle:(nullable  NSString *)title message:(nullable NSString *)message leftText:(nullable NSString *)leftText rightText:(nullable  NSString *)rightText isShowCancel:(BOOL)isShowCancel leftAction:(nullable void (^)(void))leftAction rightAction:(nullable void (^)(void))rightAction {
    KKAltStyleConfig* config = [[KKAltStyleConfig initWithTitleAndContent:title content:message] setViewEnable:NO];
    config.backGroundRGBColor = KKRGBA(0, 0, 0, 0.5);
    if (isShowCancel) {
        KKAltItemConfig* cancelItem = [KKAltItemConfig initWithItemConfig:leftText buttonEnable:YES];
        [config.itemConfigArray addObject:cancelItem];
    }
    KKAltItemConfig* confirmItem = [KKAltItemConfig initWithItemConfig:rightText buttonEnable:YES];
    [config.itemConfigArray addObject:confirmItem];
    [KKAltView showAltViewWithConfigModel:config WithClickBlock:^(NSInteger clickIndex) {
        if (isShowCancel) {
            if (clickIndex == 0) {
                if (leftAction) {
                    leftAction();
                }
            }else {
                if (rightAction) {
                    rightAction();
                }
            }
        }else {
            if (rightAction) {
                rightAction();
            }
        }
    }];
}

+ (NSArray *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}
/**
 *  本应用是第一次安装
 *
 *  @return 是否是第一次安装
 */
+(BOOL)isFirstInstall{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        return YES;
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        return NO;
    }
}
+ (BOOL)isPhoneNum:(NSString *)phone
{
    NSString *MOBILE = @"^1(3[0-9]|4[579]|5[0-35-9]|6[6]|7[0-35-9]|8[0-9]|9[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:phone];
}


//获取UUID，将获取的UUID保存到钥匙串里，保证了UUID的唯一不变性
+ (NSString *)getUUIDByKeyChain {
    
    //return @"dfasdfahruhreiuhasdlfaskdfjld";
//   NSString *keyChainUUID;
//   YYKeychainItem *keychainItem = [[YYKeychainItem alloc] init];
//   keychainItem.service = keyChainUUIDService;
//   keychainItem.account = keyChainAccount;
//
//   keychainItem = [YYKeychain selectOneItem:keychainItem];
//   keyChainUUID = keychainItem.password;
//   if (keyChainUUID.length) {
//       return keyChainUUID;
//   }else {
//       keyChainUUID = [NSUUID UUID].UUIDString;//系统方法获取UUID
//       if (kStringIsEmpty(keyChainUUID)) {
//           return @"";
//       }
//       YYKeychainItem *saveKeychainItem = [[YYKeychainItem alloc] init];
//       saveKeychainItem.service = keyChainUUIDService;
//       saveKeychainItem.account = keyChainAccount;
//       saveKeychainItem.password = keyChainUUID;
//       [YYKeychain insertItem:saveKeychainItem];
//       return keyChainUUID;
//   }
    
    return [KKUserInfo share].uuid ;
}

+ (NSString *)getDeviceUUID {
    
   NSString *keyChainUUID;
   YYKeychainItem *keychainItem = [[YYKeychainItem alloc] init];
   keychainItem.service = keyChainUUIDService;
   keychainItem.account = keyChainAccount;

   keychainItem = [YYKeychain selectOneItem:keychainItem];
   keyChainUUID = keychainItem.password;
   if (keyChainUUID.length) {
       return keyChainUUID;
   }else {
       keyChainUUID = [NSUUID UUID].UUIDString;//系统方法获取UUID
       if (kStringIsEmpty(keyChainUUID)) {
           return @"";
       }
       YYKeychainItem *saveKeychainItem = [[YYKeychainItem alloc] init];
       saveKeychainItem.service = keyChainUUIDService;
       saveKeychainItem.account = keyChainAccount;
       saveKeychainItem.password = keyChainUUID;
       [YYKeychain insertItem:saveKeychainItem];
       return keyChainUUID;
   }
}

+(void)clearUDID{
    //清除设备uuid
    YYKeychainItem *keychainItem = [[YYKeychainItem alloc] init];
    keychainItem.service = keyChainUUIDService;
    keychainItem.account = keyChainAccount;
    BOOL ISSUCess = [YYKeychain deleteItem:keychainItem];
    if (!ISSUCess) {
        [self clearUDID];
    }
    //清除后台给的uuid
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"mxkj_uuid"];
    [[KKUserInfo share] clearUserInfo];
    [KKJurisdictionManager clearInfo];
    [kUserDefaults removeObjectForKey:[KKUserInfo share].uid];
    [richers refreshToken:XTokenType_UC token:@""];
    [richers refreshToken:XTokenType_API token:@""];
    [richers refreshToken:XTokenType_IM token:@""];
}
+ (SGPageTitleViewConfigure *)getPageTitleViewConfigureisCenter:(BOOL)isCenter {
    SGPageTitleViewConfigure *config = [[SGPageTitleViewConfigure alloc] init];
    config.isStaticStyle = isCenter;
    config.bottomSeparatorColor = [UIColor clearColor];
    config.titleSelectedColor = [KKColor getColor:colorVideoTabSelectedText];
    config.titleFont = [UIFont mediumWithSize:16];
    config.titleColor = [KKColor getColor:colorVideoTabUnSelectedText];
    config.titleSelectedFont = [UIFont mediumWithSize:16];
    config.indicatorColor = [KKColor getColor:colorPrimary];
    config.indicatorToBottomDistance = 5;
    config.indicatorStyle = SGIndicatorStyleDynamic;
    config.indicatorDynamicWidth = 20;
    config.indicatorCornerRadius = 3;
    config.indicatorHeight = 3;
    return config;
}

+ (NSString *)formatNumber:(NSInteger)number {
    if (number > 9999 && number < 99999999) { //万
        double value = (double)number / 1000;
        double newValue = floor(value);
        double finallValue = newValue / 10;
        return [NSString stringWithFormat:@"%.1fw",finallValue];
    }else if (number > 99999999) { //亿
        double value = (double)number / 10000000;
        double newValue = floor(value);
        double finallValue = newValue / 10;
        return [NSString stringWithFormat:@"%.1fy",finallValue];
    }
    return [NSString stringWithFormat:@"%ld",(long)number];
}

// 去除小数点后  无用的0
+ (NSString *)changeFloatWithFloat:(CGFloat)floatValue
{
    
    NSString * stringFloat =  [NSString stringWithFormat:@"%f",floatValue];
    
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    NSInteger i = length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0') {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}

+ (NSString *)formatTime:(NSInteger)time {
    if (!time || time == 0) {
        return @"";
    }
    NSInteger temp = time / 1000;
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:temp];
    return [date formatTime:temp];
}
// 处理用户昵称
+ (NSString *)dealNikeName:(NSString *)nikeName {
    if ([nikeName containsString:@"_"]) {
        NSString *string=[nikeName stringByReplacingOccurrencesOfString:@"_"withString:@"用户"];
        return string;
    }else {
        return nikeName;
    }
}

// 生成并获取二维码数据
+ (CIImage *)creatQRcodeWithUrlstring:(NSString *)urlString{
    
    // 1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    // 3.将字符串转换成NSdata
    NSData *data  = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    // 5.生成二维码
    CIImage *outputImage = [filter outputImage];
    return outputImage;
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(NSString *)urlString withSize:(CGFloat)size
{
    CIImage *image = [self creatQRcodeWithUrlstring:urlString];
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

///JSON字符串转化为字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


///字典转json字符串方法
+ (NSString *)convertToJsonData:(NSDictionary *)dict

{

    NSError *error;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];

    NSString *jsonString;

    if (!jsonData) {

        NSLog(@"%@",error);

    }else{

        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];

    NSRange range = {0,jsonString.length};

    //去掉字符串中的空格

    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];

    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符

    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

    return mutStr;

}


+ (BOOL)isPastDueByComparisonTimestamp:(long)timestamp {
    long now = [AppTimeSysMgr getNowTimeStamp];
    if (now > timestamp) {
        return YES;
    }else {
        return NO;
    }
}

+(NSData*)returnDataWith:(NSDictionary*)dict
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    
    return data;
}

+(NSDictionary*)returnDictionaryWithDataPath:(NSData*)data
{
    NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSData * datas = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingMutableLeaves error:nil];
    
    return jsonDict;
}

+ (NSData*)convert:(NSData*)data type:(Byte)type {
    NSMutableData *newData = [[NSMutableData alloc] init];
    [newData appendBytes:&type length:sizeof(type)];
    [newData appendData:data];
    return  newData;
}

+ (NSData *)removeFirstByte:(NSData *)data {
    if (data.length == 0) {
        return nil;
    }
    NSMutableData *mutableData = [data mutableCopy];
    NSRange range = NSMakeRange(0, 1);
    [mutableData replaceBytesInRange:range withBytes:NULL length:0];
    return mutableData;
}

+ (Byte)getFirstByte:(NSData *)data {
    if (data.length == 0) {
        return nil;
    }
    Byte* role =  (Byte*)([data bytes]);
    UInt8 *bytes =malloc(sizeof(*bytes)* data.length);
    return role[0];
}

/// 获取分享链接
+ (NSString *)getShareUrl{
    NSString * copyLinkString;
    if ([KKUserInfo share].grayscale == YES) {
        copyLinkString = [NSString stringWithFormat:@"%@?s=%@&alpha=true",[richers getCanUseUrl:Ocdomain_download],[KKUserInfo share].signCode];
    }else{
        copyLinkString = [NSString stringWithFormat:@"%@?s=%@",[richers getCanUseUrl:Ocdomain_download],[KKUserInfo share].signCode];
    }
    return copyLinkString;
}

+ (void)getGYCommentTextViewStyle:(GYCommentTextView *)view {
    view.doneBtnBgColor = [KKColor getColor:colorTextBtn];
    view.mainBgColor = [KKColor getColor:appBgColor];
    view.textViewBgColor = [KKColor getColor:appEditTextBgColor];
    view.textViewTextColor = [KKColor getColor:appMainTextColor];
}



+ (void)getKKChatSendViewStyle:(KKChatSendView *)view {
    view.doneBtnBgColor = [KKColor getColor:colorTextBtn];
}

+ (void)getVideoGYCommentTextViewStyle:(GYCommentTextView *)view {
    view.doneBtnBgColor = [KKColor getColor:colorTextBtn];
    view.mainBgColor = KKRGBA(37, 39, 47, 1);
    view.textViewBgColor = KKRGBA(56, 58, 68, 1);
    view.textViewTextColor = [UIColor whiteColor];
}

+ (BOOL)isDarkMode {
    return [self isDarkModeWith:[KKColor getColor:appBgColor]];
}

+ (BOOL)isDarkModeWith:(UIColor *)color {
    if (color.red* 255 * 0.299 + color.green* 255 * 0.578 + color.blue* 255 *0.114 >= 192) { //浅色
        return NO;
    }else { //深色
        return YES;
    }
}

+ (UIStatusBarStyle)statusBarStyleWith:(UIColor *)color {
    return [self isDarkModeWith:color] ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}
+ (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width;
}

+ (NSString *)stringInterceptionConversion:(NSString *)temp {
    if ([temp rangeOfString:@"?"].location !=NSNotFound) { //有健全
        NSMutableArray *array = [temp componentsSeparatedByString:@"?"].mutableCopy;
        return [self httpsStringInterceptionConversion:array[0]];
    }else { //无健全
        return [self httpsStringInterceptionConversion:temp];
    }
}

+ (NSString *)httpsStringInterceptionConversion:(NSString *)item {
    if ([item rangeOfString:@"http"].location != NSNotFound && [item rangeOfString:@"//"].location != NSNotFound) {//这个判断证明是有域名，无论http还是https
        NSMutableArray *arr = [item componentsSeparatedByString:@"/"].mutableCopy;
        [arr removeObjectsInRange:NSMakeRange(0, 3)];
        return [arr componentsJoinedByString:@"/"];
    }else {
        return item;
    }
}

+(NSString *)getNowTimeTimestamp2{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    return timeString;
}
+(NSString *)getNowTimeTimestamp3{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone;
    if ([KKUserInfo share].timeZone) {
        timeZone = [NSTimeZone timeZoneWithName:[KKUserInfo share].timeZone];
    }
    else{
        timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    }
   

    [formatter setTimeZone:timeZone];

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];

    return timeSp;

}
+ (NSURLCredential *)myUrlCredential {
    NSData *PKCS12Data = [KKTool getHttpsP12];
    CFDataRef inPKCS12Data = (__bridge CFDataRef)PKCS12Data;
    SecIdentityRef identity = NULL;
    // extract the ideneity from the certificate
    if ([self extractIdentity:inPKCS12Data toIdentity:&identity] == 0) {
        SecCertificateRef certificate = NULL;
        SecIdentityCopyCertificate (identity, &certificate);
    }
    return [NSURLCredential credentialWithIdentity:identity certificates:nil persistence:NSURLCredentialPersistencePermanent];;
}


+ (OSStatus)extractIdentity:(CFDataRef)inP12Data toIdentity:(SecIdentityRef*)identity {
    OSStatus securityError = errSecSuccess;
    CFStringRef password = CFSTR("mcjiws");
    const void *keys[] = { kSecImportExportPassphrase };
    const void *values[] = { password };
    CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import(inP12Data, options, &items);
    if (securityError == 0)
    {
        CFDictionaryRef ident = CFArrayGetValueAtIndex(items,0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue(ident, kSecImportItemIdentity);
        *identity = (SecIdentityRef)tempIdentity;
    }
    if (options) {
        CFRelease(options);
    }
    return securityError;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
};


+(BOOL)stringIsNilWithString:(NSString *)str{
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str =  [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (str.length>0) {
        return YES;
    }
    return NO;
}
+(NSString*)RemoveHeadAndTailWSpacesithString:(NSString *)str{
//    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return str;
}



/// 字符串是否全部空格 YES 为全部空格，NO不是
/// @param str 字符串
+ (BOOL)isStringAllSpace:(NSString *)str{
    if (!str) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}
+ (NSString *)nowdeviceIPAdress {

    NSString *address = @"手机移动网络";

    struct ifaddrs *interfaces = NULL;

    struct ifaddrs *temp_addr = NULL;

    int success = 0;

    

    success = getifaddrs(&interfaces);

    if (success == 0) {

        temp_addr = interfaces;

        while (temp_addr != NULL) {

            if( (*temp_addr).ifa_addr->sa_family == AF_INET) {

                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {

                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];

                }

            }

            

            temp_addr = temp_addr->ifa_next;

        }

    }

    freeifaddrs(interfaces);

    return address;

}

+(NSString *)deviceIPAdress
{
    NSError *error;
    NSArray *urlArray = @[@"ifconfig.me/ip",@"icanhazip.com",@"api.ipify.org",@"ident.me",@"ipecho.net/plain"];
    NSURL *ipURL;
    for (int i = 0; i<urlArray.count; i++) {
        ipURL =  [NSURL URLWithString:[NSString stringWithFormat:@"https://%@",urlArray[i]]];
        NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
        if (ip) {
            return ip;
        }
    }
    return nil;
}

//解密资源文件
+(id)decodeResourceFileImageName:(NSString *)imageName
{
    if ([[UIScreen mainScreen] scale] ==1) {
        
    }else if ([[UIScreen mainScreen] scale] ==2){
        imageName = [NSString stringWithFormat:@"%@@2x",imageName];
    }else if ([[UIScreen mainScreen] scale] ==3){
        imageName = [NSString stringWithFormat:@"%@@3x",imageName];
    }
    NSString *filePath = KK_MAIN_BUNDLE_FILE_PATH(imageName);
    if (!filePath) {
        imageName = [imageName stringByReplacingOccurrencesOfString:@"3x" withString:@"2x"];
        filePath =KK_MAIN_BUNDLE_FILE_PATH(imageName);
        if (!filePath) {
            return nil;
        }
    }
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    NSData *dataDecrypted = [RNOpenSSLDecryptor decryptData:data withSettings:kRNCryptorAES256Settings password:RESOURCE_PASS_WORD error:&error];
    UIImage *image = [UIImage imageWithData:dataDecrypted];
    return image;
}

+(NSData *)getHttpsP12{
//    NSString *filePath = KK_MAIN_BUNDLE_FILE_PATH(@"client.p12");
//    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSData *data = [richers getHttpsP12];
    return data;
}
//获取httpscer
+(NSData*)getHttpsCer{
//    NSString *filePath = KK_MAIN_BUNDLE_FILE_PATH(@"client.cer");
//    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSData *data =[richers getHttpsCer];
    return data;
}
//获取会员地址
+(NSString*)getMemberVipUrl;{
    NSString *url = [richers getMemberVipUrl];
    return url;
}


//获取钱包地址
+(NSString*)getWalletUrl;{
    NSString *url = [richers getWalletUrl];
    return url;
}


//获取钱包余额
+(NSString*)getShowWalletUrl;{
    NSString *url = [richers getShowWalletUrl];
    url = [url stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    url = [url stringByReplacingOccurrencesOfString:@"9000" withString:@"4100"];
    return url;
}


//获取分享地址
+(NSString*)getShareAgentUrl;{
    NSString *url = [richers getShareAgentUrl];
    return url;
}


//获取im聊天地址
+(NSString*)getImUrl;{
    NSString *url = [richers getWebSockUrl];
    return url;
}
/// 获取活动地址
+(NSString*)getActivityUrl;{
    NSString *url = [richers getActivityUrl];
    return url;
}

+(void)popNoNetworkConnection:(CallBlack)block{

    NSString *showtext = @"网络连接不可用";
    [KKLoadingView hidden];
    KKAltItemConfig* item = [KKAltItemConfig initWithItemConfig:@"重试" buttonEnable:YES];
    KKAltStyleConfig* controller = [[KKAltStyleConfig initWithTitleAndContent:@"提示" content:showtext] setViewEnable:NO];
    [controller.itemConfigArray  addObject:item];
    [KKAltView dismiss];
    [KKAltView showAltViewWithConfigModel:controller WithClickBlock:^(NSInteger clickIndex) {
        block();
    }];
}


/// 根据接口获取后台返回的钱包余额
+(void)getWalleTotalAmount:(AmountBlock)block{
    serviceucWalletApiamountsAmountsRequest * req = [serviceucWalletApiamountsAmountsRequest createRequest];
    [[NetWorkMgr createMgrWithMessage:req] sendRequest:^(serviceucAmountsResponse *  _Nonnull message) {
        
        if (message.amount.totalWalletAmount == 0) {
            block(0.00);
        }else{
            NSInteger amount = message.amount.totalWalletAmount;
            NSLog(@"%f",amount/100.0);
            block(amount/100.0);
        }
    } failed:^(requestErrorCode errorCode) {
    }];
}

/*
 时长转换
 **/
+(NSString *)SecondFormatFonversion:(NSInteger)time{
    NSString *timeStr;
    if (time>60) {
        NSInteger minute = time/60;
        NSInteger second  = time%60;
        if (minute >=10) {
            timeStr = [NSString stringWithFormat:@"%ld",(long)minute];
        }
        else{
            timeStr = [NSString stringWithFormat:@"0%ld",(long)minute];
        }
        if (second >=10) {
            timeStr = [timeStr stringByAppendingFormat:@":%ld",(long)second];
        }
        else{
            timeStr = [timeStr stringByAppendingFormat:@":0%ld",(long)second];
        }
    }
    else{
        if (time >=10) {
            timeStr = [NSString stringWithFormat:@"00:%ld",(long)time];
        }
        else{
            timeStr = [NSString stringWithFormat:@"00:0%ld",(long)time];
        }
    }
    return timeStr;
    
}

+ (void)translationAnimationWithView:(UIView *)view completion:(void(^)(void))completion {
    CGRect frame = view.frame;
    frame.origin.x = KK_SCREEN_WIDTH;
    view.frame = frame;
    view.hidden = NO;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect frame = view.frame;
        frame.origin.x = 50;
        view.frame = frame;
    } completion:^(BOOL finished) {

        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            CGRect frame = view.frame;
            frame.origin.x = 5;
            view.frame = frame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
                CGRect frame = view.frame;
                frame.origin.x = -KK_SCREEN_WIDTH;
                view.frame = frame;
            } completion:^(BOOL finished) {
                view.hidden = YES;
                if (completion) {
                    completion();
                }
            }];
        }];
    }];
}

@end
