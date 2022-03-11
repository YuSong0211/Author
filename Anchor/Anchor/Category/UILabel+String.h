//
//  UILabel+String.h
//  KK
//
//  Created by Gwynne on 2021/8/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (String)

/**
 设置文本,并指定行间距

 @param text 文本内容
 @param lineSpacing 行间距
 */
- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

@end

NS_ASSUME_NONNULL_END
