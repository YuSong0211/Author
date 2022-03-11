//
//  KKLayoutViewAlertView.h
//  richers
//
//  Created by ProgramMa on 2021/11/20.
//

#import "KKAltBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKLayoutViewAlertView : KKAltBaseView

@end

// 私有的不可调用
@interface KKAltShowLayoutViewView :UIView
@property (nonatomic, copy) alertViewClickBlock alertBlock;
@end

NS_ASSUME_NONNULL_END
