//
//  UIBaseController.h
//  KK
//
//  Created by hk on 2021/6/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIBaseController : UIViewController
    
    -(void)initNavbar :(UIColor*)barcolor :(UIBarStyle)barstyle :(UIStatusBarStyle)statusbarstyle;
    
@end

NS_ASSUME_NONNULL_END
