//
//  CoustomWebMenuView.h
//  mt
//
//  Created by 小草 on 2021/9/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CoustomWebMenuViewType) {
    CoustomWebMenuViewCancelType,  // 退出
    CoustomWebMenuViewBackType, // 返回
    CoustomWebMenuViewReloadType, // 刷新
    CoustomWebMenuViewSelfHiddenType, // 隐藏自己
    CoustomWebMenuViewPay // 充值
};

@protocol CoustomWebMenuViewDelegate <NSObject>


/// 点击按钮
/// @param buttonType 按钮类型
-(void)clickMeunButtonType:(CoustomWebMenuViewType)buttonType;

@end

@interface CoustomWebMenuView : UIView


@property (nonatomic,weak)id<CoustomWebMenuViewDelegate>delegate;

/// 显示功能按钮
/// @param buttonFrame 悬浮按钮的frame
-(void)showTheMenuViewWithButtonFrame:(CGRect)buttonFrame;


/// 消失功能按钮
-(void)dismissTheMenuView;

// 按钮类型 0.默认的返回  1.充值
-(void)changeButtonIcon:(NSInteger)buttonType;



@end

NS_ASSUME_NONNULL_END
