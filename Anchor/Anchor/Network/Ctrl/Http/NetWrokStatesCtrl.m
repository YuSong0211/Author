//
//  NetWrokStatesCtrl.m
//  KK
//
//  Created by hk on 2021/8/6.
//

#import "NetWrokStatesCtrl.h"
#import <netinet/in.h>
#import <ifaddrs.h>
#import <net/if.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#define MDNS_PORT       5353
#define QUERY_NAME      "_apple-mobdev2._tcp.local"
#define DUMMY_MAC_ADDR  @"02:00:00:00:00:00"
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
static NetWrokStatesCtrl* instance;

@implementation NetWrokStatesCtrl

+ (NetWrokStatesCtrl *)getInstance{
    if(instance == NULL){
        instance = [[NetWrokStatesCtrl alloc] init];
    }
    return instance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
 
    }
    return self;
}

//初始化数据
-(void)initCtrl{
    self.KKNetWorkState = KKNetUnknown;
    [self monitorNetworkStatus];
}

//检测网络是否可用
- (BOOL)networkIsAvailable{
    return self.KKNetWorkState>0?true:false;
}

//检测网络是否真正可用
-(BOOL)isRealyNetAvailable{
    NSString *urlString = @"https://www.baidu.com";
    NSURL *url = [NSURL URLWithString:urlString];
    NSError* error;
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    return error == nil?true:false;
}


//网络状态，发生变化时操作
- (void)monitorNetworkStatus {
    NSNotificationCenter *netWorkCenter = [NSNotificationCenter defaultCenter];
    __block NSNotification *notification;
    self.KKNetWorkState =(int)[[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                self.KKNetWorkState = KKNetUnknown;
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
//                [SVProgressHUD showMessage:@"网络不给力"];
                self.KKNetWorkState = KKNetLose;
                [[[UIApplication sharedApplication].delegate window] makeToast:@"  网络无连接,请检查网络是否正常  " duration:1 position:CSToastPositionCenter];
                //                [SVProgressHUD showErrorWithStatus:@"无网络请检查网络设置"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.KKNetWorkState = KKNetPhone;
                NSLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.KKNetWorkState = KKNetWIFI;
                NSLog(@"WIFI");
                break;
        }
        self.KKNetWorkState = [self isRealyNetAvailable]? self.KKNetWorkState:KKNetLose;
        notification = [NSNotification notificationWithName:@"NetWorkChangenotification"object:nil userInfo:@{@"key":[NSNumber numberWithInteger:self.KKNetWorkState]}];
        [netWorkCenter postNotification:notification];
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

 

@end
