//
//  AlpVideoSliderTimeClip.h
//  KK
//
//  Created by ProgramMa on 2021/7/14.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface AlpVideoSliderTimeClip : NSObject


/// 根据视频进度处理当前取帧位置
/// @param currentValue 当前进度
/// @param totalTime 总进度
/// @param timeScale ..
+(CGFloat)conversionTheTimeValue:(CGFloat)currentValue totalTime:(CGFloat)totalTime thumbWidth:(CGFloat)thumbWidth timeScale:(NSInteger)timeScale;


/// 根据时间点 截取视频的某一精确帧
/// @param videoTime CMTime 视频的时间结构体
/// @param videoPath 视频路径
+(UIImage *)timeClipVideoImage:(CMTime)videoTime videoPath:(NSURL *)videoPath;

@end

NS_ASSUME_NONNULL_END
