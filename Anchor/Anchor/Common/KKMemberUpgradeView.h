//
//  KKMemberUpgradeView.h
//  KK
//
//  Created by ProgramMa on 2021/8/27.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, KKMemberUpdateType) {
    memberWatch = 0,//观影
    memberComment,//评论
    memberdownload,//下载
    memberChat,//私聊
    memberCustomerService,//专属客服
};
typedef NS_ENUM(NSUInteger,KKNowVCType) {
    KKFollowVideoVCType = 0,//关注
    KKRecomendVideoVCType,//推荐
    KKSecondVideoVCType,//二级
    KKChatVCType,//私聊
};
typedef void(^clickPromoteBlock)(void);
typedef void(^ClickBuyBlock)(void);
typedef void(^authResultBlock)(BOOL);
NS_ASSUME_NONNULL_BEGIN

@interface KKMemberUpgradeView : UIView
@property (nonatomic, copy)authResultBlock resultBlock;
@property(nonatomic,copy)clickPromoteBlock promoteTouchBlock;
@property(nonatomic,copy)ClickBuyBlock ClickBuyBlock;
@property (nonatomic,assign) KKMemberUpdateType Membertype;
@property (nonatomic,assign)KKNowVCType vcType;
+(void)disMissMTMemberUpdateViewWithShowView:(UIView*)showView;

+(KKMemberUpgradeView *)showMTMemberUpdateViewWithMemberUpdateType:(KKMemberUpdateType)memberType withShowView:(UIView*)showView WithPromoteblock:(clickPromoteBlock)block WithBuyBlock:(ClickBuyBlock)seBlock;

@end


NS_ASSUME_NONNULL_END
