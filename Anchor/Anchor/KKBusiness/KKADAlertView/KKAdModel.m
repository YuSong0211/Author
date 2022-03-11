//
//  KKAdModel.m
//  mt
//
//  Created by 小鱼 on 2021/10/12.
//

#import "KKAdModel.h"

@implementation KKAdModel
static KKAdModel *_info = nil;
static dispatch_once_t onceToken;

+ (KKAdModel *)share {
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
-(NSMutableArray<serviceapplinkAdvertisement *> *)advertisementArray{
    if (!_advertisementArray) {
        _advertisementArray = [NSMutableArray array];
    }
    return _advertisementArray;
}
/// js传的参数
+(void)openPageWithParams:(NSDictionary *)paramDic{
    if (paramDic != nil) {
        if ([paramDic objectForKey:@"objType"]) {
            if ([[paramDic objectForKey:@"objType"] isEqualToString:@"nativepage"]) {
                // 原生
                [self openNativePage:paramDic];
            }else if ([[paramDic objectForKey:@"objType"] isEqualToString:@"webviewpage"]){
                // webview
                [self openHybdPage:paramDic];
            }
        }
    }
}

    /// 打开一个原生页面
    /// @param paramDic 参数
+(void)openNativePage:(NSDictionary *)paramDic{
    if (paramDic != nil) {
        if ([paramDic objectForKey:@"nativeObj"]) {
            if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"kf"]) {
                    // 打开客服页面

            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"userpage"]){
                    // 打开用户主页
//                KKOtherVideoMainPageVC * otherVc = [[KKOtherVideoMainPageVC alloc]init];
//                otherVc.userInfo = nil;
//                [self.navigationController pushViewController:otherVc animated:YES];
            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"svideo"]){
                    // 打开二级视频列表
    //                KKDownVideoVC * twoLevelVideoVC = [[KKDownVideoVC alloc]init];
    //                [self.navigationController pushViewController:twoLevelVideoVC animated:YES];
                }
            }
        }
    }

    /// 打开一个webview页面
    /// @param paramDic 参数
+(void)openHybdPage:(NSDictionary *)paramDic{
        if (paramDic != nil) {
            NSInteger fullScreen = [[paramDic objectForKey:@"webviewFullScreen"] intValue];
            NSString * url = [paramDic objectForKey:@"webviewObj"];
            NSString * title = [paramDic objectForKey:@"webviewTitle"];
            CustomWebViewController * newWeb = [[CustomWebViewController alloc]initWithUrl:url title:title vcType:fullScreen==0?CustomWebViewNav:CustomWebViewFull];
            UIViewController *vc = [KKTool getCurrentVC];
            [vc.navigationController pushViewController:newWeb animated:YES];
        }
    }

@end
