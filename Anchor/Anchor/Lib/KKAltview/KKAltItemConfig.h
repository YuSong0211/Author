//
//  KKAltItemConfig.h
//  KK
//
//  Created by 小草 on 2021/9/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum {
    
    KKAltItemStateCancle,
    KKAltItemStateOk,
    
}KKAltItemState;

@interface KKAltItemConfig : NSObject

@property (nonatomic,strong) NSString * buttonName; // 按钮标题

@property (nonatomic,assign) BOOL buttonEnable; // 默认可以点击，传NO不可点击

@property (nonatomic,strong) NSString * buttonTextColor; // 按钮文字的颜色

@property (nonatomic,assign) CGFloat cornerRadius; // 按钮圆角

@property (nonatomic,strong) NSString * buttonBackGroundColor; // 按钮背景的颜色

// 普通弹窗
+(KKAltItemConfig*)initWithItemConfig:(NSString*)buttonName buttonEnable:(BOOL)buttonEnable;

// 自定义弹窗
+(KKAltItemConfig*)initWithCoustomViewItemConfig:(NSString*)buttonName buttonBackGroundColor:(NSString *)buttonBackGroundColor buttonEnable:(BOOL)buttonEnable;

@end

NS_ASSUME_NONNULL_END
