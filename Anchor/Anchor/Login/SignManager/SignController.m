//
//  SignController.m
//  KK
//
//  Created by hk on 2021/8/5.
//

#import "SignController.h"
#import "serviceucSignInApiguestGuestRequest.h"
#import "serviceucSignInApitelephoneTelephoneSignInRequest.h"
#import "HeadPools.h"
#import "appvapiUserApigetBaseInfoEmptyRequest.h"
#import "KKTabbarVC.h"
#import "KKUtilityTool.h"
#import "KKTool.h"
#import "AppDelegate.h"
#import "NetWorkError.h"
@interface SignController()
@property (nonatomic, assign)BOOL isChangeCount;

@end
@implementation SignController


//公用登陆接口
- (void)sign{
    if(!([[KKUserInfo share] ucToken].length>0)){
        NSLog(@"执行游客登陆");
        [self guestRequest];
    }else{
        NSString* ucToken = [[KKUserInfo share] ucToken];
        [self ucLoginSuccess:ucToken];
    }
}


//调用游客登陆
-(void)guestRequest{
    //游客登陆成功返回用户信息
    [KKLoadingView showView];
    serviceucSignInApiguestGuestRequest* req = [serviceucSignInApiguestGuestRequest createRequest];
    req.request.uuid = [KKTool getUUIDByKeyChain];
    req.request.deviceInfo.idfa = [KKTool getUUIDByKeyChain];
    req.request.deviceInfo.imei = @"";
    req.request.deviceInfo.model = [KKUtilityTool deviceModelName];//iphone 7
    req.request.deviceInfo.osName = serviceucOSName_OsNameIos;
    req.request.deviceInfo.uuid =[KKTool getDeviceUUID];
    req.request.deviceInfo.osVersion = [KKUtilityTool getPhoneVersion];//ios 14.3
    req.request.deviceInfo.brand = [KKUtilityTool getPhoneModel];//iphone
    if ([[UIPasteboard generalPasteboard] string].length) {
        // 读取粘贴板
        NSString * pastBoardString = [[UIPasteboard generalPasteboard] string];
        NSString * replaceStr = @"#SSCODE#";
        if ([pastBoardString containsString:replaceStr]) {
             NSString *strUrl = [pastBoardString stringByReplacingOccurrencesOfString:replaceStr withString:@""];
            if ([KKUserInfo share].isReadShareCode == 0) {
                [KKUserInfo share].isReadShareCode = 1;
                req.request.shareCode = strUrl;
            }
        }
    }
    
    [[NetWorkMgr createMgrWithMessage:req] sendRequest:^(serviceucAccountAccessResponse*   message) {
        [KKUserInfo share].uuid = message.uuid;
        //刷新uctoken
        [KKLoadingView hidden];
        if(message.hasBind){
            [[KKUserInfo share] setTelephone:message.bind.tel.telephone];
        }
        [self ucLoginSuccess:message.ucToken];
        
    } failed:^(requestErrorCode errorCode) {
        
        if (errorCode == 1) {
            NSString *showtext = [KKErrrortext getErrorWitherrorRequestType:KKUserAccountBlocked WithErrorCode:errorCode];

            UIWindow *window =[[UIApplication sharedApplication].delegate window];
            UILabel *showlabel = [[UILabel alloc] init];
            [showlabel setFont:[UIFont systemFontOfSize:16]];
            [showlabel setTextAlignment:NSTextAlignmentCenter];
            [window addSubview:showlabel];
            [showlabel setTextColor:[UIColor whiteColor]];
            [showlabel mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.equalTo(window.mas_centerY).offset(60);
                            make.left.right.equalTo(window);
                            make.height.equalTo(@40);
            }];
            [showlabel setText:showtext];
            ///账户被封
            [KKLoadingView hidden];
        }
        else{
            NSString *showtext = [KKErrrortext getErrorWitherrorRequestType:KKUCLogin WithErrorCode:errorCode];
            KKAltItemConfig* item = [KKAltItemConfig initWithItemConfig:@"重试" buttonEnable:YES];
            KKAltStyleConfig* controller = [[KKAltStyleConfig initWithTitleAndContent:@"提示" content:showtext] setViewEnable:NO];
            [controller.itemConfigArray  addObject:item];
            [KKAltView dismiss];
            WS
            [KKAltView showAltViewWithConfigModel:controller WithClickBlock:^(NSInteger clickIndex) {
                SS
                [[KKUserInfo share] clearUserInfo];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                    [self sign];
                });
            }];
        }
    }];
}

//请求uc登陆
-(void)enterWithUc{
   
    [KKLoadingView showView];
    appvapiPassportApienterEnterRequest* req = [appvapiPassportApienterEnterRequest createRequest];
    [[HeadPools getHeadPool] updateHeadVal:xToken :@""];
    NSString* ucToken =[[KKUserInfo share]ucToken];
    req.request.ucToken = ucToken;
    
    NetWorkMgr*netWork = [NetWorkMgr createMgrWithMessage:req];
    netWork.useToken = NO;
     [netWork sendRequest:^(appvapiEnterResponse* message) {
        //刷新apitoken
         [KKLoadingView hidden];
         
         if (message.hasConfig) {
             
             [[KKPubTagVCModel shareToolGetManager]requestTagList:message];
             
             if (![KKPubTagVCModel shareToolGetManager].enableServiceAccess) {
                 NSString *showtext = @"App维护中";
                 [KKLoadingView hidden];
                 KKAltItemConfig* item = [KKAltItemConfig initWithItemConfig:@"确定" buttonEnable:YES];
                 KKAltStyleConfig* controller = [[KKAltStyleConfig initWithTitleAndContent:@"提示" content:showtext] setViewEnable:NO];
                 [controller.itemConfigArray  addObject:item];
                 [KKAltView dismiss];
                 [KKAltView showAltViewWithConfigModel:controller WithClickBlock:^(NSInteger clickIndex) {
                     exit(0);
                 }];
                 return;
             }
         }
         
        if(message.hasUserInfo){
            [[HeadPools getHeadPool] updateHeadVal:ApiToken :message.token];
            [[HeadPools getHeadPool] updateHeadVal:xToken :ucToken];
            [[HeadPools getHeadPool] updateHeadVal:xNetCore :message.userInfo.uid.id_p];
            //同步用户信息
            [[KKUserInfo share] userDefaultsUserInfo:message];
            //--->ok. success!
            [self.loginSignilCallBack sendNext:@"ok"];
            [self initApp];
            if (self.isChangeCount) {
                [[SDImageCache sharedImageCache] clearMemory];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
                [SVProgressHUD dismiss];
               
                UIWindow *window = [[UIApplication sharedApplication].delegate window];
                KKTabbarVC * tabBarController = [[KKTabbarVC alloc]init];
                window.rootViewController = tabBarController;
                [window makeKeyAndVisible];
                self.isChangeCount =NO;
            }
            NSLog(@"enterwithuc login success!");
        }else{
            [[KKUserInfo share] clearUserInfo];
            [self sign];
        }
         
//         [[KKPubTagVCModel shareToolGetManager] requestSocketTokenSystem];
        
    } failed:^(requestErrorCode errorCode) {
        
        
        NSString *showtext = [KKErrrortext getErrorWitherrorRequestType:errorCode WithErrorCode:errorCode];
        [KKLoadingView hidden];
        [SVProgressHUD showMessage:showtext];
        [[KKUserInfo share] clearUserInfo];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self sign];
        });
    }];
}
+(void)loginApiLogin{
    apimomentsuserapiloginApiLogin * request = [apimomentsuserapiloginApiLogin createRequest];
    request.request.userInfo.uid = [KKUserInfo share].uid  ;//response.userInfo.uid.id_p
    request.request.userInfo.nickname = [KKUserInfo share].nickname;// response.userInfo.nickname;
    request.request.userInfo.area= [KKUserInfo share].city;// response.userInfo.city;
    request.request.userInfo.vip = [[KKUserInfo share].vip intValue];
    request.request.userInfo.creationLevel = [KKUserInfo share].creationLevel;
    request.request.userInfo.sex = (int32_t)[KKUserInfo share].gender;
    request.request.userInfo.image = [KKUserInfo share].avatarURL;
    [[NetWorkMgr createMgrWithMessage:request] sendRequest:^(id  _Nonnull message) {
        
    } failed:^(requestErrorCode errorCode) {
        
    }];
}

//初始化登陆后app进程。
-(void)initApp{
    
}

-(void)getBaseInfo{
    appvapiUserApigetBaseInfoEmptyRequest* req = [appvapiUserApigetBaseInfoEmptyRequest createRequest];
    [[NetWorkMgr createMgrWithMessage:req] sendRequest:^(appvapiUserInfoBasic*  _Nonnull message) {
        
 
    } failed:^(requestErrorCode errorCode) {
        
    }];
}


//请求切换账号
//切换账号必须是已经存在的手机号码，否则将会切换失败！
-(void)telephoneLogin:(long)sms_id
             sms_code:(NSString*)sms_code
               region:(NSString*)region
            telephone:(NSString*)telephone
                 uuid:(NSString*)uuid{
    self.isChangeCount =YES;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:@"账号正在切换..."];
  
    serviceucSignInApitelephoneTelephoneSignInRequest* req = [serviceucSignInApitelephoneTelephoneSignInRequest createRequest];
    req.request.uuid = [KKTool getUUIDByKeyChain];
    req.request.sms = [[serviceucSmsValid alloc] init];
    req.request.sms.smsCode = sms_code;
    req.request.sms.smsId = sms_id;
    req.request.tel = [[serviceucTelephone alloc] init];
    req.request.tel.telephone = telephone;
    req.request.tel.region = region;
    
    req.request.deviceInfo.idfa = [KKTool getDeviceUUID];
    req.request.deviceInfo.model = [KKUtilityTool deviceModelName];//iphone 7
    req.request.deviceInfo.osName = serviceucOSName_OsNameIos;
    req.request.deviceInfo.uuid =[KKTool getDeviceUUID];
    req.request.deviceInfo.osVersion = [KKUtilityTool getPhoneVersion];//ios 14.3
    req.request.deviceInfo.brand = [KKUtilityTool getPhoneModel];//iphone
    
    [[NetWorkMgr ucCreateMgrWithMessage:req useToken:NO] sendRequest:^(serviceucAccountAccessResponse *message) {
        [SVProgressHUD dismiss];
        //回调成功消息
        if (!kStringIsEmpty(message.uuid)) {
            [KKUserInfo share].uuid = message.uuid;
        }
        [[KKUserInfo share] setTelephone:telephone];
        [self ucLoginSuccess:message.ucToken];
        NSLog(@"切换账号成功!");
    } failed:^(requestErrorCode errorCode) {
        [KKLoadingView hidden];
        [SVProgressHUD dismiss];
        NSString* errorCodeStr = [[NetWorkError getInstance]getCode:(int)errorCode];
        [SVProgressHUD showMessage:errorCodeStr];
    }];
}


//uc登陆成功!
-(void)ucLoginSuccess:(NSString*)ucToken{
    //调用enterWithUc 禁止传token
    [[HeadPools getHeadPool] updateHeadVal:xToken :@""];
    [[HeadPools getHeadPool] updateHeadVal:ApiToken :@""];
    [[KKUserInfo share] setUcToken:ucToken];
   

    [self enterWithUc];
}


//登陆成功回调
-(RACSubject*)loginSignilCallBack{
    if(_loginSignilCallBack == nil){
        _loginSignilCallBack = [RACSubject subject];
    }
    return _loginSignilCallBack;
}
    
@end
