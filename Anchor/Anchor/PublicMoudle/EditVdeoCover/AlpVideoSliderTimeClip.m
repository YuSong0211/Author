//
//  AlpVideoSliderTimeClip.m
//  KK
//
//  Created by ProgramMa on 2021/7/14.
//

#import "AlpVideoSliderTimeClip.h"

@implementation AlpVideoSliderTimeClip

/*
 // 以中间为分界点
 // 先判断当前进度在左边还是在右边
 // 如果在中间以左，取时间点的时候 就从滑块的左边线条开始
 // 如果在中间以右，取时间点的时候 就从滑块的右边线条开始
 */
+(CGFloat)conversionTheTimeValue:(CGFloat)currentValue totalTime:(CGFloat)totalTime thumbWidth:(CGFloat)thumbWidth timeScale:(NSInteger)timeScale{
    
    CGFloat changeProgress = 0;
    // 以中间为分界点，视频的中间时间
    CGFloat timeMiddle = totalTime / 2.f;
    if (currentValue > timeMiddle) { // 在右边
        // 计算每个像素 等于多少时间
        CGFloat timeMargin = totalTime / (KK_SCREEN_WIDTH - 30);
        // 滑块中间的位置
        CGFloat thumbMiddle = thumbWidth / 2.f;
        // 计算返回时间点
        // thumbMiddle * timeMargin 代表一个滑块需要的总时间
        changeProgress = currentValue + (thumbMiddle * timeMargin);
        // 为了取到最后一帧所写的,关掉之后,就取最后一秒的第一帧
        if (totalTime - changeProgress < (thumbWidth * timeMargin)) {
            changeProgress = totalTime - timeScale;
        }
    }else{ // 在左边
        changeProgress = currentValue;
    }
    return changeProgress;
}

/// 根据时间点 截取视频的某一精确帧
/// @param videoTime CMTime 视频的时间结构体
/// @param videoPath 视频路径
+(UIImage *)timeClipVideoImage:(CMTime)videoTime videoPath:(NSURL *)videoPath{
    //截取几张图片放在底部用作展示，我是用collectionview做展示
    //AVURLAsset * asset = [AVURLAsset assetWithURL:videoUrl];
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoPath options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.requestedTimeToleranceAfter = kCMTimeZero;
    generator.requestedTimeToleranceBefore = kCMTimeZero;
    //总帧数/展示的总数量
    //long long baseCount = time.value / 1;
    NSError *error = nil;
    //每隔baseCount帧取一帧存起来,一共PHOTP_COUNT张
    CGImageRef img = [generator copyCGImageAtTime:videoTime actualTime:NULL error:&error];
    {
        UIImage *image = [UIImage imageWithCGImage:img];
        
        if (image.hasAlphaChannel) {
            NSLog(@"有透明通道");
        }else{
            NSLog(@"没有透明通道");
        }
        // 释放CGImage
        CGImageRelease(img);
        return image;
    }
}

@end
