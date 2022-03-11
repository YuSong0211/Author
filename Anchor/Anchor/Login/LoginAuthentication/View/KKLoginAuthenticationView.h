//
//  KKLoginAuthenticationView.h
//  KK
//
//  Created by 小草 on 2021/7/5.
//

#import <UIKit/UIKit.h>
#import "KKLoginAuthenticationDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKLoginAuthenticationView : UIView

@property (nonatomic,weak) id<KKLoginAuthenticationDelegate>delegate;

-(void)show;

-(void)hidden:(BOOL)isAnimate;

@end

NS_ASSUME_NONNULL_END
