//
//  KKShareCodeModel.m
//  mt
//
//  Created by ProgramMa on 2021/10/19.
//

#import "KKShareCodeModel.h"
#import "appvapiUserInviteApigetInviteMeCodeEmptyRequest.h"
@implementation KKShareCodeModel
/*
 请求邀请码
 **/
-(void)getShareCode:(getShareCode)Block{
    appvapiUserInviteApigetInviteMeCodeEmptyRequest *req = [appvapiUserInviteApigetInviteMeCodeEmptyRequest createRequest];
    [[NetWorkMgr createMgrWithMessage:req]sendRequest:^(appvapiGetInviteMeCodeResponse *  _Nonnull message) {
        self.shareCode  = message.shareCode;
        Block(self.shareCode);
    } failed:^(requestErrorCode errorCode) {
        self.shareCode  = @"";
        Block(self.shareCode);
    }];
}
/*
 发送邀请码
 **/
-(void)sendShareCode:(NSString *)shareCode withBlock:(sendShareCode)block{
    
    appvapiUserInviteApireceiveInviteReceiveInviteRequest *req = [appvapiUserInviteApireceiveInviteReceiveInviteRequest createRequest];
    req.request.shareCode = shareCode;
    [[NetWorkMgr createMgrWithMessage:req]sendRequest:^(appvapiEmptyResponse *  _Nonnull message) {
        block(YES,0);
    } failed:^(requestErrorCode errorCode) {
        block(NO,errorCode);
    }];
    
    
    
}

@end
