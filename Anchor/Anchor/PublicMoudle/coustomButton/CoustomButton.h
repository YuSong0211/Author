//
//  CoustomButton.h
//  KK
//
//  Created by 小草 on 2021/6/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YcButtonStyleType) {
    YcButtonStyleTextUpImageBottomType,  // 文字在上，图片在下
    YcButtonStyleTextBottomImageTopType, // 文字在下，图片在上
    YcButtonStyleTextLeftImageRightType, // 文字在左，图片在右
    YcButtonStyleTextRightImageLeftType, // 文字在右，图片在左
    YcButtonStyleImageTextCenter,        // 图片与文字居中  图片在上
    YcButtonStyleImageTextAlentCenter,   // 图片与文字居中  图片在左
    YcButtonStyleOnlyText, // 只有文字
    YcButtonStyleOnlyImage // 只有图片
    
};

@interface  CoustomButton : UIButton
/**
 * TODO:  文字与图片之间的间隔，只有文字或者图片的时候设置无效
 */
@property (nonatomic,assign) CGFloat yc_controlMargin;

/**
 * TODO:  图片的大小，文字的大小
 */
@property (nonatomic,assign) CGSize yc_buttonimagesize;

/**
 * TODO: 设置当前Buttong的样式
 */
@property (nonatomic,assign) YcButtonStyleType yc_buttonStyle;

/**
 * TODO:  button文字
 */
@property (nonatomic,strong) NSString * yc_buttontitle;

/**
 * TODO: button字体
 */
@property (nonatomic,strong) UIFont * yc_titleFont;

/**
 * TODO: button文字颜色
 */
@property (nonatomic,strong) UIColor * yc_titleColor;

/**
 * TODO:  buttonImage名称
 */
@property (nonatomic,strong) NSString * yc_buttonImageName;

/**
 * TODO:  buttonImage名称--需要切换主题的调用这个
 */
@property (nonatomic,strong) NSString * yc_buttonImageNameChangeTheme;

/**
 * TODO:  buttonImageColor名称
 */
@property (nonatomic,strong) UIColor * yc_buttonImageColor;

/**
 * TODO:  buttonImagePath网络URl
 */
@property (nonatomic,strong) NSString * yc_buttonImagePath;

/**
 * TODO:  UIImage
 */
@property (nonatomic,strong) UIImage * yc_buttonImage;

/**
 * TODO:  是否出现加载
 */
@property (nonatomic,assign) BOOL isShowLoadingStyle;

/**
 * TODO:  圆角角度
 */
@property (nonatomic,assign) CGFloat cornerRadius;


// 将按钮复位到之前的样式
-(void)resetTheButton;

/**
 * TODO: 文字标签
 */
@property (nonatomic,strong) UILabel * buttonLab;

/**
 * TODO: 文字icon
 */
@property (nonatomic,strong) UIImageView * buttonIcon;

/**
 * TODO:  加载icon
 */
@property (nonatomic,strong) UIImageView * loadingImage;
-(void)setYc_buttonImageName:(NSString *)yc_buttonImageName WithImageColor:(UIColor*)imageColor withType:(NSString *)type; 
// 开始动画
-(void)startButtonAnimationWithImage:(NSString *)imageName;

// 消失动画
-(void)dismissAnimation;

@end

NS_ASSUME_NONNULL_END
