//
//  KKWebViewEventModel.h
//  mt
//
//  Created by 小草 on 2021/10/19.
//

#import <Foundation/Foundation.h>
#import "KKWebViewManger.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKWebViewEventModel : NSObject

/// 初始化调用webview方法，传入用户信息
+(NSString *)callbackTwoWebviewConversionData:(BOOL)isDeveloper;

/// 支付结果回调js
/// @param resultType 支付结果。 成功，失败，取消
/// @return 支付结果
+(NSString *)payResultCallBackJs:(KKWebPayType)resultType;


/// 每次从后台回到前台，获取从上一页面返回，通知webview
+(NSString *)viewwillApperNofiJs;

@end

NS_ASSUME_NONNULL_END
