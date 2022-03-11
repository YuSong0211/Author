//
//  KKEditUserInfoModel.m
//  KK
//
//  Created by 小鱼 on 2021/8/6.
//

#import "KKEditUserInfoModel.h"
#import "appvapiUserApiupdateInfoUpdateUserInfo.h"
#import "NetWorkMgr.h"
#import "appvapiUserApiupdateAvatarUpdateAvatarRequest.h"

@implementation KKEditUserInfoModel
#pragma -mark 修改用户信息
+ (void)changeUserInfo:(NSString *)nickname
                gender:(appvapiGenders)gender
                 intro:(NSString *)intro
            completion:(HttpRequestCompletion)completionSucess {
    appvapiUserApiupdateInfoUpdateUserInfo *req = [appvapiUserApiupdateInfoUpdateUserInfo createRequest];
    if (nickname) {
        req.request.nickname = [NSString htmlEncode:nickname];
    }
    if (gender) {
        req.request.gender = gender;
    }
    if (intro) {
        req.request.intro.raw = [NSString htmlEncode:intro];
    }
    
    NSLog(@"intro长度 ---  %ld",intro.length);
    
    [[NetWorkMgr createMgrWithMessage:req] sendRequest:^(appvapiEmptyResponse*  _Nonnull message) {
        if (completionSucess) {
            completionSucess(YES);
        }
    } failed:^(requestErrorCode errorCode) {
        if (completionSucess) {
            completionSucess(NO);
        }
    }];
}

/// 上传用户头像
/// @param userAvaterInfo 用户头像信息
/// @param completion 回调完成
+(void)uploadingUserAvaterToServiseModel:(KKUploadInfoModel *)userAvaterInfo completion:(nonnull void (^)(KKUploadAuthenticationModel * _Nonnull))completion{
    appvapiUserApiupdateAvatarUpdateAvatarRequest * req = [appvapiUserApiupdateAvatarUpdateAvatarRequest createRequest];
  
    UploadOSSDataModel * avaterModel = [userAvaterInfo.soucreArray firstObject];
    req.request.avatarFile.URL = avaterModel.objectName;
    NSData * imagedata = UIImageJPEGRepresentation(avaterModel.image, 0.8);
    req.request.avatarFile.fileByteSize = [imagedata length];
    
    [[NetWorkMgr createMgrWithMessage:req] sendRequest:^(appvapiOssEvents * message) {
        // 初始化鉴权信息
        KKUploadAuthenticationModel * authentication = [[KKUploadAuthenticationModel alloc]init];
        authentication.accessKey = message.ossToken.accessKey; // 临时-access-key
        authentication.secretKey = message.ossToken.secretKey; // 临时-secret-key
        authentication.sessionToken = message.ossToken.sessionToken; // 临时会话token
        authentication.expiration = message.ossToken.expiration; // 会话过期的时间点（毫秒时间戳）
        authentication.batchId = message.batchId.id_p; // 本次上传的批次
        authentication.fileEventsArray = message.fileEventsArray;
        // 回调
        completion(authentication);
    } failed:^(requestErrorCode errorCode) {
    }];
}
@end
