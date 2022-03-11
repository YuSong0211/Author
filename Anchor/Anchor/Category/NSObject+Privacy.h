//
//  NSObject+Privacy.h
//  AuthenticationMoudle
//
//  Created by 小草 on 2021/6/23.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    NetworkPrivacy,               // 网络
    CameraPrivacy,                // 相机
    PhotoLibraryPrivacy,          // 相册
    MicorphoneProvacy,            // 麦克风
    LocationPrivacy,              // 定位
    UserNotificationPrivacy       // 通知
} SystemPrivacy;

@interface NSObject (Privacy)

/// 检查是否开启权限，未开启权限弹出提醒窗，并捕获用户不允许操作
/// @param isAlert 是否出现弹窗
/// @param type SystemPrivacy
/// @param result YES 有权限 NO 无权限
/// @param cancel 取消回调
- (void)checkPrivacyEnableWithAlert:(BOOL)isAlert WithType:(SystemPrivacy)type withResult:(void (^)(BOOL result))result withCancel:(void (^)(void))cancel;

@end


