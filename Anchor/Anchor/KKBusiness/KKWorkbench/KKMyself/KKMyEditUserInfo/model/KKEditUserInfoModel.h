//
//  KKEditUserInfoModel.h
//  KK
//
//  Created by 小鱼 on 2021/8/6.
//

#import <Foundation/Foundation.h>
#import "appvUser.pbobjc.h"// 业务层用户信息类
#import "appvBasic.pbobjc.h"// 业务层用户信息内容类
#import "appvPrimaryApiUser.pbobjc.h"// 业务层用户信息类
#import "HeadPools.h"
#import "UtilBasic.pbobjc.h"// 业务层用户信息类
#import "KKUploadInfoModel.h"   // 上传准备的信息
#import "KKUploadAuthenticationModel.h" // 鉴权model
typedef void(^HttpRequestCompletion)(BOOL completion);

NS_ASSUME_NONNULL_BEGIN

@interface KKEditUserInfoModel : NSObject

+ (void)changeUserInfo:(NSString *)nickname
                   gender:(appvapiGenders)gender
                    intro:(NSString *)intro
               completion:(HttpRequestCompletion)completionSucess;




/// 上传用户头像
/// @param userAvaterInfo 用户头像信息
/// @param completion 回调完成
+(void)uploadingUserAvaterToServiseModel:(KKUploadInfoModel *)userAvaterInfo completion:(void (^)(KKUploadAuthenticationModel * _Nonnull))completion;
@end

NS_ASSUME_NONNULL_END
