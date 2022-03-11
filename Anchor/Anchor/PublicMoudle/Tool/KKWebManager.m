//
//  KKWebManager.m
//  mt
//
//  Created by Gwynne on 2021/11/12.
//

#import "KKWebManager.h"


@implementation KKWebManager

/// 打开一个页面
/// @param paramDic js传的参数
+(void)openPageWithParams:(NSDictionary *)paramDic{
    if (paramDic != nil) {
        if ([paramDic objectForKey:@"objType"]) {
            if ([[paramDic objectForKey:@"objType"] isEqualToString:@"nativepage"]) {
                // 原生
                [self openNativePage:paramDic];
            }else if ([[paramDic objectForKey:@"objType"] isEqualToString:@"webviewpage"]){
                // webview
                [self openHybdPage:paramDic];
            }else if ([[paramDic objectForKey:@"objType"] isEqualToString:@"nativeweb"]){
                // 打开原生浏览器的协议，objType=nativeweb
                //  "webviewObj":"https://www.inke.com/"
                if ([paramDic objectForKey:@"webviewObj"]) {
                    [self goSystemSafari:[paramDic objectForKey:@"webviewObj"]];
                }
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
                [KKTool intoServerChat];
            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"userpage"]){
                // 打开用户主页
               
            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"svideo"]){
                // 打开二级视频列表
              
            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"invite"]){
                // 分享推广
              
            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"invitelog"]){
                // 分享推广记录
             
            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"social"]){
//                [self removeMessageHandle];
                // 分享社区
             
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
        
        // 悬浮小球是否显示充值按钮
        BOOL isShowPay = NO;
        if ([paramDic objectForKey:@"webviewEnableWallet"]) {
            if ([[paramDic objectForKey:@"webviewEnableWallet"] integerValue] == 1) {
                isShowPay = YES;
            }
        }
        
        // 是否横屏展示webview
        if ([paramDic objectForKey:@"webviewLandscape"]) {
            if ([[paramDic objectForKey:@"webviewLandscape"] integerValue] == 1) {
                CustomWebViewController * newWeb = [[CustomWebViewController alloc]initWithUrl:url title:title vcType:CustomWebViewHorizontalScreenFull];
                newWeb.isShowPay = isShowPay;
                [[KKTool getCurrentVC].navigationController pushViewController:newWeb animated:YES];
            }
        }else{
            CustomWebViewController * newWeb = [[CustomWebViewController alloc]initWithUrl:url title:title vcType:fullScreen==0?CustomWebViewNav:CustomWebViewFull];
            newWeb.isShowPay = isShowPay;
            [[KKTool getCurrentVC].navigationController pushViewController:newWeb animated:YES];
        }
    }
}

// 去系统浏览器
+(void)goSystemSafari:(NSString *)link{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link] options:@{} completionHandler:^(BOOL success) {
        if (success == YES) {
            NSLog(@"打开成功");
        }
    }];
}

@end
