//
//  KKNodateView.h
//  KK
//
//  Created by 小鱼 on 2021/8/3.
//
typedef NS_ENUM(NSUInteger, KKLoadFailState) {
    KKLoadseachNodata = 0,///搜索无数据
    KKLoadShortVideoNoData,//tabbar 短视频无数据
    KKLoadMYFollowNodata,///我的关注无数据
    KKLoadMYFensNodata,///我的粉丝无数据
    KKLoadMYLoveNodata,//我的点赞无数据
    KKLoadMYReleaseNodata,//我的发布无数据
    KKLoadMYCollectionNodata,//我的收藏无数据
    KKLoadOtherHomePageVideoNodata,//他人主页短视频无数据
    KKLoadPromotionRecordNodata,//推广记录无数据
    KKDownLoadNodata,//我的下载无数据
    KKCommentNodata,//评论无数据
    KKWorkOrderNodata,//工单无数据
    KKLoadFail,//接口错误
    KKCommunityNoData,//社区无数据
    KKCommunityNoLikeData,//社区无数据
    KKCommunityNoCollectionData,//社区无数据
    KKCommunityNoPublicData,//社区无数据
    KKCommunityNoInfoPublicData,//社区无数据
    KKLoadLiveNodata,//直播无数据
};
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^asginLoadBlock)(void);
@interface KKNodateView : UIView
@property (nonatomic, copy)  asginLoadBlock loadBlock;
@property (nonatomic, assign) KKLoadFailState loadFailState;
+(void)showMTLoadFailViewWithLoadState:(KKLoadFailState)loadFailState withShowView:(UIView*)showView withAssignLoadBlock:(nullable asginLoadBlock)asginLoadBlock;
+(void)disMissWithLoadFailViewWithShowView:(UIView*)showView;
+(KKNodateView *)showPlayerViewLoadFailViewWithLoadState:(KKLoadFailState)loadFailState withShowView:(UIView*)showView withAssignLoadBlock:(nullable asginLoadBlock)asginLoadBlock;
-(void)setTextColor:(BOOL)isfaile;
//个人中心使用
+(void)showMySelfLoadFailViewWithLoadState:(KKLoadFailState)loadFailState withShowView:(UIView*)showView withAssignLoadBlock:(nullable asginLoadBlock)asginLoadBlock;
@end

NS_ASSUME_NONNULL_END
