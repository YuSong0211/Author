//
//  NSString+Extension.h
//  Douyin
//
//  Created by Qiao Shi on 2018/7/30.
//  Copyright © 2018年 Qiao Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Extension)

- (CGSize)singleLineSizeWithAttributeText:(UIFont *)font;

- (CGSize)multiLineSizeWithAttributeText:(CGFloat)width font:(UIFont *)font;

- (CGSize)singleLineSizeWithText:(UIFont *)font;

- (NSString *)md5;

- (NSURL *)urlScheme:(NSString *)scheme;

+ (NSString *)formatCount:(NSInteger)count;

+(NSDictionary *)readJson2DicWithFileName:(NSString *)fileName;

+ (NSString *)currentTime;

// 获取文字行数
- (NSInteger)rowsOfStringWithFont:(UIFont *)font withWidth:(CGFloat)width;

- (CGSize)sizeWithFont:(UIFont *)font maxH:(CGFloat)maxH;

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

- (CGSize)sizeWithFont:(UIFont *)font;

// TODO: 获取当前时间戳
+(NSString*)getNowTimeTimestamp;

// 毫秒级
+(NSString *)getNowTimeTimestampMillisecond;
// 毫秒级(long)
+ (long)getLongNowTimeTimeStampMilliSecond;

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;


//转换字符串
+(NSString*)htmlEncode:(NSString*)source;
+ (long)getLongNowTimeTimeStampMilliSecondWithDate:(NSDate*)date;
+(NSString *)convertTimeToString:(long long int)time;


/// 将字符串指定文字变为高亮
/// @param text 原始字符串
/// @param highlightTextArray 要变高亮的文字数组
/// @param heightLightColor 高亮颜色
/// @param heightFont 高亮字体
+(NSMutableAttributedString *)setupAttributeString:(NSString *)text
                                highlightTextArray:(NSMutableArray *)highlightTextArray
                                       heightColor:(UIColor *)heightLightColor
                                   heightLightFont:(UIFont *)heightFont;

-(NSString *) convertFileSize:(long long)size;
@end
