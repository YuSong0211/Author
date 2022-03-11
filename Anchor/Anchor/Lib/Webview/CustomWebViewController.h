//
//  CustomWebViewController.h
//
//
//  Created by 小草 on 2019/3/18.
//  Copyright © 2019年 小草. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKSecondBaseVC.h"

typedef NS_ENUM(NSUInteger, CustomWebViewType) {
    CustomWebViewFull, // 全屏不带导航，有悬浮小球
    CustomWebViewHorizontalScreenFull, // 横屏不带导航，有悬浮小球的
    CustomWebViewNav // 全屏带导航没有悬浮小球，点击返回，先逐级返回H5，在popVC
};

@interface CustomWebViewController : KKSecondBaseVC

@property (nonatomic,assign) BOOL isCustomeColor; // 是否是自定义颜色


@property (nonatomic, assign) BOOL isFirstFrom;
// 链接，（即将弃用）
@property (nonatomic, strong) NSString *url;

@property (nonatomic, assign) BOOL isShowPay; // 悬浮小球是否显示

/// 重写本类init方法
/// @param webURL webView链接
/// @param vcType 控制器类型
-(instancetype)initWithUrl:(NSString *)webURL
                     title:(NSString *)title vcType:(CustomWebViewType)vcType;


-(instancetype)initWithActiveUrl:(NSString *)webURL
                     title:(NSString *)title vcType:(CustomWebViewType)vcType;

/// 加载webview页面
/// @param webUrl webview链接
- (void)loadRequest:(NSString *)webUrl;


@end
