//
//  UIImageView+Extension.h
//  KK
//
//  Created by Gwynne on 2021/7/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Extension)


/// 加载网络图片
/// @param string 网络图片字符串
/// @param animated 是否需要动画
- (void)setImageWithUrlString:(NSString *__nonnull)string animated:(BOOL)animated;


/// <#Description#>
/// @param string <#string description#>
/// @param placeholderImageName <#placeholderImageName description#>
/// @param animated <#animated description#>
- (void)setImageWithUrlString:(NSString *__nonnull)string
             placeholderImage:(nullable NSString *)placeholderImageName
                     animated:(BOOL)animated;

- (void)kk_setImageWithUrlString:(NSString *__nonnull)string placeholderImage:(nullable NSString *)placeholderImageName;

- (void)kk_setImageWithUrlString:(NSString *__nonnull)string placeholderImage:(nullable NSString *)placeholderImageName WithcompletedBlock:(void (^)(void))completedBlock;
@end

NS_ASSUME_NONNULL_END
