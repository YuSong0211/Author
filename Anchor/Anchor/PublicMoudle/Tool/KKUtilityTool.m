//
//  KKUtilityTool.m
//  KK
//
//  Created by ProgramMa on 2021/9/3.
//

#import "KKUtilityTool.h"
#import <sys/utsname.h>

@implementation KKUtilityTool


//获取当前控制器
+ (UIViewController *)getCurrentVC
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    UIViewController *currentViewController = window.rootViewController;
//    if (!window) {
//        return nil;
//    }
//    UIView *tempView;
//    for (UIView *subview in window.subviews) {
//        if ([[subview.classForCoder description] isEqualToString:@"UILayoutContainerView"]) {
//            tempView = subview;
//            break;
//        }
//    }
//    if (!tempView) {
//        tempView = [window.subviews lastObject];
//    }
//
//    id nextResponder = [tempView nextResponder];
//    while (![nextResponder isKindOfClass:[UIViewController class]] || [nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UITabBarController class]]) {
//        tempView =  [tempView.subviews firstObject];
//
//        if (!tempView) {
//            return nil;
//        }
//        nextResponder = [tempView nextResponder];
//    }
    
    BOOL runLoopFind = YES;
       while (runLoopFind) {
           if (currentViewController.presentedViewController) {
               currentViewController = currentViewController.presentedViewController;
           } else {
               if ([currentViewController isKindOfClass:[UINavigationController class]]) {
                   currentViewController = ((UINavigationController *)currentViewController).visibleViewController;
               } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
                   currentViewController = ((UITabBarController* )currentViewController).selectedViewController;
               } else if ([currentViewController isKindOfClass:[UISplitViewController class]]) { // 当需要兼容 Ipad 时
                   currentViewController = currentViewController.presentingViewController;
               } else {
                   if (currentViewController.presentingViewController) {
                       currentViewController = currentViewController.presentingViewController;
                   } else {
                       return currentViewController;
                   }
               }
           }
       }
    
    return currentViewController;
}


+(UIImage *)memberImageWithVipType:(NSInteger)VipType withDateTime:(long)time {
    if (VipType == VipProductType_VipProductTypeUnspecified) {
        return [UIImage imageNamed:@""];
    }else if (VipType == VipProductType_VipProductType1){
        if ([KKTool isPastDueByComparisonTimestamp:time]) {
            return [UIImage imageNamed:@""];
        }else{
            return  [UIImage imageNamed:@"KK_user_sign_vip"];
        }
    }else if (VipType == VipProductType_VipProductType2){
        if ([KKTool isPastDueByComparisonTimestamp:time]) {
            return [UIImage imageNamed:@""];
        }else{
            return [UIImage imageNamed:@"KK_user_sign_svip"];
        }
    }else{
        return [UIImage imageNamed:@""];
    }
    
}
+(UIImage *)memberListImageWithVipType:(NSInteger)VipType withDateTime:(long)time WithCreationLevel:(NSInteger)creationLevel{
    /** 非 普通用户 */
    if (creationLevel != KKOrdinaryUser) {
        return  [self memberListWithCreationLevel:creationLevel];
    }
    
    if (VipType == VipProductType_VipProductTypeUnspecified) {
        return [UIImage imageNamed:@""];
    }else if (VipType == VipProductType_VipProductType1){
        if ([KKTool isPastDueByComparisonTimestamp:time]) {
            return [UIImage imageNamed:@""];
        }else{
            return  [UIImage imageNamed:@"vip_1"];
        }
    }else if (VipType == VipProductType_VipProductType2){
        if ([KKTool isPastDueByComparisonTimestamp:time]) {
            return [UIImage imageNamed:@""];
        }else{
            return [UIImage imageNamed:@"vip_2"];
        }
    }else{
        return [UIImage imageNamed:@""];
    }
}

+(UIImage *)memberCommunityListImageWithVipType:(NSInteger)VipType  WithCreationLevel:(NSInteger)creationLevel{
    /** 非 普通用户 */
    if (creationLevel != KKOrdinaryUser) {
        return  [self memberListWithCreationLevel:creationLevel];
    }
    
    if (VipType == VipProductType_VipProductTypeUnspecified) {
        return [UIImage imageNamed:@""];
    }else if (VipType == VipProductType_VipProductType1){
        
        return  [UIImage imageNamed:@"vip_1"];
        
    }else if (VipType == VipProductType_VipProductType2){
        
        return [UIImage imageNamed:@"vip_2"];
        
    }else{
        return [UIImage imageNamed:@""];
    }
}


+(UIImage *)memberListWithCreationLevel:(NSInteger)creationLevel{
   
    /** 达人 */
    if(creationLevel == KKTypeSuper){
        return [UIImage imageNamed:@"super_type"];
    }
    /** 明星 */
    else if(creationLevel == KKnTypeStar){
        return [UIImage imageNamed:@"mingxing"];
    }
    /** 企业 */
    else if(creationLevel == KKnTypeMedia){
        return [UIImage imageNamed:@"qiye"];
    }
    /** 官方 */
    else if(creationLevel == KKTypeOfficial){
        return [UIImage imageNamed:@"guanfang"];
    }
    return [UIImage imageNamed:@"super_type"];
}

#pragma mark -- 判断手机型号
+(NSString*)deviceModelName{
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString * phoneType = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    // simulator 模拟器
    
//    if ([phoneType isEqualToString:@"i386"])   return @"Simulator";
//
//    if ([phoneType isEqualToString:@"x86_64"])  return @"Simulator";
//
//    //  常用机型  不需要的可自行删除
//
//    if([phoneType  isEqualToString:@"iPhone1,1"])  return @"iPhone 2G";
//
//    if([phoneType  isEqualToString:@"iPhone1,2"])  return @"iPhone 3G";
//
//    if([phoneType  isEqualToString:@"iPhone2,1"])  return @"iPhone 3GS";
//
//    if([phoneType  isEqualToString:@"iPhone3,1"])  return @"iPhone 4";
//
//    if([phoneType  isEqualToString:@"iPhone3,2"])  return @"iPhone 4";
//
//    if([phoneType  isEqualToString:@"iPhone3,3"])  return @"iPhone 4";
//
//    if([phoneType  isEqualToString:@"iPhone4,1"])  return @"iPhone 4S";
//
//    if([phoneType  isEqualToString:@"iPhone5,1"])  return @"iPhone 5";
//
//    if([phoneType  isEqualToString:@"iPhone5,2"])  return @"iPhone 5";
//
//    if([phoneType  isEqualToString:@"iPhone5,3"])  return @"iPhone 5c";
//
//    if([phoneType  isEqualToString:@"iPhone5,4"])  return @"iPhone 5c";
//
//    if([phoneType  isEqualToString:@"iPhone6,1"])  return @"iPhone 5s";
//
//    if([phoneType  isEqualToString:@"iPhone6,2"])  return @"iPhone 5s";
//
//    if([phoneType  isEqualToString:@"iPhone7,1"])  return @"iPhone 6 Plus";
//
//    if([phoneType  isEqualToString:@"iPhone7,2"])  return @"iPhone 6";
//
//    if([phoneType  isEqualToString:@"iPhone8,1"])  return @"iPhone 6s";
//
//    if([phoneType  isEqualToString:@"iPhone8,2"])  return @"iPhone 6s Plus";
//
//    if([phoneType  isEqualToString:@"iPhone8,4"])  return @"iPhone SE";
//
//    if([phoneType  isEqualToString:@"iPhone9,1"])  return @"iPhone 7";
//
//    if([phoneType  isEqualToString:@"iPhone9,2"])  return @"iPhone 7 Plus";
//
//    if([phoneType  isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
//
//    if([phoneType  isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
//
//    if([phoneType  isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
//
//    if([phoneType  isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
//
//    if([phoneType  isEqualToString:@"iPhone10,3"]) return @"iPhone X";
//
//    if([phoneType  isEqualToString:@"iPhone10,6"]) return @"iPhone X";
//
//    if([phoneType  isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
//
//    if([phoneType  isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
//
//    if([phoneType  isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
//
//    if([phoneType  isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
//
//    if([phoneType  isEqualToString:@"iPhone12,1"])  return @"iPhone 11";
//
//    if ([phoneType isEqualToString:@"iPhone12,3"])  return @"iPhone 11 Pro";
//
//    if ([phoneType isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";
//
//    if ([phoneType isEqualToString:@"iPhone12,8"])   return @"iPhone SE2";
//
//    if ([phoneType isEqualToString:@"iPhone13,1"])   return @"iPhone 12 mini";
//
//    if ([phoneType isEqualToString:@"iPhone13,2"])   return @"iPhone 12";
//
//    if ([phoneType isEqualToString:@"iPhone13,3"])   return @"iPhone 12  Pro";
//
//    if ([phoneType isEqualToString:@"iPhone13,4"])   return @"iPhone 12  Pro Max";
    
    
    return phoneType;
    
}
+(NSString *)getMobilephoneSystem{
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    return deviceName;
}

+(NSString*)getPhoneVersion{
    //手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    return phoneVersion;
}

+(NSString *)getPhoneModel{
    //手机型号
    NSString* phoneModel = [[UIDevice currentDevice] model];
    return phoneModel;
}

@end
