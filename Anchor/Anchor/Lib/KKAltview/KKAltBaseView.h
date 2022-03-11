//
//  KKAltBaseView.h
//  KK
//
//  Created by 小草 on 2021/9/1.
//

#import <UIKit/UIKit.h>
#import "KKAltStyleConfig.h"
//#import "UIColor+YYAdd.h"
#import "KKAltBaseView.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^alertViewClickBlock)(NSInteger clickIndex);
@interface KKAltBaseView : UIView

/// 创建弹窗样式普通型
/// @param viewConfig 当前view的配置
+(void)showAltViewWithConfigModel:(KKAltStyleConfig *)viewConfig  WithClickBlock:(alertViewClickBlock)alertBlock;


/// 创建弹窗样式自定义型
/// @param viewConfig 当前view的配置
+(void)showAltCoustomViewWithConfigModel:(KKAltStyleConfig *)viewConfig  WithClickBlock:(alertViewClickBlock)alertBlock;

// 移除
+(void)dismiss;


/// 创建弹窗样式自动布局
/// @param viewConfig 当前view的配置
+(void)showAltLayoutViewWithConfigModel:(KKAltStyleConfig *)viewConfig  WithClickBlock:(alertViewClickBlock)alertBlock;

@end

NS_ASSUME_NONNULL_END

/* 类似UIalertview
 KKAltItemConfig* item = [KKAltItemConfig initWithItemConfig:@"立即更新" buttonEnable:YES];
 KKAltStyleConfig* controller = [[KKAltStyleConfig initWithTitleAndContent:@"提示" content:@"检测到新版本更新"] setViewEnable:NO];
 [controller.itemConfigArray  addObject:item];
 [KKAltView showAltViewWithConfigModel:controller WithClickBlock:^(NSInteger clickIndex) {
     NSLog(@"111");
 }];
 */



/*  自定义弹窗
 KKAltItemConfig* itemOne = [KKAltItemConfig initWithCoustomViewItemConfig:@"推广赚会员" buttonBackGroundColor:@"#C77000" buttonEnable:YES];
 KKAltItemConfig* itemTwo = [KKAltItemConfig initWithCoustomViewItemConfig:@"购买会员" buttonBackGroundColor:@"#00C421" buttonEnable:YES];
 
 KKAltStyleConfig* controller = [[KKAltStyleConfig initWithTitleAndContent:@"提示" content:@"检测到新版本更新"] setViewEnable:NO];
 [controller.itemConfigArray  addObject:itemOne];
 [controller.itemConfigArray  addObject:itemTwo];
 
 [KKAltCoustomView showAltCoustomViewWithConfigModel:controller WithClickBlock:^(NSInteger clickIndex) {
     NSLog(@"111----%ld",clickIndex);
 }];
 
 */
