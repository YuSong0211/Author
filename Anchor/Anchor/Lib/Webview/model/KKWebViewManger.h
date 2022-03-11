//
//  KKWebViewManger.h
//  mt
//
//  Created by 小草 on 2021/10/19.
//

#import <Foundation/Foundation.h>

// 支付相关枚举
typedef NS_ENUM(NSUInteger, KKWebPayType) {
    KKWebPaySuccess, // 支付成功
    KKWebPayFail, // 支付失败
    KKWebPayCancel, // 支付取消
    KKWebPayOrderAuthFail, // 订单校验失败
    KKWebPayNoUseApplePay, // 不允许使用applePay
};


NS_ASSUME_NONNULL_BEGIN

// 支付相关内容
typedef void (^jsCallToPay)(NSString * productId); // js调用iOS去内购
typedef void (^applePayResultCallBack)(KKWebPayType resultType); // 内购结果通知js

@interface KKWebViewManger : NSObject

// 单例管理者
+(instancetype)sharManger;

@property (nonatomic,copy) jsCallToPay callPay; // 去支付

@property (nonatomic,copy) applePayResultCallBack payResult; // 支付结果

-(void)deallocBlock;

@end

NS_ASSUME_NONNULL_END
