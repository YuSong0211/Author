//
//  KKUtilityTool.h
//  KK
//
//  Created by ProgramMa on 2021/9/3.
//

#import <Foundation/Foundation.h>

/** vip类型定义 */
typedef GPB_ENUM(VipProductType) {
  /** 没有会员 */
  VipProductType_VipProductTypeUnspecified = 0,

  /** 1级会员 */
  VipProductType_VipProductType1 = 1,

  /** 2级会员 */
  VipProductType_VipProductType2 = 2,
};

NS_ASSUME_NONNULL_BEGIN

@interface KKUtilityTool : NSObject
/*个人中心调用**/
///VipType 会员等级
///time 会员过期时间
+(UIImage *)memberImageWithVipType:(NSInteger)VipType withDateTime:(long)time;
/*关注/粉丝调用**/
///VipType 会员等级
///time 会员过期时间
+(UIImage *)memberListImageWithVipType:(NSInteger)VipType withDateTime:(long)time WithCreationLevel:(NSInteger)creationLevel;
//获取当前控制器
+ (UIViewController *)getCurrentVC;

#pragma mark -- 判断手机型号
+(NSString*)deviceModelName;
//系统名称
+(NSString *)getMobilephoneSystem;
//手机系统版本ios14.3
+(NSString*)getPhoneVersion;
//手机型号iphone
+(NSString *)getPhoneModel;
//社区会员(暂用)
+(UIImage *)memberCommunityListImageWithVipType:(NSInteger)VipType  WithCreationLevel:(NSInteger)creationLevel;


@end

NS_ASSUME_NONNULL_END
