//
//  UserInfo.h
//  BinbinHelp
//
//  Created by Mr.K on 2018/5/14.
//  Copyright © 2018年 Beijing BinBinYouLi Network Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LoginViewController.h"
//#import "appvPrimaryApiSign.pbobjc.h"
//#import "AppvPrimaryApiEntry.pbobjc.h"
#import "AppvPrimaryApiPassport.pbobjc.h"
#import "AvModel.h"
#import "AppvUser.pbobjc.h"
typedef GPB_ENUM(appCreationType) {
 /** 普通用户 */
 KKOrdinaryUser = 0,
 /** 达人 */
 KKTypeSuper = 1,
 /** 明星 */
 KKnTypeStar = 2,
 /** 企业 */
 KKnTypeMedia = 3,
 /** 官方 */
 KKTypeOfficial = 999,
};

@interface KKUserInfo : NSObject
+ (KKUserInfo *)share;
- (BOOL)isChangeUserInfor;///是否修改过个人资料
- (BOOL)hasLogin;// 是否登陆过
- (BOOL)hasLogin:(UIViewController *)getCurrentVC;// 是否登陆过带自动跳转登录页
- (void)clearUserInfo;// 清除本地存储用户信息
-(BOOL)hasBindingTelephone;// 是否绑定过手机号
- (void)userDefaultsUserInfo:(appvapiEnterResponse *)resp;
///用户信息
@property (nonatomic,strong) appvapiUserInfoBasic *userInfo;
@property (nonatomic,copy)NSString *uuid; // 用户token
@property (nonatomic,copy)NSString *ucToken; // 用户token
@property (nonatomic,copy)NSString *apiToken;// 业务token
@property (nonatomic,copy)NSString *telephone; // 用户绑定后的手机号
@property (nonatomic,assign)NSInteger signSuccessType;// 登录方式
@property (nonatomic,copy)NSString *uid; // 用户uid
@property (nonatomic,copy)NSString *nickname; // 用户昵称
@property (nonatomic,assign)NSInteger gender; // 用户性别 0男1女
@property (nonatomic,copy)NSString *avatarURL; // 用户头像
@property (nonatomic,copy)NSString *city;// 用户所在地
@property (nonatomic,copy)NSString *vip;// 用户vip信息
@property (nonatomic,assign)CGFloat following;// 用户关注人数
@property (nonatomic,assign)CGFloat followers;// 粉丝数量
@property (nonatomic,assign)CGFloat likes;// 获得赞的数量
@property (nonatomic,copy)NSString *intro;//用户简介;
@property (nonatomic,copy)NSString *shareCode;// 分享码
@property (nonatomic,copy)NSString *signCode;// 分享码
@property (nonatomic,assign)NSInteger isReadShareCode;// 是否读取过分享码
@property (nonatomic, strong)NSString *extensionImageStr;///第一个推荐视频封面
@property (nonatomic,assign)BOOL isvip;
@property (nonatomic,copy) void (^changeUserInForBlock)(void); ///在我的页面实现block。只用当个人信息数据发生改变时 block调起
@property (nonatomic, strong) NSString *otherUid;
@property (nonatomic,assign) NSInteger member_level; ///会员等级
@property (nonatomic,strong) AvModel* avmodel; ///会员等级
@property (nonatomic, assign)NSInteger member_expiration_time;/// // 会员过期时间戳
@property (nonatomic,assign) NSInteger member_levelEffective; ///会员等级

@property (nonatomic, strong)NSString *deviceIPAdress;
@property (nonatomic, strong)NSString *netState;
/** 会员产品id */
@property(nonatomic, strong) appvapiIdEncode *vipProductId;
@property (nonatomic, strong)NSArray *payModelArray;
@property (nonatomic, strong)NSArray *appPayIDArray;
@property (nonatomic, strong)NSMutableDictionary *videoCacheDic;
@property (nonatomic, strong)NSMutableArray *videoCacheArr;
/** 创作级别 */
@property(nonatomic, assign) appCreationType creationLevel;
@property (nonatomic, assign)BOOL grayscale;
@property(nonatomic, assign)uint64_t timestampMills;
@property(nonatomic, assign)uint64_t starTimeMills;
@property (nonatomic, strong)NSString *timeZone;
/** 今日下载数 */
@property (nonatomic, assign)NSInteger  todayDownloadCount;
/** 3s 播放次数 */
@property(nonatomic, assign) NSInteger todayVideoPlay3SCount;

@property (nonatomic, strong)NSMutableDictionary *taskDict;

@property (nonatomic,strong)appvapiUserSuperActivity *userSuperActivity;
@property (nonatomic,strong)UIImage *userImage;
+(void)userInforChange;// 修改资料后调用
+ (void)saveKeywords:(NSDictionary *)dict;
+ (NSDictionary *)getKeyWordsFromPlist;
+(void)setVideoDownCount:(NSInteger)downCount;

-(void)requestWatchArrId;//刷新看过的视频id；

@end

