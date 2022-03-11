//
//  KKJurisdictionManager.h
//  KK
//
//  Created by 小鱼 on 2021/8/26.
//

#import <Foundation/Foundation.h>
#import "KKMemberUpgradeView.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^authResult) (BOOL isCan);;

@interface KKJurisdictionManager : NSObject
+ (KKJurisdictionManager *)shareManager;
@property (nonatomic, copy)authResult resultBlock;
@property (nonatomic, assign)NSInteger watchedCount;///已观看数量
@property (nonatomic, assign)NSInteger downloadedCount;///已下载数量
@property (nonatomic, strong)NSArray *DownArray;//已下载数组
@property (nonatomic, copy)NSMutableArray *seeArray;//已观看数组
@property (nonatomic, strong)NSMutableArray *viewArray;
+(void)clearInfo;
///支付完成 处理页面回掉功能
- (void)payResultBack;
/// 是否允许用户下载视频
/// @param showView  用于显示弹出支付页面
/// @param result  返回是否有此权 是否可以下载根据返回Bool值进行判断,yes 可执行 NO不可执行
+(void)isCanDownVideoWithView:(UIView*)showView  WithVIdeoID:(NSString *)videoID WithResult:(authResult)result;
/// 是否允许用户评论此视频
/// @param showView  用于显示弹出支付页面
/// @param result  返回是否有此权 是否可以下载根据返回Bool值进行判断,yes 可执行 NO不可执行
+(void)isCanCommentVideooWithView:(UIView*)showView WithResult:(authResult)result;
/// 是否允许用户观看此视频
/// @param showView  用于显示弹出支付页面
/// @param result  返回是否有此权 是否可以下载根据返回Bool值进行判断,yes 可执行 NO不可执行
+(void)isCanSeeVideooWithView:(UIView*)showView WithAVModel:(AvModel *)avmode WithResult:(authResult)result;

/// 是否允许用户私信某用户
/// @param showView  用于显示弹出支付页面
/// @param result  返回是否有此权 是否可以下载根据返回Bool值进行判断,yes 可执行 NO不可执行
+(void)isCanChatWithView:(UIView*)showView WithResult:(authResult)result;
/// [[EventCtrl getInstance] sendEvent:service_handler :[KKServiceModel initWithModelData:Service_downloadShortVideo videoId:self.model.videoID]];  上报时间

////获取用户相应权限还可下载视频剩余数量
+(NSInteger)downCount;
////获取用户相应权限可下载视频总数量
+(NSInteger)downTotalCount;
////获取用户相应权限已下载视频总数量
+(NSInteger)downEndCount;
////获取用户相应权限剩余可观看视频数量
+(NSInteger)seeCount;
////获取用户相应已观看视频数量
+(NSInteger)seeEndCount;
////获取用户相应权限可观看视频总数量
+(NSInteger)seeTotalCount;

//增加观看次数
+(void)addSeeCountWithAVid:(NSString *)vId;

+(void)disMisiMeViewWithMeType:(KKMemberUpdateType)type;
+(void)handeBuyEndblock;
+(void)disMisiAllMeViewWithSupeView:(UIView*)view;
///购买会员后处理回掉
+(void)handelBuyBlockWithBuytype:(NSInteger)buyType;
//是否可观看此视频
+(BOOL)isCanSeeWithAvid:(NSString *)avID;
@end

NS_ASSUME_NONNULL_END
