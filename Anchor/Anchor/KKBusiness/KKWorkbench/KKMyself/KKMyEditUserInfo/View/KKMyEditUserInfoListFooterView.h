//
//  KKMyEditUserInfoListFooterView.h
//  KK
//
//  Created by 小草 on 2021/6/30.
//

#import <UIKit/UIKit.h>
#import "appvUser.pbobjc.h"// 用户信息类
#import "appvBasic.pbobjc.h"// 用户信息内容类
NS_ASSUME_NONNULL_BEGIN

@interface KKMyEditUserInfoListFooterView : UIView
@property (nonatomic,strong) UITextView * textView;
// 用户资料
@property (nonatomic,strong)appvapiUserInfoBasic *basic;
@property (nonatomic,copy)void (^textViewTextDidChangeNotificationBlock)(NSString *content);
@property (nonatomic,copy)void (^textViewTextDidEndNotificationBlock)(NSString *content);
@end

NS_ASSUME_NONNULL_END
