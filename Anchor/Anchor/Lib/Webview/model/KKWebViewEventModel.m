//
//  KKWebViewEventModel.m
//  mt
//
//  Created by 小草 on 2021/10/19.
//

#import "KKWebViewEventModel.h"
#import "HeadPools.h"

@implementation KKWebViewEventModel

// 初始化调用webview方法，传入用户信息
+(NSString *)callbackTwoWebviewConversionData:(BOOL)isDeveloper{
    NSString * ucToken = [KKUserInfo share].ucToken;
    NSString * apiToken = [KKUserInfo share].apiToken;
    NSString * uid = [KKUserInfo share].uid;
    NSString * nickname = kStringIsEmpty([KKUserInfo share].nickname) ? @"" : [KKUserInfo share].nickname;
    NSInteger  member_level =[KKUserInfo share].member_level;
    NSInteger  member_expiration_time =[KKUserInfo share].member_expiration_time;
    NSInteger  creationLevel =[KKUserInfo share].creationLevel;
    NSString *vipProductId = [KKUserInfo share].vipProductId.id_p;
    NSInteger userVipActivity = [KKUserInfo share].userSuperActivity.userVipActivity == YES?1:0;
    NSInteger activityEndTime = [KKUserInfo share].userSuperActivity.activityEndTime;
    
    
    if (ucToken.length == 0 && apiToken.length == 0 && nickname.length == 0) {
        [SVProgressHUD showMessage:@"webview参数无效"];
        return @"";
    }
    
    // 往webview注入参数时，apitoken和uctoken可以去掉了（但开发者模式里的获取webview参数里，还需要保留）
    
    BOOL isPhone = [KKUserInfo share].telephone.length>0;
    
    NSDictionary *dataDict = @{@"apiToken":apiToken,@"ucToken":ucToken,@"vipProductId":vipProductId,@"id":uid,@"nickName":nickname,@"memberLevel":@(member_level),@"memberExpirationTime":@(member_expiration_time),@"creationLevel":@(creationLevel),@"appBgColor":[KKColor hexadecimalFromUIColor:[KKColor getColor:appBgColor]],@"channel":[HeadPools getHeadPool].xUcChannelKeyHead.value,@"activityEndTime":@(activityEndTime),@"userVipActivity":@(userVipActivity),@"appMainTextColor":[KKColor hexadecimalFromUIColor:[KKColor getColor:appMainTextColor]],@"appBuildType":appBuildType,@"memberBind":@(isPhone)};
    
    NSMutableDictionary *totalDataDict = [[NSMutableDictionary alloc]initWithDictionary:dataDict];
    if (isDeveloper == NO) {
        [totalDataDict removeObjectForKey:@"apiToken"];
        [totalDataDict removeObjectForKey:@"ucToken"];
    }
    NSDictionary * params = @{@"data":totalDataDict,@"event":@"gotToken"};
    // 字典转字符串
    return [KKTool convertToJsonData:params];
}


/// 支付结果回调js
/// @param resultType 支付结果。 成功，失败，取消
/// @return 支付结果
+(NSString *)payResultCallBackJs:(KKWebPayType)resultType{
    NSString * result;
    switch (resultType) {
        case KKWebPaySuccess:
            result = @"success";
            break;
        case KKWebPayFail:
            result = @"fail";
            break;
        case KKWebPayCancel:
            result = @"cancel";
            break;
        case KKWebPayOrderAuthFail:
            result = @"orderAuthFail";
            break;
        case KKWebPayNoUseApplePay:
            result = @"noUseApplePay";
            break;
        default:
            break;
    }
    NSDictionary * params = @{@"data":result,@"event":@"iapResult"};
    // 字典转字符串
    return [KKTool convertToJsonData:params];
}

/// 每次从后台回到前台，获取从上一页面返回，通知webview
+(NSString *)viewwillApperNofiJs{
    NSDictionary * params = @{@"event":@"pageResume"};
    return [KKTool convertToJsonData:params];
}
@end
