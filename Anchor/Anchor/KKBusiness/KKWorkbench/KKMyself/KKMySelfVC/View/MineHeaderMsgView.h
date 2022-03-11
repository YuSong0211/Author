//
//  MineHeaderMsgView.h
//  KK
//
//  Created by 小草 on 2021/6/24.
//

#import <UIKit/UIKit.h>
#import "KKMySelfListHeaderViewDelegate.h"
#import "appvUser.pbobjc.h"// 用户信息类
#import "appvBasic.pbobjc.h"// 用户信息内容类
NS_ASSUME_NONNULL_BEGIN

@interface MineHeaderMsgView : UIView

@property (nonatomic,weak) id<KKMySelfListHeaderViewDelegate>delegate;
- (void)userInfo;
// 用户资料
@property (nonatomic,strong)appvapiUserInfoBasic *basic;
// 用户头像
@property (nonatomic,copy)NSString *avterUrl;
@end

NS_ASSUME_NONNULL_END
