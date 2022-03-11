//
//  KKMySelfModel.h
//  KK
//
//  Created by 小鱼 on 2021/6/24.
//

#import "BaseModel.h"
//#import "appvapiUserApigetBaseInfoEmptyRequest.h"
NS_ASSUME_NONNULL_BEGIN

@interface KKMySelfModel : BaseModel
/** 用户信息 */
//@property(nonatomic, copy) NSString *uid;

/** 用户昵称 */
@property(nonatomic, copy) NSString *nickname;

/** 用户头像 */
@property(nonatomic, copy) NSString *avatarURL;

/** 性别 */
//@property(nonatomic, assign)NSInteger gender;

/** 目前是服务器获取 ip 直接展示的，所以直接返回客户端 具体的城市 */
@property(nonatomic, copy) NSString *city;

/** vip 信息 */
@property(nonatomic, copy) NSString *vip;

/** 简介 */
@property(nonatomic, copy) NSString *intro;

/** 我关注了多少人 */
@property(nonatomic, assign) uint64_t following;

/** 多少人关注了我 */
@property(nonatomic, assign) uint64_t followers;

/** 收获多少赞 */
@property(nonatomic, assign) uint64_t likes;


/** 请求获取用户信息 */
- (void)reqRefehUserInfo:(onRequestSuccess)succ :(onRequestFail)failed;

//请求获取用户信息-
+ (void)reqRefehUserBaseInfo:(onRequestSuccess)succ :(onRequestFail)failed;

+ (void)userDefaultsUpdataUserbaseInfo:(appvapiUserInfoBasic *)resp;
+ (void)ZeroPointReqRefehUserBaseInfo:(onRequestSuccess)succ :(onRequestFail)failed;

@end

NS_ASSUME_NONNULL_END
