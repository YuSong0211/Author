//
//  KKJurisdictionManager.m
//  KK
//
//  Created by 小鱼 on 2021/8/26.
//

#import "KKJurisdictionManager.h"
#import "KKUserInfo.h"
#import "KKApplePay.h"
#import "KKPubTagVCModel.h"
@interface KKJurisdictionManager()
@property (nonatomic, strong)KKMemberUpgradeView *KKmemberView;
@property (nonatomic, strong)NSMutableArray *seeViewArray;
@property (nonatomic, strong)NSMutableArray *blockArray;
@end
@implementation KKJurisdictionManager
+ (KKJurisdictionManager *)shareManager {
    static dispatch_once_t once;
    static KKJurisdictionManager *manager;
    dispatch_once(&once, ^{
        manager = [KKJurisdictionManager new];

    });
    return manager;
}
+(void)isCanDownVideoWithView:(UIView*)showView  WithVIdeoID:(NSString *)videoID WithResult:(authResult)result{
    if ([KKJurisdictionManager downCount]) {
        [self downCounWithVideoID:videoID];
        result(YES);
    }else{
        [self getCurentEventBindResultBlock:result];
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        [self showPuyAlertView:memberdownload WithUiview:window WithResult:result];
    }
}

+(void)isCanCommentVideooWithView:(UIView*)showView WithResult:(authResult)result{
    if ([KKJurisdictionManager isCanComment]) {
        result(YES);
    }
    else{
        [self getCurentEventBindResultBlock:result];
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        [self showPuyAlertView:memberComment WithUiview:window WithResult:result];
    }
}

+(void)isCanSeeVideooWithView:(UIView*)showView WithAVModel:(AvModel *)avmode WithResult:(authResult)result{
    
    if ([avmode.video.userInfo.uid.id_p isEqualToString:[KKUserInfo share].uid]) {
        result(YES);
    }
    else if ([KKJurisdictionManager seeCountWithVidoeID:avmode.video.svideoId.id_p]) {
        result(YES);
    }
    else{
        [self getCurentEventBindResultBlock:result];
        [self showPuyAlertView:memberWatch WithUiview:showView WithResult:result];
        result(NO);
    }
}

+(void)isCanChatWithView:(UIView*)showView WithResult:(authResult)result{
    if ([KKJurisdictionManager isCanComment]) {
        result(YES);
    }
    else{
        [self getCurentEventBindResultBlock:result];
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        [self showPuyAlertView:memberChat WithUiview:window WithResult:result];
    }
}

+(void)showPuyAlertView:(KKMemberUpdateType )type WithUiview:(UIView*)view WithResult:(authResult)result{
    [self shareManager].KKmemberView =  [KKMemberUpgradeView showMTMemberUpdateViewWithMemberUpdateType:type withShowView:view WithPromoteblock:^{
        [self handelBuyBlockWithBuytype:0 WithMTMemberUpdateType:type];
    } WithBuyBlock:^{
        [self handelBuyBlockWithBuytype:1 WithMTMemberUpdateType:type];

    }];
    [self shareManager].KKmemberView.resultBlock = result;
    [self shareManager].KKmemberView.vcType = [self getnowVcViewtype];
    [[KKJurisdictionManager shareManager].viewArray addObject: [self shareManager].KKmemberView];
  

}
+(void)handelBuyBlockWithBuytype:(NSInteger)buyType WithMTMemberUpdateType:(KKMemberUpdateType )type{
    if (type == memberdownload ||type == memberComment || type== memberChat ) {
        
        for (KKMemberUpgradeView *view in [KKJurisdictionManager shareManager].viewArray) {
            if (view.Membertype == type) {
                [view removeFromSuperview];
                [[KKJurisdictionManager shareManager].viewArray removeObject:view];
                break;
            }
        }
    }
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation==UIInterfaceOrientationLandscapeLeft||orientation==UIInterfaceOrientationLandscapeRight) {
        NSDictionary *dic = @{@"goType":[NSNumber numberWithInteger:buyType]};
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        NSNotification *notifacation = [[NSNotification alloc]initWithName:ClickbuyAlertCenter object:nil userInfo:dic];
        [center postNotification:notifacation];
    }
    else{
        
        if (buyType == 1) {
            //    KKMemberCenterViewController *vc = [[KKMemberCenterViewController alloc]init];
            //    vc.VipType = [KKUserInfo share].member_level;
            //    [[KKTool getCurrentVC].navigationController pushViewController:vc animated:YES];
            CustomWebViewController * newWeb = [[CustomWebViewController alloc]initWithUrl:[KKTool getMemberVipUrl] title:@"" vcType:CustomWebViewNav];
            [[KKTool getCurrentVC].navigationController pushViewController:newWeb animated:YES];
        }
        else{
           
        }
    }
    
}

+(void)handeBuyEndblock{
    for (KKMemberUpgradeView *vie in [KKJurisdictionManager shareManager].viewArray) {
        vie.resultBlock(YES);
    }
    [self disMisiAllMeView];
}
+(void)getCurentEventBindResultBlock:(authResult)result{
    [KKJurisdictionManager shareManager].resultBlock = result;
                                  
  
//    [self disMisiAllMeView];
//    result(YES);
}

#pragma  mark ====跳转支付页面后 是否支付返回页面时 处理是否有权限处理相应操作
- (void)payResultBack{
    
}
+(NSInteger)downCounWithVideoID:(NSString *)videoID{
    if ([self downTotalCount]==INT32_MAX) {
        [KKJurisdictionManager shareManager].DownArray=@[];
    }
    else{
        [self addDownWithAVID:videoID];
    }
    return [self downCount];
}
+(void)addDownWithAVID:(NSString *)vId{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[self shareManager].DownArray];
    if (![arr containsObject:vId]) {
        [arr addObject:vId];
        [self shareManager].DownArray = arr;
    }
   
}
+(void)addSeeCountWithAVid:(NSString *)vId{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[self shareManager].seeArray];
    if (![arr containsObject:vId]) {
        [arr addObject:vId];
        [self shareManager].seeArray = arr;
    }
}

///剩余可下载次数
+(NSInteger)downCount{
//
    if ([self downTotalCount] ==INT32_MAX) {
        return [self downTotalCount];
    }
    else if([self downTotalCount]-[KKJurisdictionManager shareManager].DownArray.count>0){
        if ([self downTotalCount]<[KKJurisdictionManager shareManager].DownArray.count) {
            return 0;
        }
        return [self downTotalCount]-[KKJurisdictionManager shareManager].DownArray.count;
    }
    else return 0;
}

///已下载数量
+(NSInteger)downEndCount{
    if ([self downTotalCount] == INT32_MAX) {
        return [self downTotalCount];
    }
    else{
        return [KKJurisdictionManager shareManager].DownArray.count;
//        return 0;
    }

}
+(BOOL)isCanSeeWithAvid:(NSString *)avID{
    if ([self seeCount]) {
        return  YES;
    }
    else if ([[self shareManager].seeArray containsObject:avID]){
        return YES;
    }
    else{
        return  NO;
    }
}
///剩余可观看次数
+(NSInteger)seeCount{
    if ([self seeTotalCount] == INT32_MAX) {
        return [self seeTotalCount];
    }
    else if ([self seeTotalCount]>[KKJurisdictionManager shareManager].seeArray.count) {
        return [self seeTotalCount]-[KKJurisdictionManager shareManager].seeArray.count;
    }
    else{
        return 0;
    }
}
///已观看次数
+(NSInteger)seeEndCount{
//    if ([self seeTotalCount] == INT32_MAX) {
//        return [self seeTotalCount];
//    }
//    else{
//        return [KKJurisdictionManager shareManager].seeArray.count;
//    }
    return [KKJurisdictionManager shareManager].seeArray.count;
}
#pragma mark ===配置下载视频数量 观看视频数量
///用户级别可观看总数
+(NSInteger)seeTotalCount{
    return [KKPubTagVCModel shareToolGetManager].videoCount;
//    if ( [KKPubTagVCModel shareToolGetManager].videoCount == INT32_MAX) {
//        return INT32_MAX;
//    }
//    else
//    return 10;
}
///用户级别可下载总数
+(NSInteger)downTotalCount{
//    return 10;
    return   [KKPubTagVCModel shareToolGetManager].downCount;
//    if ([self member_level] ==2) {
//        return  1000;
//    }
//    else if ([self member_level] ==1){
//        return 3;
//    }
//    else{
//        return 1;
//    }
}
+(NSInteger)seeCountWithVidoeID:(NSString *)VideoID{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[self shareManager].seeArray];
    if ([self member_level]>0) {
        return  [self seeCount];
    }
    else  if ([arr containsObject:VideoID]) {
        return 10;
    }
    else{
        return  [self seeCount];
    }
}
+(BOOL)isCanComment{
    if ([self member_level]>0) {
        return  YES;
    }
    else  return NO;
}

+(void)disMisiMeViewWithMeType:(KKMemberUpdateType)type{
//    for (KKMemberUpgradeView *vie in [KKJurisdictionManager shareManager].viewArray) {
//        if (vie.Membertype == type) {
//            [vie removeFromSuperview];
//        }
//    }
    
}
#pragma mark ====获取会员登记 判断是否过期 过期 无会员返回0。其余正常返回 以及12点清0逻辑
+(NSInteger)member_level{
    
    long startTime = [[self getTime:0 andMinute:0] longLongValue];
    if (startTime == [AppTimeSysMgr getNowTimeStamp]) {
        [self clearData];
    }
    if ([KKUserInfo share].member_level>0) {
        
        if ([KKTool isPastDueByComparisonTimestamp:[KKUserInfo share].member_expiration_time]) {
            return 0;
        }
        else return [KKUserInfo share].member_level;
    }else{
        return 0;
    }
}
#pragma mark====当日0点清除数据
+(void)clearData{
    [self shareManager].seeArray  = [NSMutableArray array];
    [self shareManager].DownArray = [NSMutableArray array];
}
+(void)disMisiAllMeView{
    NSMutableArray *arr = [NSMutableArray array];
//    KKNowVCType type = [self getnowVcViewtype];
    for (KKMemberUpgradeView *vie in [KKJurisdictionManager shareManager].viewArray) {
        [vie removeFromSuperview];
//        if (vie.vcType == type) {
//
//            [arr addObject:vie];
//        }
    }
    [[KKJurisdictionManager shareManager].viewArray  removeAllObjects];
//    [[KKJurisdictionManager shareManager].viewArray removeObjectsInArray:arr];
}
+(KKNowVCType)getnowVcViewtype{
   
    return KKChatVCType;
    
}

+ (NSString *)getTime: (NSInteger)hour andMinute:(NSInteger)minute {
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [greCalendar setTimeZone: timeZone];

    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:[NSDate date]];
    //  定义一个NSDateComponents对象，设置一个时间点
    NSDateComponents *dateComponentsForDate = [[NSDateComponents alloc] init];
    [dateComponentsForDate setDay:dateComponents.day];
    [dateComponentsForDate setMonth:dateComponents.month];
    [dateComponentsForDate setYear:dateComponents.year];
    [dateComponentsForDate setHour:hour];
    [dateComponentsForDate setMinute:minute];

    NSDate *dateFromDateComponentsForDate = [greCalendar dateFromComponents:dateComponentsForDate];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[dateFromDateComponentsForDate timeIntervalSince1970]*1000];
    return timeSp;
}
+(void)clearInfo{
    if ([[self shareManager].seeArray count] >0) {
        [self shareManager].seeArray =  [NSMutableArray array]; 
//        [[self shareManager].seeArray removeAllObjects];
    }
    [self shareManager].DownArray = @[];
}

- (NSInteger)watchedCount{
    return [kUserDefaults integerForKey:@"seeCount"];
}
-(void)setWatchedCount:(NSInteger)watchedCount{
    [kUserDefaults setInteger:watchedCount forKey:@"seeCount"];
    [kUserDefaults synchronize];
}
-(NSInteger)downloadedCount{
    return [kUserDefaults integerForKey:@"downloadedCount"];
}
- (void)setDownloadedCount:(NSInteger)downloadedCount{
    [kUserDefaults setInteger:downloadedCount forKey:@"downloadedCount"];
    [kUserDefaults synchronize];
}
-(void)setSeeArray:(NSMutableArray *)seeArray{
    [kUserDefaults setValue:seeArray forKey:@"seeArray"];
    [kUserDefaults synchronize];
}
-(NSMutableArray *)seeArray{
    return [kUserDefaults objectForKey:@"seeArray"];
}
-(void)setDownArray:(NSArray *)DownArray{
    [kUserDefaults setValue:DownArray forKey:@"DownArray"];
    [kUserDefaults synchronize];
}
-(NSArray *)DownArray{
    return [kUserDefaults objectForKey:@"DownArray"];
}
-(NSMutableArray *)viewArray{
    if (!_viewArray) {
        _viewArray = [NSMutableArray array];
    }
    return _viewArray;
}
-(NSMutableArray *)seeViewArray{
    if (!_seeViewArray) {
        _seeViewArray = [NSMutableArray array];
    }
    return _seeViewArray;
}
@end
