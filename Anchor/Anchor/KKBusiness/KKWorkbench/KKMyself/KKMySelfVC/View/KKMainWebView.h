//
//  KKMainWebView.h
//  mt
//
//  Created by 小草 on 2021/11/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KKMainWebViewDelegate <NSObject>


// weview跳转到其他页面了
-(void)pushSecondVC;

@end

@interface KKMainWebView : UIView

@property (nonatomic,strong) NSString * webViewUrl;

@property (nonatomic,assign) BOOL isShowView; // 如果外部只使用了webview，而不是webcontroller 则传YES ， KKMainWebView 内部跳转时会把当前webview移除

@property (nonatomic,weak) id<KKMainWebViewDelegate>delegate;


-(void)reloadWeb;

@end

NS_ASSUME_NONNULL_END
