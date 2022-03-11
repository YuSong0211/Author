//
//  KKAltStyleConfig.h
//  KK
//
//  Created by 小草 on 2021/9/1.
//

#import <Foundation/Foundation.h>
#import "KKAltItemConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKAltStyleConfig : NSObject

@property (nonatomic,strong) NSMutableArray<KKAltItemConfig*> * itemConfigArray; // 条目数组

@property (nonatomic,assign) BOOL isClickDismss; // 点击遮罩是否消失，默认点击不消失

@property (nonatomic,strong) NSString * backGroundColor; // 大背景的颜色，默认为黑色，16进制
@property (nonatomic,strong) UIColor * backGroundRGBColor; // 大背景的颜色，RGBA

@property (nonatomic,strong) NSString * viewBackgroundColor; // 当前显示控件的view ，默认为黑色，16进制
@property (nonatomic,strong) UIColor * viewBackgroundRGBColor; // 当前显示控件的view 大背景的颜色，RGBA

@property (nonatomic,assign) CGFloat cornerRadius; // 控件视图的圆角

@property (nonatomic,strong) NSString * title; // 标题
@property (nonatomic,strong) NSString * titleColor; // 标题颜色
@property (nonatomic,strong) NSString * content; // 内容
@property (nonatomic,strong) NSString * contentColor; // 内容颜色



/// 构造
/// @param title 标题
/// @param content 内容
+(KKAltStyleConfig*)initWithTitleAndContent:(NSString*)title content:(NSString*)content;



/// 设置是否可以点击
/// @param enable 是否可以点击
-(KKAltStyleConfig*)setViewEnable:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END
