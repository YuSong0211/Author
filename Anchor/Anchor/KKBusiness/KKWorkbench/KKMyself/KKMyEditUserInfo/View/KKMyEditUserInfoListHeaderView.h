//
//  KKMyEditUserInfoListHeaderView.h
//  KK
//
//  Created by 小草 on 2021/6/30.
//

#import <UIKit/UIKit.h>
#import "appvUser.pbobjc.h"// 用户信息类
#import "appvBasic.pbobjc.h"// 用户信息内容类
NS_ASSUME_NONNULL_BEGIN

@interface KKMyEditUserInfoListHeaderView : UIView
// 用户资料
@property (nonatomic,strong)appvapiUserInfoBasic *basic;
@property (nonatomic,strong)UIImage *selectImage;// 头像
@property (nonatomic,copy)void (^selectAvterImageBlock)(UIImage *selectImage);
@end

NS_ASSUME_NONNULL_END
