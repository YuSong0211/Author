//
//  KKCodeValidationView.h
//  KK
//
//  Created by ProgramMa on 2021/9/3.
//

#import <UIKit/UIKit.h>
#import "KKLoginAuthenticationDelegate.h"
typedef void (^CloseClick)(void);
NS_ASSUME_NONNULL_BEGIN

@interface KKCodeValidationView : UIView
@property(nonatomic,copy)CloseClick closeBlock;
@property (nonatomic,weak) id<KKLoginAuthenticationDelegate>delegate;
-(void)show;

-(void)hidden:(BOOL)isAnimate;

@end

NS_ASSUME_NONNULL_END
