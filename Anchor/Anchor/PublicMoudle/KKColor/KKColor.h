//
//  KKCollor.h
//  mt
//
//  Created by 小鱼 on 2021/9/18.
//

#import <Foundation/Foundation.h>
typedef enum kkColorType{
    appBgColor = 1,///app背景色
    appMainTextColor,///app主文字颜色
    appHintTextColor,///app辅文字颜色
    appTextBgColor,///app提示框背景色
    appEditTextBgColor,///app输入框背景色
    appMainCardBgColor,///重点菜单条目底色（我的页面分享，vip卡片）
    appTabUnActiveColor,///最底部tab栏未激活状态文字颜色
    appTabActiveColor,///最底部tab栏激活状态文字颜色
    appTabBgColor,///最底部tab栏背景色
    colorPrimary,///app主题色
    colorPrimaryDark,//app主题色（深）
    colorAccent,///app强调色
    colorMainBtnText,///主按钮文字颜色
    colorSecondBtnText,///辅按钮文字颜色
    colorSecondBtnBg,///辅按钮背景颜色
    colorPlayerSeekBarProgress,///播放器进度条进度颜色
    colorPlayerSeekBarBg,///播放器进度条背景颜色
    colorLoadingLeft,///Loading小球（左）
    colorLoadingRight,///"Loading小球（右
    colorChatLeftBg,///聊天气泡背景left
    colorChatRightBg,///聊天气泡背景right
    colorChatLeftText,///聊天气泡文字颜色left
    colorChatRightText,///聊天气泡文字颜色right
    colorChatTextBtn,///聊天文字按钮颜色
    colorVideoRankBtnSelectedBg,///短视频下二级tab激活状态背景
    colorVideoRankBtnSelectedText,///短视频下二级tab激活文字颜色
    colorVideoRankBtnUnSelectedText,///短视频下二级tab未激活文字颜色
    colorVideoTabBg,///短视频下二级tab背景
    colorVideoTabSelectedText,///短视频下一级tab文字颜色选中
    colorVideoTabUnSelectedText,///短视频下一级tab文字颜色未选中
    colorTextBtn, ///全局文字按钮（评论里的发表）的文字颜色
    colorTextSilver,///等级相关颜色（白银
    colorTextGold,///等级相关颜色（黄金）
    colorDialogBg,///弹框背景色
    colorDialogBtnBg,
    memberalerAlertBgColor,///会员弹框里背景颜色
    memberalertAlertTitleColor,///会员弹框里标题颜色
    memberalertAlertTextColor,///会员弹框文本内容颜色
    memberalertAlertExtensionColor,///会员弹框推广按钮浅色
    memberalertAlertExtensionDarkColor,///会员弹框推广按钮深色
    memberalertAlertBuyColor,///会员弹框购买按钮浅色
    memberalertAlertBuyDarkColor ///会员弹框购买按钮深色

}kkColerType;
NS_ASSUME_NONNULL_BEGIN

@interface KKColor : NSObject
+(UIColor*)getColor:(kkColerType)colorType;

+ (NSString *)hexadecimalFromUIColor: (UIColor*)color;


/// 16进制颜色转UIcolor
/// @param colorStr 16进制颜色字符
+(UIColor *)colorWithstr:(NSString *)colorStr;

@end
 
NS_ASSUME_NONNULL_END

