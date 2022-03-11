//
//  AppTimeSysMgr.m
//  KK
//
//  Created by hk on 2021/9/2.
//

#import "AppTimeSysMgr.h"
#import "KKPubTagVCModel.h"
#import "KKMySelfModel.h"
@interface AppTimeSysMgr()

@property(nonatomic,assign)long appStartDate;
@property(nonatomic,assign)long localDate;


@end


@implementation AppTimeSysMgr 
+ (AppTimeSysMgr *)shareMgr{
    
    static dispatch_once_t once;
    static AppTimeSysMgr *manager;
    dispatch_once(&once, ^{
        manager = [AppTimeSysMgr new];
    });
    return manager;
}


/// 初始化系统时间
/// @param date 系统时间
-(void)initSysTime:(NSString*)date{
    if (self.isInit) {
        return;
    }
    self.isInit = YES;
    date = [date substringFromIndex:5];
    date = [date substringToIndex:[date length]-4];
    NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
    dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
    NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
    self.appStartDate = [NSString getLongNowTimeTimeStampMilliSecondWithDate:netDate];
    self.localDate = [NSString getLongNowTimeTimeStampMilliSecond];
}
 
/// 获取系统当前时间
+(NSDate*)getNowTime{
    long timeSpan = [NSString getLongNowTimeTimeStampMilliSecond]; //获取当前时间戳
    long second = timeSpan - [AppTimeSysMgr shareMgr].localDate;
    second = second+[AppTimeSysMgr shareMgr].appStartDate;
    return [NSDate dateWithTimeIntervalSince1970:second/1000];
}


/// 获取当前时间戳
+(long)getNowTimeStamp{
    long timeSpan = [NSString getLongNowTimeTimeStampMilliSecond]; //获取当前时间戳
    long second = timeSpan - [AppTimeSysMgr shareMgr].localDate;
    return second+[AppTimeSysMgr shareMgr].appStartDate;
}

+ (NSTimeInterval)timeStrTestWithTime:(NSInteger)times WithtimeZone:(NSString*)timeZone{
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:times/1000];
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:timeZone];

    NSInteger delta = [zone secondsFromGMT];

    // 日历对象 （方便比较两个日期之间的差距）
       NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
       [dateFormatter  setTimeZone:zone];
       //设定时间格式,这里可以设置成自己需要的格式
       [dateFormatter setDateFormat:@"HH:mm:ss"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd  HH:mm:ss"];
    NSString *strHour = [dateFormatter stringFromDate:detaildate];
    int  hour = [self getSpan:detaildate :@"HH"];
    int  minmut = [self getSpan:detaildate :@"mm"];
    int  sencond = [self getSpan:detaildate :@"ss"];
    

    
    return 86400-(hour*60*60+minmut*60+sencond);
//       NSLog(@"%@",currentDateStr);
}
+(int)getSpan:(NSDate*)date:(NSString*)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strHour = [dateFormatter stringFromDate:date];
    return [strHour intValue];
}
+(NSDate *)getDateTimeFromMilliSeconds:(long long) miliSeconds

{

NSTimeInterval tempMilli = miliSeconds;

NSTimeInterval seconds = tempMilli/1000.0;//这里的.0一定要加上，不然除下来的数据会被截断导致时间不一致

NSLog(@"传入的时间戳=%f",seconds);

return [NSDate dateWithTimeIntervalSince1970:seconds];

}
+(long long)timeSamp:(NSDate*)date{
    NSTimeInterval millisecond = [[NSDate date] timeIntervalSince1970] ;
    return millisecond;
}


+(void)gcdTimeReloadWithTime:(NSTimeInterval)times WithtimeZone:(NSString*)timeZone{
    
    NSTimeInterval time = [self timeStrTestWithTime:times WithtimeZone:timeZone];
    

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [[NSNotificationCenter defaultCenter] postNotification:noti];
//    });
    [self startGcdwithtime:time];
}
+(void)startGcdwithtime:(NSTimeInterval)time{
//    time = 30;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadView];
        [self  initGcdReloadTime];
    });
}
+(void)initGcdReloadTime{
  //  return;
    serviceapplinkLinkPassportApicheckLastedCheckLastedRequest *request = [serviceapplinkLinkPassportApicheckLastedCheckLastedRequest createRequest];
    int c = [richers getIosPackageType];
    c+=2;
    request.request.clientType = c;
    request.request.version = KKappVersionCode;
    request.request.grayscale = [KKUserInfo share].grayscale;
    //serviceapplinkCheckVersionResponse
    
     [[NetWorkMgr createMgrWithMessage:request] sendRequest:^(serviceapplinkCheckLastedResponse*   message) {

//         [KKUserInfo share].timestampMills =message.time.timestampMills;
//         [KKUserInfo share].starTimeMills = [[KKTool getNowTimeTimestamp3] integerValue];
//         [KKUserInfo share].timeZone = message.time.timezone;
         [self gcdTimeReloadWithTime:message.time.timestampMills WithtimeZone:message.time.timezone];
    } failed:^(requestErrorCode errorCode) {

        }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(90 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self initGcdReloadTime];
//    });
//    [[KKPubTagVCModel shareToolGetManager]gettimeConfig:^(uint64_t timestampMills, NSString *timezone) {
//        [KKUserInfo share].timestampMills = timestampMills;
//        [self gcdTimeReloadWithTime:timestampMills WithtimeZone:timezone];
//    }];
}

+(void)reloadMySelgUserInfo{
   [KKMySelfModel ZeroPointReqRefehUserBaseInfo:^(appvapiUserInfoBasic  *_Nonnull message) { 
        } :^(requestErrorCode errorCode) {
    }];
}

+(void)onResume:(long)timeSpan{
 
//    long offset = timeSpan -[self.localDate timeIntervalSince1970]; //间隔时间
    NSDate* cacheDay = [NSDate dateWithTimeIntervalSince1970: [KKUserInfo share].timestampMills];
    NSDate* data = [NSDate dateWithTimeIntervalSince1970:timeSpan];
    
    int v1 = [self getSpan:cacheDay :@"yyyyMMdd"];
    int v2 = [self getSpan:data :@"yyyyMMdd"];
    if(v2!=v1){
        [self reloadView];
        //刷新数据去
    }
//    int second = [self getRefreshData:data];
    //定时的时间
}
+(void)reloadDta{
//    [[KKPubTagVCModel shareToolGetManager]gettimeConfig:^(uint64_t timestampMills, NSString *timezone) {
//        [KKUserInfo share].timestampMills = timestampMills;
//        [self onResume:timestampMills];
//    }];
    
    serviceapplinkLinkPassportApicheckLastedCheckLastedRequest *request = [serviceapplinkLinkPassportApicheckLastedCheckLastedRequest createRequest];
    int c = [richers getIosPackageType];
    c+=2;
    request.request.clientType = c;
    request.request.version = KKappVersionCode;
    request.request.grayscale = [KKUserInfo share].grayscale;
    //serviceapplinkCheckVersionResponse
    
     [[NetWorkMgr createMgrWithMessage:request] sendRequest:^(serviceapplinkCheckLastedResponse*   message) {

         [KKUserInfo share].timestampMills =message.time.timestampMills-[[KKTool getNowTimeTimestamp3] integerValue];

    } failed:^(requestErrorCode errorCode) {

        }];
    
}

+(void)reloadView{
    [self reloadMySelgUserInfo];
    NSNotification *noti = [NSNotification notificationWithName:@"SHORTVIDEORELOAD" object:nil];

    [[NSNotificationCenter defaultCenter] postNotification:noti];
}
@end
