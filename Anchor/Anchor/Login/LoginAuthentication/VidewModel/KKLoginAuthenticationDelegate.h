//
//  KKLoginAuthenticationDelegate.h
//  KK
//
//  Created by 小草 on 2021/7/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KKLoginAuthenticationDelegate <NSObject>


/// 获取验证码前，人机验证，点击确定
/// @param ids 验证选择的图片是否正确 图片id
-(void)clickConfirmAuthenticationIds:(NSMutableArray *)ids;

@end

NS_ASSUME_NONNULL_END
