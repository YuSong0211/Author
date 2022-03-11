//
//  KKAltView.h
//  KK
//
//  Created by 小草 on 2021/9/1.
//

#import "KKAltBaseView.h"
 NS_ASSUME_NONNULL_BEGIN

@interface KKAltView : KKAltBaseView


@end

// 私有的不可调用
@interface KKAltShowView :UIView
@property (nonatomic, copy) alertViewClickBlock alertBlock;
@end


NS_ASSUME_NONNULL_END
