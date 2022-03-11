//
//  SVProgressHUD+Extension.m
//  KK
//
//  Created by Gwynne on 2021/7/12.
//

#import "SVProgressHUD+Extension.h"

@implementation SVProgressHUD (Extension)

+ (void)showMessage:(NSString *)string {
    [self setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [self showImage:[UIImage imageNamed:@"KK&*9$3@!^&&8"] status:string];
    [self setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [self setDefaultStyle:SVProgressHUDStyleDark];
    [self dismissWithDelay:2];
}

@end
