//
//  KKPubLishVideoDataDelegate.h
//  KK
//
//  Created by 小草 on 2021/8/6.
//

#import <Foundation/Foundation.h>
#import "KKUploadSuperModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol KKPubLishVideoDataDelegate <NSObject>


// 当前上传进度
-(void)currentUploadProgress:(CGFloat)progress uploadState:(KKUploadState)state isGetProgress:(BOOL)isGetProgress;

@end

NS_ASSUME_NONNULL_END
