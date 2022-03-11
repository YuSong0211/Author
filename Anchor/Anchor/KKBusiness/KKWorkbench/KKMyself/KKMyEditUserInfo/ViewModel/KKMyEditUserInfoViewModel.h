//
//  KKMyEditUserInfoViewModel.h
//  KK
//
//  Created by ProgramMa on 2021/8/5.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN

@interface KKMyEditUserInfoViewModel : NSObject
/**
 ////// 修改用户头像成功回调
 */
@property (nonatomic,strong) RACSubject *updateUserAvterSuccess;
/**
 ////// 修改用户信息
 @param nickname 昵称
 @param gender 用户性别
 @param intro 简介
 */
+ (void)apiUpdataUserInfo:( NSString * _Nullable )nickname
                   gender:(appvapiGenders )gender
                    intro:(NSString * _Nullable)intro;


@end

NS_ASSUME_NONNULL_END
