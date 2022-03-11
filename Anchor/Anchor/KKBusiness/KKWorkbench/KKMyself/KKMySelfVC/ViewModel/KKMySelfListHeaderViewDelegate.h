//
//  KKMySelfListHeaderViewDelegate.h
//  KK
//
//  Created by 小草 on 2021/7/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, KKMySelfClickType) {
    KKMySelfClickLikeType,  // 点赞
    KKMySelfClickAttentionType, // 关注
    KKMySelfClickFansType, // 粉丝
};


@protocol KKMySelfListHeaderViewDelegate <NSObject>


/// 点击编辑用户信息
-(void)clickEditUserInfo;


/// 点击用户信息中的模块
/// @param clickType 点赞 关注 粉丝
-(void)clickBehaviorWithType:(KKMySelfClickType)clickType;


@end

NS_ASSUME_NONNULL_END
