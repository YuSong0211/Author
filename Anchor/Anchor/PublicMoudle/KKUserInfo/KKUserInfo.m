//
//  UserInfo.m
//  BinbinHelp
//
//  Created by Mr.K on 2018/5/14.
//  Copyright © 2018年 Beijing BinBinYouLi Network Technology Co., Ltd. All rights reserved.
//

#import "KKUserInfo.h"
#import "SignController.h"
#import "KKJurisdictionManager.h"
@implementation KKUserInfo

static KKUserInfo *_info = nil;
static dispatch_once_t onceToken;

+ (KKUserInfo *)share {
    dispatch_once(&onceToken, ^{
        _info = [[self alloc] init];
    });
    return _info;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static  dispatch_once_t once;
    dispatch_once(&once, ^{
        if (_info == nil) {
            _info = [[super allocWithZone:zone] init];
        }
    });
    return _info;
}
- (nonnull id)copyWithZone:(NSZone *)zone {
    return _info;
}

- (nonnull id)mutableCopyWithZone:(NSZone *)zone {
    return _info;
}
- (void)clearUserInfo{
    // 清除用户信息(切换账号与退出登录需要使用)
    self.ucToken = @"";
    self.apiToken = @"";
    [kUserDefaults removeObjectForKey:@"ucToken"];
    [kUserDefaults removeObjectForKey:@"telephone"];
    [kUserDefaults removeObjectForKey:@"uid"];
    [kUserDefaults removeObjectForKey:@"nickname"];
    [kUserDefaults removeObjectForKey:@"gender"];
    [kUserDefaults removeObjectForKey:@"avatarURL"];
    [kUserDefaults removeObjectForKey:@"city"];
    [kUserDefaults removeObjectForKey:@"vip"];
    [kUserDefaults removeObjectForKey:@"following"];
    [kUserDefaults removeObjectForKey:@"followers"];
    [kUserDefaults removeObjectForKey:@"likes"];
    [kUserDefaults removeObjectForKey:@"apiToken"];
    [kUserDefaults removeObjectForKey:@"shareCode"];
    [kUserDefaults removeObjectForKey:@"signCode"];
    [kUserDefaults removeObjectForKey:[KKUserInfo share].uid];
    [kUserDefaults removeObjectForKey:@"intro"];
    self.member_level = 0;
    self.isvip = NO;
    [kUserDefaults synchronize];
//    [kUserDefaults removeObjectForKey:@"signSuccessType"];// 实现自动登录退出登录的时候不清除登录方式存储
}

- (void)setUuid:(NSString *)uuid {
    [kUserDefaults setObject:uuid forKey:@"mxkj_uuid"];
    [kUserDefaults synchronize];
}

- (NSString *)uuid {
    return [kUserDefaults stringForKey:@"mxkj_uuid"];
}

- (void)setUid:(NSString *)uid {
    [kUserDefaults setObject:uid forKey:@"uid"];
    [kUserDefaults synchronize];
}
- (NSString *)uid {
    return [kUserDefaults stringForKey:@"uid"];
}
- (void)setNickname:(NSString *)nickname {
    [kUserDefaults setObject:nickname forKey:@"nickname"];
    [kUserDefaults synchronize];
}
-(NSString *)nickname {
    return [kUserDefaults stringForKey:@"nickname"];
}
- (void)setGender:(NSInteger)gender {
    [kUserDefaults setInteger:gender forKey:@"gender"];
    [kUserDefaults synchronize];
}


-(void)setMember_expiration_time:(NSInteger)member_expiration_time{
    [kUserDefaults setInteger:member_expiration_time forKey:@"member_expiration_time"];
    [kUserDefaults synchronize];
}

-(NSInteger)member_expiration_time{
    return [kUserDefaults integerForKey:@"member_expiration_time"];;
}

- (NSInteger)gender {
    return [kUserDefaults integerForKey:@"gender"];
}
- (void)setAvatarURL:(NSString *)avatarURL {
    [kUserDefaults setObject:avatarURL forKey:@"avatarURL"];
    [kUserDefaults synchronize];
}
-(NSString *)avatarURL {
    return [kUserDefaults stringForKey:@"avatarURL"];
}
-(void)setCity:(NSString *)city {
    [kUserDefaults setObject:city forKey:@"city"];
    [kUserDefaults synchronize];
}
-(NSString *)city {
    return [kUserDefaults stringForKey:@"city"];
}
- (void)setVip:(NSString *)vip {
    [kUserDefaults setObject:vip forKey:@"vip"];
    [kUserDefaults synchronize];
}
- (NSString *)vip {
    return [kUserDefaults stringForKey:@"vip"];
}
- (void)setFollowing:(CGFloat)following {
    [kUserDefaults setInteger:following forKey:@"following"];
    [kUserDefaults synchronize];
}
-(CGFloat)following {
    return [kUserDefaults floatForKey:@"following"];
}
-(void)setFollowers:(CGFloat)followers {
    [kUserDefaults setInteger:followers forKey:@"followers"];
    [kUserDefaults synchronize];
}
-(CGFloat)followers {
    return [kUserDefaults floatForKey:@"followers"];
}
-(void)setLikes:(CGFloat)likes {
    [kUserDefaults setInteger:likes forKey:@"likes"];
    [kUserDefaults synchronize];
}
-(CGFloat)likes {
    return [kUserDefaults floatForKey:@"likes"];
}
// 用户token取值
- (void)setUcToken:(NSString *)ucToken {
    [richers refreshToken:XTokenType_UC token:kStringIsEmpty(ucToken) ? @"" : ucToken];
//  [kUserDefaults setValue:ucToken forKey:@"ucToken"];
//  [kUserDefaults stringForKey:@"ucToken"];
//  [kUserDefaults synchronize];
}
-(NSString *)ucToken {
   return  [richers  getToken:XTokenType_UC];
}
//简介
-(NSString *)intro{
    return [kUserDefaults stringForKey:@"intro"];
}
-(void)setIntro:(NSString *)intro{
    [kUserDefaults setObject:intro forKey:@"intro"];
    [kUserDefaults synchronize];
}
// 用户业务token
- (void)setApiToken:(NSString *)apiToken {
//    [kUserDefaults setObject:apiToken forKey:@"apiToken"];
//    [kUserDefaults synchronize];
    [richers refreshToken:XTokenType_API token:kStringIsEmpty(apiToken) ? @"" : apiToken];
}
-(NSString *)apiToken {
    return [richers getToken:XTokenType_API];
//    return [kUserDefaults stringForKey:@"apiToken"];
}
-(UIImage *)userImage{
    NSData* imageData = [kUserDefaults objectForKey:self.uid];
    UIImage* image = [UIImage imageWithData:imageData];
    return image;
}
-(void)setUserImage:(UIImage *)userImage{
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(userImage) forKey:self.uid];
//    [kUserDefaults setObject:userImage forKey:self.uid];
    [kUserDefaults synchronize];
}
// 用户绑定后的手机号
- (void)setTelephone:(NSString *)telephone {
    [kUserDefaults setObject:telephone forKey:@"telephone"];
    [kUserDefaults synchronize];
}
-(NSString *)telephone {
    return [kUserDefaults stringForKey:@"telephone"];
}

-(NSString *)shareCode{
    return [kUserDefaults stringForKey:@"shareCode"];;
}

-(NSString *)signCode{
    return [kUserDefaults stringForKey:@"signCode"];;
}
-(NSArray *)appPayIDArray{
    return [kUserDefaults arrayForKey:@"appPayIDArray"];;
}
- (void)setAppPayIDArray:(NSArray *)appPayIDArray{
    [kUserDefaults setObject:appPayIDArray forKey:@"appPayIDArray"];
    [kUserDefaults synchronize];
}
// 是否读取过分享码  0 没有  1有
-(void)setIsReadShareCode:(NSInteger)isReadShareCode{
    [kUserDefaults setObject:[NSNumber numberWithInteger:isReadShareCode] forKey:@"isReadShareCode"];
    [kUserDefaults synchronize];
}

-(NSInteger)isReadShareCode{
    return [[kUserDefaults stringForKey:@"isReadShareCode"] integerValue];
}
-(void)setGrayscale:(BOOL)grayscale{
    [kUserDefaults setBool:grayscale forKey:@"grayscale"];
    [kUserDefaults synchronize];
}
-(BOOL)grayscale{
    return [kUserDefaults boolForKey:@"grayscale"];
}
// 登录方式
- (void)setSignSuccessType:(NSInteger)signSuccessType {
    
    [kUserDefaults setInteger:signSuccessType forKey:@"signSuccessType"];
    [kUserDefaults synchronize];
}
- (NSInteger)signSuccessType {
    return [kUserDefaults integerForKey:@"signSuccessType"];
}
- (BOOL)hasLogin {
    if(!kStringIsEmpty(self.ucToken)){
        // 未登录
        return NO;
    }else {
        // 已登录
        return YES;
    }
}

- (BOOL)hasLogin:(UIViewController *)getCurrentVC {
    if(!kStringIsEmpty(self.ucToken)){
        // 未登录
        LoginViewController *login = [[LoginViewController alloc] init];
        login.isSign = YES;
        [getCurrentVC.navigationController pushViewController:login animated:YES];
        return NO;
    }else {
        // 已登录
        return YES;
    }
}
- (void)gotoLogin {
    
}
-(BOOL)hasBindingTelephone {
    if (!kStringIsEmpty(self.telephone)) {
        // 绑定过
        return YES;
    }else {
        // 未绑定过
        return NO;
    }
    
}

#pragma -mark 存储用户信息
- (void)userDefaultsUserInfo:(appvapiEnterResponse *)resp {
    self.userInfo = resp.userInfo;

    if (resp.userInfo.memberLevel) {
        self.member_level = resp.userInfo.memberLevel;
    }
    if (resp.userInfo.memberExpirationTime) {
        self.member_expiration_time = resp.userInfo.memberExpirationTime;
    }
    if(resp.userInfo.vipProductId){
        self.vipProductId = resp.userInfo.vipProductId;
    }
   NSLog(@"%ld", [KKJurisdictionManager  seeTotalCount]);
    if (resp.userInfo.todayVideoDownloadCount) {
        self.todayDownloadCount = resp.userInfo.todayVideoDownloadCount;
    }
    
    self.creationLevel = resp.userInfo.creationLevel;
    if (resp.token) {
        self.apiToken = resp.token;
    }
    self.userSuperActivity = resp.userInfo.userSuperActivity;
    self.todayDownloadCount = resp.userInfo.todayVideoDownloadCount;
    self.todayVideoPlay3SCount = resp.userInfo.todayVideoPlay3SCount;
    [self setVideoDownCount:self.todayDownloadCount];
    [kUserDefaults setObject:resp.token forKey:@"apiToken"];// 用户业务token
//    [kUserDefaults setObject:!kStringIsEmpty(resp.userInfo.uid.id_p) ? resp.userInfo.uid.id_p : @"" forKey:@"uid"];// 用户uid
    [kUserDefaults setObject:!kStringIsEmpty(resp.userInfo.nickname) ? resp.userInfo.nickname : @"" forKey:@"nickname"];// 用户昵称
    [kUserDefaults setObject:@(resp.userInfo.gender) forKey:@"gender"];// 用户性别
    [kUserDefaults setObject:!kStringIsEmpty(resp.userInfo.avatarURL.URL) ? resp.userInfo.avatarURL.URL : @"" forKey:@"avatarURL"];// 用户头像
    [kUserDefaults setObject:!kStringIsEmpty(resp.userInfo.city) ? resp.userInfo.city : @"未知" forKey:@"city"];// 用户所在地
    //[kUserDefaults setObject:!kStringIsEmpty(resp.userInfo.vip) ? resp.userInfo.vip : @"" forKey:@"vip"];// 用户是否是vip用户
    [kUserDefaults setObject:@(resp.userInfo.userSocial.following) forKey:@"following"];// 用户关注人数
    [kUserDefaults setObject:@(resp.userInfo.userSocial.followers) forKey:@"followers"];// 粉丝数量
    [kUserDefaults setObject:resp.userInfo.uid.id_p forKey:@"uid"];// 用户id
    [kUserDefaults setObject:@(resp.userInfo.userSocial.likes) forKey:@"likes"];// 收到赞的数量
    [kUserDefaults setObject:resp.userInfo.shareCode.shareCode forKey:@"shareCode"];// 分享码
    [kUserDefaults setObject:resp.userInfo.shareCode.args forKey:@"signCode"];// 分享码
    if (!kStringIsEmpty(resp.userInfo.intro)) {
    [kUserDefaults setObject:resp.userInfo.intro forKey:@"intro"];//简介
    }
    [kUserDefaults synchronize];
    
    [self requestWatchArrId];//存取观看的ID
}

-(void)requestWatchArrId{
//    [richers setApp:APP_TEST debugNetUrl:@"http://192.168.31.214" encodeBody:NO];
    appvapiUserApigetTodayVideoPlayListEmptyRequest *req  =[appvapiUserApigetTodayVideoPlayListEmptyRequest createRequest];
    [[NetWorkMgr createMgrWithMessage:req]sendRequest:^(appvapiVideoPlayListResponse *  _Nonnull message) {
        NSMutableArray *arr = [NSMutableArray array];
        for (appvapiIdEncode *encode in message.todayPlayVideoIdsArray) {
            [arr addObject:encode.id_p];
        }
        [KKJurisdictionManager shareManager].seeArray = arr;
//        [KKJurisdictionManager shareManager].seeArray = [NSMutableArray array];
        NSLog(@"GETBACKSeeArr---%@",arr);
    } failed:^(requestErrorCode errorCode) {
        NSLog(@"%d",errorCode);
    }];
    
}

-(void)setVideoDownCount:(NSInteger)downCount{
    if ([KKJurisdictionManager shareManager].DownArray.count == 0) {
        
    }
    else{
        if (downCount == 0) {
            [KKJurisdictionManager shareManager].DownArray = @[];
        }
//        if (downCount-[KKJurisdictionManager shareManager].DownArray.count<[self share].todayDownloadCount) {
//            [KKJurisdictionManager shareManager].DownArray = @[];
//        }
    }
   
}
+(void)userInforChange{
    if ([KKUserInfo share].changeUserInForBlock) {
        [KKUserInfo share].changeUserInForBlock();
    }
    [SignController loginApiLogin];
}
-(NSMutableArray *)videoCacheArr{
    if (!_videoCacheArr) {
        _videoCacheArr = [NSMutableArray array];
    }
    return _videoCacheArr;
}
-(NSMutableDictionary *)videoCacheDic{
    if (!_videoCacheDic) {
        _videoCacheDic = [[NSMutableDictionary alloc] init];
    }
    return _videoCacheDic;
}
-(NSMutableDictionary *)taskDict{
    if (!_taskDict) {
        _taskDict = [NSMutableDictionary dictionary];
    }
    return _taskDict;
}
+ (void)saveKeywords:(NSDictionary *)dict {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        path = [path stringByAppendingPathComponent:@"videocache.plist"];

        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            BOOL succ =  [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
        }

//    NSString *dicStr = [KKTool convertToJsonData:dict];
        BOOL succ = [dict writeToFile:path atomically:YES];
        if (succ) {
            NSLog(@"存储成功");
        } else {
            NSLog(@"存储失败");
        }
}
+ (NSDictionary *)getKeyWordsFromPlist {
//    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"videocache.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    return [NSDictionary dictionaryWithContentsOfFile:path];
//    return @{};
}

@end
