//
//  KKWebViewController.h
//  KK
//
//  Created by Gwynne on 2021/7/21.
//

#import <UIKit/UIKit.h>
#import "KKSecondBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKWebViewController : KKSecondBaseVC<UINavigationControllerDelegate>

- (instancetype)initWithUrl:(nonnull NSString *)urlString;
@property (nonatomic,copy)void(^didReceiveScriptMessageCallBack)(NSString *value);

@end

NS_ASSUME_NONNULL_END
