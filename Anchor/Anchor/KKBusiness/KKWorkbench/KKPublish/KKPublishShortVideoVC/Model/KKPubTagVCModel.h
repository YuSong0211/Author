//
//  KKPubTagVCModel.h
//  KK
//
//  Created by ProgramMa on 2021/7/13.
//

#import <Foundation/Foundation.h>
//#import "appvPrimaryApiBoot.pbobjc.h"
//#import "RACSubject.h"
#import "KKUserInfo.h"

typedef void(^isRequestFail)(BOOL isfail);

typedef void(^reloadMemberInfo)(void);
typedef void (^getAppConfiguration)(void);

typedef void(^getTimeBlcok)(uint64_t timestampMills,NSString *timezone);



@class KKAppConfiguration;
@interface KKAppConfiguration :NSObject

/** 配置的key */
@property(nonatomic, copy) NSString *configurationItemKey;

/** 配置项 Value */
@property(nonatomic, copy) NSString *configurationItemValue;

///
@property(nonatomic,assign)BOOL enableServiceAccess;
///评论权限
@property(nonatomic,assign)BOOL enableCommentAudit;
///视频观看权限
@property(nonatomic,assign)BOOL enableVideoAudit;
///社区权限
@property(nonatomic,assign)BOOL enableCommunityAudit;
///是否开启会员
@property(nonatomic,assign)BOOL enableVip;
/// 发布权限
@property(nonatomic,assign)BOOL enablePublishContent;
/// 直播权限
@property(nonatomic,assign)BOOL enableLive;

@property(nonatomic,assign)BOOL enableGrandStar;
//webView版本是否清缓存
@property(nonatomic,copy)NSString *hybirdversion;

@property(nonatomic,copy)getAppConfiguration appConfigurationClick;

@end

@class KKMemberBenefitsInfo;

@interface KKMemberVipListInfo : NSObject

/** 产品id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *id_p;
/** Test to see if @c id_p has been set. */
@property(nonatomic, readwrite) BOOL hasId_p;

/** vip类型，需要通过pb.enum.VipProductType与移动端进行约定 */
@property(nonatomic, readwrite) enum appvapiVipProductType type;

/** vip产品的价格 */
@property(nonatomic, readwrite) uint32_t price;

/** vip产品的折扣信息（如果没有则表示没有折扣） */
@property(nonatomic, readwrite, strong, null_resettable) appvapiVipSalePrice *salePriceInfo;
/** Test to see if @c salePriceInfo has been set. */
@property(nonatomic, readwrite) BOOL hasSalePriceInfo;

/** vip产品的有效期定义，需要通过pb.enum.VipProductValidTimeType与移动端进行约定 */
@property(nonatomic, readwrite) appvapiVipProductValidTimeType memberValidTimeType;

@end


@interface KKMemberBenefitsInfo : NSObject

/** 权益id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *id_p;
/** Test to see if @c id_p has been set. */
@property(nonatomic, readwrite) BOOL hasId_p;

/** 会员产品类型 */
@property(nonatomic, readwrite) enum appvapiVipProductType vipProductType;

/** 会员权益key */
@property(nonatomic, readwrite) enum appvapiVipRightInterestsKey vipRightInterestsKey;

/** 会员权益value */
@property(nonatomic, readwrite, copy, null_resettable) NSString *vipRightInterestsValue;

@end

NS_ASSUME_NONNULL_BEGIN
@class KKPubTagVCDataModel;
@interface KKPubTagVCDataModel : NSObject
@property (nonatomic, strong)NSString *  tagID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign)NSInteger isSelect;
@property (nonatomic, assign)NSInteger indexPathRow;
/** 标签背景url */
@property(nonatomic, copy) appvapiMIMEInfo *backgroundImgURL;
/** 是否有背景图 */
@property(nonatomic, readwrite) BOOL hasBackground;
/** 是否是主推标签 */
@property(nonatomic, readwrite) BOOL isMain;

//标签
//+(NSMutableArray<KKPubTagVCDataModel *> *)convertModelwithTagList:(voyageapiFindSystemTagResponse * _Nonnull)TagList;
@property(nonatomic,strong)appvapiContentTag *tagModel;

/** id */
@property(nonatomic, strong)NSString * id_p;

@end

@interface KKPubTagVCModel : NSObject
//@property (nonatomic, strong) NSArray <KKPubTagVCDataModel *> *data;
@property (nonatomic, copy) NSString *msg;
@property(nonatomic,strong)NSMutableArray <KKPubTagVCDataModel *> *tagArr;
@property(nonatomic,strong)NSMutableArray <KKPubTagVCDataModel *> *tagImageArr;
@property(nonatomic,strong)NSMutableArray <KKMemberBenefitsInfo *> *memberInfoArr;
@property (nonatomic,strong)NSMutableArray <KKPubTagVCDataModel *> *communityTagList;
@property(nonatomic,strong)NSString *shareUrl;
@property(nonatomic,copy)isRequestFail failBlock;
///评论次数
@property(nonatomic,assign)NSInteger commemtCount;
///下载次数
@property(nonatomic,assign)NSInteger downCount;
///观看次数
@property(nonatomic,assign)NSInteger videoCount;

@property(nonatomic,copy)reloadMemberInfo reloadBlock;
///vip数组
@property(nonatomic,strong)NSMutableArray *vipsArray;
///系统配置
@property(nonatomic,strong)NSMutableArray *AppConfigurationArr;

///
@property(nonatomic,assign)BOOL enableServiceAccess;
///评论权限
@property(nonatomic,assign)BOOL enableCommentAudit;
///视频观看权限
@property(nonatomic,assign)BOOL enableVideoAudit;
///社区权限
@property(nonatomic,assign)BOOL enableCommunityAudit;
///是否开启会员
@property(nonatomic,assign)BOOL enableVip;
///标签是否有图
@property(nonatomic,copy)NSString *enableImageUrl;
/// 发布权限
@property(nonatomic,assign)BOOL enablePublishContent;
/// 直播权限
@property(nonatomic,assign)BOOL enableLive;

@property(nonatomic,assign)BOOL enableGrandStar;

//webView版本是否清缓存
@property(nonatomic,copy)NSString *hybirdversion;

@property (nonatomic,copy)NSString *ossProvider;

@property(nonatomic,copy)getTimeBlcok timeBlock;

@property(nonatomic,copy)NSString *tagID;//点击的标签

@property(nonatomic,strong)appvapiEnterResponse *enterResponse;

///短视频是否是刷新状态；
@property (nonatomic,assign)BOOL isNoRefreshStatus;
///社区是否是刷新状态；
@property (nonatomic,assign)BOOL isNoRefreshCommunityStatus;

/** 阿里云获取签名域名 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *ossUploadPath;

/** 阿里云上传endpoint */
@property(nonatomic, readwrite, copy, null_resettable) NSString *ossEndPoint;

@property (nonatomic,assign) NSInteger reRequestTime;

@property(nonatomic,copy)NSString *chatToken;

@property(nonatomic,copy)NSString *JwtToken;

@property(nonatomic,assign)BOOL isSelectCommunityVideo;

@property (nonatomic,strong)UITapGestureRecognizer *tap;
/** 是否是主播 */
@property(nonatomic, readwrite) BOOL isAnchor;
/** 不是主播的原因 */
@property(nonatomic, readwrite) appvapiExchangeIsNotAnchorReason exchangeIsNotAnchorReason;

+ (instancetype)shareToolGetManager;

-(void)requestTagList:(appvapiEnterResponse *)message;

-(void)requestTagListTWO:(RACSubject *)subjectResult;

-(void)getMemberReloadInfo:(reloadMemberInfo)infoBlock;

-(void)gettimeConfig:(getTimeBlcok)blcok;
///获取聊天链接socket chatToken
-(void)requestSocketTokenSystem;

@end

@class KKMemberInfoItemModel;
@interface KKMemberInfoItemModel : NSObject

/** 产品id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *id_p;
/** Test to see if @c id_p has been set. */
@property(nonatomic, readwrite) BOOL hasId_p;

/** vip类型，需要通过pb.enum.VipProductType与移动端进行约定 */
@property(nonatomic, readwrite) enum appvapiVipProductType type;

/** vip产品的价格 */
@property(nonatomic, readwrite) uint32_t price;

/** vip产品的折扣信息（如果没有则表示没有折扣） */
@property(nonatomic, readwrite, strong, null_resettable) appvapiVipSalePrice *salePriceInfo;
/** Test to see if @c salePriceInfo has been set. */
@property(nonatomic, readwrite) BOOL hasSalePriceInfo;

/** vip产品的有效期定义，需要通过pb.enum.VipProductValidTimeType与移动端进行约定 */
@property(nonatomic, readwrite) appvapiVipProductValidTimeType memberValidTimeType;

+(NSMutableArray< KKMemberInfoItemModel*> *)convertModelwithMemberVIPList:(NSMutableArray<appvapiVipProduct*> * _Nonnull)HostList;

@end

NS_ASSUME_NONNULL_END
