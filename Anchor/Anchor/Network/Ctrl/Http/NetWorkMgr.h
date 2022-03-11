//
//  NetWorkMgr.h
//  KK
//
//  Created by hk on 2021/8/3.
//

#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "BaseModel.h"
#import "HeadPools.h"
#import "DomainMgr.h"
#import "NetWrokStatesCtrl.h"
NS_ASSUME_NONNULL_BEGIN


/**
 /// 定义错误信息,400 以上未api 错误，其余为业务层错误
 */
typedef enum {
   MessageIsNull = 499,
   InternalServerError = 500, //服务器内部错误
   ServerDiscern = 501,    //服务器不能识别请求
   BadGateway = 502,       //服务器繁忙
   ServerAvailable = 503, //服务器不可用
   BadGatewaytimeout = 504, //服务器繁忙超时
   HttpNotSupport = 505,    //http协议不支持
   ServerError = 506,
   ReceiveError = 507,
   DomainIsEmpty = 508,
   ClientNetNoAvauable =600,
   APITokenFaild = 16,
   UCTokenTimeOut = 401, ///token过期
   APITokenTimeOut = 403,
   ForbiddenWords = 25018, ///禁言
   PhoneNumberHasbeenBinding = 96,///手机号已被绑定
    ///直播错误码
   BeutyLiveNOName=55000,///申请信息主播真实姓名不能为空
    BeutyLiveNOCard=55001,///申请信息主播证件号不能为空
    BeutyLiveCardLength=55002,///申请信息主播证件号长度不合法 *
    BeutyLiveCardInvalid=55003,///申请信息主播证件号无效
    BeutyLiveNOTitle=55004,///开播标题不能为空
    BeutyLiveSearchNOInfo=55005,///未查询到主播信息
    BeutyLiveTagInvalid=55006,///无效直播标签
    BeutyLiveNoTag=55007,///直播标签不能为空
    BeutyLiveNoLiveID=55008,///直播间id不能为空
    BeutyLiveLiveOver=55009,///直播已结束
    BeutyLiveLiveIDInvalid=55010,///无效直播id
    BeutyLiveSearchLiveInfo=55011,///未查询到直播间信息
    BeutyLiveGetLiveInfoError=55012,///获取主播信息失败
    BeutyLiveLiveTopNumber=55013,///直播间数量上限请联系工作人员
    BeutyLiveNoGiftId=55014,///礼物id不能为空
    BeutyLiveGiftInveInfo=55015,///无效礼物
    BeutyLiveGiftNumberInteger=55016,///礼物数量只能为正整数
    BeutyLiveEndliverepeatedly = 55017,///重复结束直播
    BeutyLiveRewardUserInvalid=55018,///打赏结算用户UID无效
    BeutyLiveNORewardUser=55019,///打赏结算用户未找到
    BeutyLiveNORewardTime=55020,///打赏批次未找到
    BeutyLiveLiveStatusError=55021,///直播间状态异常
    BeutyLiveProhibitRewardMyself=55022,///直播禁止打赏本人直播
    BeutyLiveNOLiveID=55023,///主播id不能为空
    BeutyLiveNOSearchUserInfo=55024,///未查询到用户信息
    BeutyLiveNOWatchID=55025,///观众id不能为空
    BeutyLiveNOSendInfo=55026,///发送消息不能为空
    BeutyLiveLiverAlreadyExists=55027,///当前用户已存在直播中的直播间
   Success = 0,
   
   
    
    
} requestErrorCode;

//错误信息回调
typedef void (^onRequestFail)(requestErrorCode errorCode);

//成功回调
typedef void (^onRequestSuccess)(id message);

@interface NetWorkMgr : NSObject

/**
 /// 创建空实例
 */
+(NetWorkMgr*)createMgr;

/**
 /// 创建信息 跟随数据
 @param message api需要发送的信息
 */
+(NetWorkMgr*)createMgrWithMessage:(id)message;


/**
 /// 创建信息 跟随数据
 @param message uc需要发送的信息
 */
+ (NetWorkMgr *)ucCreateMgrWithMessage:(id)message useToken:(BOOL)useToken;

+ (void)cancelRequestWithUrlStr:(NSString *)urlStr;
//是否使用token
@property (assign,nonatomic) BOOL useToken;

/**
 /// 创建信息 跟随数据
 @param message 需要发送的信息
 */
-(void)setMessage:(id)message;

/**
 /// 创建信息 跟随数据
 @param success 成功回调的信息
 @param fail 失败回调的信息
 */
-(void)sendRequest:(onRequestSuccess)success
            failed:(onRequestFail)fail;

/**
 /// 使用netcore 接口信息。只更换接口信息
 @param success 成功回调的信息
 @param fail 失败回调的信息
 */
-(void)sendRequestWithNetCore:(onRequestSuccess)success
                       failed:(onRequestFail)fail;

/**
 /// 创建信息 跟随数据
 */
-(void)sendRequest;

@end

NS_ASSUME_NONNULL_END
