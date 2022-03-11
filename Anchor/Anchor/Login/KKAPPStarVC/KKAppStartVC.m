//
//  KKAppStartVC.m
//  KK
//
//  Created by 小鱼 on 2021/8/5.
//

#import "KKAppStartVC.h"
#import "KKTabbarVC.h"
#import "SignController.h"
#import "NetWrokStatesCtrl.h"
#import "AppVersionMgr.h"
#import "KKTabbarVC.h"
#import "NetWrokStatesCtrl.h"

#import <AVFoundation/AVFoundation.h>
//#import <KTVHTTPCache/KTVHTTPCache.h>
#import "KTVHTTPCache.h"
// 登录管理
#import "KKAdModel.h"
#import <WebKit/WebKit.h>
#import "SupportedInterfaceOrientations.h"
#import "httpcheck.h"
#import "AppTimeSysMgr.h"
#import "NativeCallback.h"
//#import "richers.h"
@interface KKAppStartVC ()<RichersNativeCallBack,NativeListener>
@property (nonatomic,strong)SignController* signController;
//是否登陆中。
@property(nonatomic,assign) BOOL isSigning;
@property (nonatomic, strong)NSString *netState;
@property (nonatomic, assign)BOOL isFirst;
@property (nonatomic, assign) NSInteger loadNum;
@end

@implementation KKAppStartVC

- (void)viewDidLoad {
    [super viewDidLoad];

    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"firstApp"]) {
        self.loadNum = 0;
        [self networkState];
    }
    [KKUserInfo share].deviceIPAdress =  [KKTool deviceIPAdress];
    [self initApp];
    [self setUPView];
    [self removeWebViewCache];
//    [KKTool deviceIPAdress];
    // Do any additional setup after loading the view.
}
- (void)networkState{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstApp"];
    CTCellularData *cellularData = [[CTCellularData alloc]init];
    cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state){
        BOOL _isRestricted =YES;
        //获取联网状态
        self.loadNum ++;
        switch(state) {
            case kCTCellularDataRestricted:{
                NSLog(@"Restricted");//拒绝
                if ( self.loadNum ==2) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [KKAltView dismiss];
                    });
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self checkItem];;
                    });
                }
                
                break;
            } 
            case kCTCellularDataNotRestricted:{
                _isRestricted =NO;
                if ( self.loadNum ==2) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [KKAltView dismiss];
                    });
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self checkItem];;
                    
                });
                }
                NSLog(@"Not Restricted");//允许
            }
                break;
            case kCTCellularDataRestrictedStateUnknown:
                NSLog(@"Unknown");//未知
                break;
            default:
                break;
        };
        if(_isRestricted ==YES) {
            [KKUserInfo share].netState=@"需开启";
        }else{
            [KKUserInfo share].netState=@"无需开启";
        }
    };
    
}

-(void)removeWebViewCache{
    
   
    
    NSString *timeStr =[[NSUserDefaults standardUserDefaults] objectForKey:@"ClearWebCahcetime"];
    NSInteger timeValue =[AppTimeSysMgr  getNowTimeStamp];
    NSString *nowTimeStr =   [NSString stringWithFormat:@"%ld",(long)timeValue];
    
    if (timeStr) {
        BOOL houtime = [self getHour:nowTimeStr   systemTime: timeStr];
        if (houtime) {
            [[NSUserDefaults standardUserDefaults] setObject:nowTimeStr forKey:@"ClearWebCahcetime"];
            ///清除缓存
            NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
            /// Date from
            NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
            /// Execute
            [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
                // Done
                NSLog(@"清除缓存完毕");
            }];
        }
    }
    else{
        ///清除缓存
        [[NSUserDefaults standardUserDefaults] setObject:nowTimeStr forKey:@"ClearWebCahcetime"];
    }
    
}
+(void)removeWebCache{
    ///清除缓存
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    /// Date from
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    /// Execute
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        // Done
        NSLog(@"清除缓存完毕");
    }];
}
- (NSUInteger )getHour:(NSString *)takeCarTime systemTime:(NSString *)systemTime

{
    //  时区相差8个小时 加上这个时区即是北京时间
    
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    
    NSInteger delta = [timeZone secondsFromGMT];
    
    // 两个时间戳转换日期类
    
    // [takeCarTime doubleValue]/1000 这里除以1000 我们后台传来的时间戳有问题
    
    NSDate  *DRstartDate = [[NSDate alloc] initWithTimeIntervalSince1970:[takeCarTime doubleValue]/1000 + delta];
    
    NSDate *DRendDate = [[NSDate alloc] initWithTimeIntervalSince1970:[systemTime doubleValue]/1000 + delta];
    
    // 日历对象 （方便比较两个日期之间的差距）
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // NSCalendarUnit 枚举代表想获得哪些差值 NSCalendarUnitYear 年 NSCalendarUnitWeekOfMonth 月
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitWeekOfMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *cmps = [calendar components:unit fromDate:DRendDate toDate:DRstartDate options:0];
    
    // 获得某个时间的年月日时分秒
    
    //        NSDateComponents *createDateCmps = [calendar components:unit fromDate:DRstartDate];
    
    //        NSDateComponents *nowCmps = [calendar components:unit fromDate:DRendDate];
    
    NSLog(@"剩余%ld天,%ld小时%ld分", cmps.day ,cmps.hour, cmps.minute);
    
    NSLog(@"相差%ld小时",cmps.hour);
    if (cmps.day>=1) {
        return YES;
    }
    return NO;
    
}

- (BOOL)isSameDay:(NSString *)takeCarTime systemTime:(NSString *)systemTime
{
    NSDate  *date1 = [[NSDate alloc] initWithTimeIntervalSince1970:[takeCarTime doubleValue]/1000];

    NSDate *date2 = [[NSDate alloc] initWithTimeIntervalSince1970:[systemTime doubleValue]/1000];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];

    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];

}
-(BOOL)checkDomain:(NSString*)url{
    httpcheck *check = [[httpcheck alloc] init];
    return  [check check:url];
}

-(NSString*)callNative:(NativeEventType)type:(NSString*)content{
    if (type == NATIVE_DOWNLOAD_FAIL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [KKHub showMtTostWithTitle:@"登陆" WithText:[NSString stringWithFormat:@"检测失败"] WithBtnText:@"重试" WithClickBlock:^(NSInteger index) {
       
                [[richers defaultRichers] runTimeDomain];

            }];
        });
        
    }
    
    return @"";
}
-(void)initApp{
    [richers initNative:KKDocumentsPath];
    
    [richers setApp:APP_DEV debugNetUrl:@"" encodeBody:NO];
   
//    [richers setApp:APP_TEST debugNetUrl:@"192.168.31.192" encodeBody:NO];
    [richers defaultRichers].delegate = self;
    [[DomainMgr getDomainInstance] initConfig];
    // 监听网络变化
    [[NetWrokStatesCtrl getInstance] initCtrl];

}
 
//基础设置方法
- (void)infrastructureMethod {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance]setActive:YES error:nil];
}

-(void)setUPView{
    self.view.backgroundColor = [UIColor blackColor];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"appIcon"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
    }];
    //登陆回调监听。
    self.signController = [[SignController alloc] init];
    [self.signController.loginSignilCallBack subscribeNext:^(id  _Nullable x) {
        [self willLoginOk];
    }];
     
    [self checkItem];
}
-(void)checkItem{
    
     //如果网络可用，直接登陆.
     //暂时不做值判断。
     AppVersionMgr* verMgr = [AppVersionMgr shareMgr];
     [verMgr start:^(BOOL isOk) {
         if (isOk) {
 //            [[AppLinkDomainMgr shareMgr] checkItem:Ocdomain_uc complete:^(BOOL isUcOk) {
 //                if(isUcOk){
                     [[AppLinkDomainMgr shareMgr] checkItem:Ocdomain_api complete:^(BOOL isApiOk) {
                         if(isApiOk){
 //                            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStateChange:) name:@"NetWorkChangenotification" object:nil];
 //                              [self reqLogin];
                             [[AppLinkDomainMgr shareMgr] checkItem:Ocdomain_im complete:^(BOOL isAppVLink) {
                                 if(isAppVLink){
                                     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStateChange:) name:@"NetWorkChangenotification" object:nil];
                                     [self reqLogin];
                                 }
                             }];

                         }
                     }];
 //                }
 //            }];
             
 //            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStateChange:) name:@"NetWorkChangenotification" object:nil];
 //            [self reqLogin];
         }
     }];
}
//真正请求登陆
-(void)reqLogin{
    if(self.isSigning){
        NSLog(@"正在登陆中!");
        return;
    }
    
    if (![[NetWrokStatesCtrl getInstance] networkIsAvailable]) {
        
        WS
        [KKHub showMtTostWithTitle:@"登陆" WithText:[NSString stringWithFormat:@"网络无连接,请检查网络是否正常"] WithBtnText:@"重试" WithClickBlock:^(NSInteger index) {
            SS
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self reqLogin];
            });

        }];
        return;
    }
    else{
        [self.signController sign];
    }
}

//网络状态变化请求.
-(void)netWorkStateChange:(NSNotification *)noti{
    [self reqLogin];
}

//所有信息处理成功，可以正常进入app0
-(void)willLoginOk{
    self.isSigning = YES;
    [self setRootVC];
}
-(void)setRootVC{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    KKTabbarVC * tabBarController = [[KKTabbarVC alloc]init];
    window.rootViewController = tabBarController;
    [window makeKeyAndVisible];

}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

