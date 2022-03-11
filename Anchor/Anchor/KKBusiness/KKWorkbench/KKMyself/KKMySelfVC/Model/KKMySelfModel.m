//
//  KKMySelfModel.m
//  KK
//
//  Created by 小鱼 on 2021/6/24.
//

#import "KKMySelfModel.h"

@implementation KKMySelfModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

//请求获取用户信息-
- (void)reqRefehUserInfo:(onRequestSuccess)succ :(onRequestFail)failed{
    
    
    appvapiUserApigetBaseInfoEmptyRequest *req = [appvapiUserApigetBaseInfoEmptyRequest createRequest];
    [[NetWorkMgr createMgrWithMessage:req] sendRequest:^(appvapiUserInfoBasic*  _Nonnull message) {
        //处理用户信息
        [self userDefaultsUpdataUserInfo:message];
        succ(message);
    } failed:^(requestErrorCode errorCode) {
    }];
}




- (void)userDefaultsUpdataUserInfo:(appvapiUserInfoBasic *)resp {
    [kUserDefaults setObject:!kStringIsEmpty(resp.uid.id_p) ? resp.uid.id_p : @"" forKey:@"uid"];// 用户uid
    [kUserDefaults setObject:!kStringIsEmpty(resp.nickname) ? resp.nickname : @"无" forKey:@"nickname"];// 用户昵称
    [kUserDefaults setObject:@(resp.gender) forKey:@"gender"];// 用户性别
    [kUserDefaults setObject:!kStringIsEmpty(resp.avatarURL.URL) ? resp.avatarURL.URL : @"" forKey:@"avatarURL"];// 用户头像
    [kUserDefaults setObject:!kStringIsEmpty(resp.city) ? resp.city : @"" forKey:@"city"];// 用户所在地
    //[kUserDefaults setObject:!kStringIsEmpty(resp.vip) ? resp.vip : @"" forKey:@"vip"];// 用户是否是vip用户
    [kUserDefaults setObject:@(resp.userSocial.following) forKey:@"following"];// 用户关注人数
    [kUserDefaults setObject:@(resp.userSocial.followers) forKey:@"followers"];// 粉丝数量
    [kUserDefaults setObject:@(resp.userSocial.likes) forKey:@"likes"];// 收到赞的数量
    [kUserDefaults synchronize];
    [KKUserInfo share].userInfo = resp;
    [KKUserInfo share].userSuperActivity = resp.userSuperActivity;
}

//请求获取用户信息-
+ (void)reqRefehUserBaseInfo:(onRequestSuccess)succ :(onRequestFail)failed{
    
    
    appvapiUserApigetBaseInfoEmptyRequest *req = [appvapiUserApigetBaseInfoEmptyRequest createRequest];
    [[NetWorkMgr createMgrWithMessage:req] sendRequest:^(appvapiUserInfoBasic*  _Nonnull message) {
        //处理用户信息
        [self userDefaultsUpdataUserbaseInfo:message];
        succ(message);
    } failed:^(requestErrorCode errorCode) {
    }];
}




+ (void)userDefaultsUpdataUserbaseInfo:(appvapiUserInfoBasic *)resp {
    [kUserDefaults setObject:!kStringIsEmpty(resp.uid.id_p) ? resp.uid.id_p : @"" forKey:@"uid"];// 用户uid
    [kUserDefaults setObject:!kStringIsEmpty(resp.nickname) ? resp.nickname : @"无" forKey:@"nickname"];// 用户昵称
    [kUserDefaults setObject:@(resp.gender) forKey:@"gender"];// 用户性别
    [kUserDefaults setObject:!kStringIsEmpty(resp.avatarURL.URL) ? resp.avatarURL.URL : @"" forKey:@"avatarURL"];// 用户头像
    [kUserDefaults setObject:!kStringIsEmpty(resp.city) ? resp.city : @"" forKey:@"city"];// 用户所在地
    //[kUserDefaults setObject:!kStringIsEmpty(resp.vip) ? resp.vip : @"" forKey:@"vip"];// 用户是否是vip用户
    [kUserDefaults setObject:@(resp.userSocial.following) forKey:@"following"];// 用户关注人数
    [kUserDefaults setObject:@(resp.userSocial.followers) forKey:@"followers"];// 粉丝数量
    [kUserDefaults setObject:@(resp.userSocial.likes) forKey:@"likes"];// 收到赞的数量
    [kUserDefaults synchronize];
    [KKUserInfo share].userInfo = resp;
    [KKUserInfo share].userSuperActivity = resp.userSuperActivity;

}

//零点获取用户信息-
+ (void)ZeroPointReqRefehUserBaseInfo:(onRequestSuccess)succ :(onRequestFail)failed{
    
    
    appvapiUserApigetBaseInfoEmptyRequest *req = [appvapiUserApigetBaseInfoEmptyRequest createRequest];
    [[NetWorkMgr createMgrWithMessage:req] sendRequest:^(appvapiUserInfoBasic*  _Nonnull message) {
        //处理用户信息
        [self ZeroPointuUserDefaultsUpdataUserbaseInfo:message];
        succ(message);
    } failed:^(requestErrorCode errorCode) {
    }];
}




+ (void)ZeroPointuUserDefaultsUpdataUserbaseInfo:(appvapiUserInfoBasic *)resp {
    [kUserDefaults setObject:!kStringIsEmpty(resp.uid.id_p) ? resp.uid.id_p : @"" forKey:@"uid"];// 用户uid
    [kUserDefaults setObject:!kStringIsEmpty(resp.nickname) ? resp.nickname : @"无" forKey:@"nickname"];// 用户昵称
    [kUserDefaults setObject:@(resp.gender) forKey:@"gender"];// 用户性别
    [kUserDefaults setObject:!kStringIsEmpty(resp.avatarURL.URL) ? resp.avatarURL.URL : @"" forKey:@"avatarURL"];// 用户头像
    [kUserDefaults setObject:!kStringIsEmpty(resp.city) ? resp.city : @"" forKey:@"city"];// 用户所在地
    //[kUserDefaults setObject:!kStringIsEmpty(resp.vip) ? resp.vip : @"" forKey:@"vip"];// 用户是否是vip用户
    [kUserDefaults setObject:@(resp.userSocial.following) forKey:@"following"];// 用户关注人数
    [kUserDefaults setObject:@(resp.userSocial.followers) forKey:@"followers"];// 粉丝数量
    [kUserDefaults setObject:@(resp.userSocial.likes) forKey:@"likes"];// 收到赞的数量
    [kUserDefaults synchronize];
    [KKUserInfo share].userInfo = resp;
    [KKUserInfo share].todayDownloadCount = resp.todayVideoDownloadCount;
    [KKUserInfo share].todayVideoPlay3SCount = resp.todayVideoPlay3SCount;
    [KKUserInfo share].userSuperActivity = resp.userSuperActivity;
    [[KKUserInfo share]requestWatchArrId];// 观看的ID数组
    [[KKUserInfo share]setTodayDownloadCount:resp.todayVideoDownloadCount];//下载数
}




@end
