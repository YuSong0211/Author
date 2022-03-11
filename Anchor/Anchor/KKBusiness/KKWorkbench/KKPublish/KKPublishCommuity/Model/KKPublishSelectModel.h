//
//  KKPublishSelectModel.h
//  mt
//
//  Created by 小草 on 2021/9/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, KKPublishSelectModelType) {
    KKPublishSelectModelSelectImageMidiaType, // 显示选择图片控件
    KKPublishSelectModelSelectVideoMidiaType, // 显示选择视频控件
    KKPublishSelectModelMediaImageType, // 显示图片数据
    KKPublishSelectModelMediaVideoType // 显示视频数据
};

@interface KKPublishSelectModel : NSObject

@property (nonatomic,assign) KKPublishSelectModelType selectType;

@property (nonatomic,strong) UIImage * image;

@property (nonatomic,assign) NSInteger imageIndex; // 图片下标

@property (nonatomic,strong) UIImage * videoImage;

@property (nonatomic,strong) NSString * videoPath;

@end

NS_ASSUME_NONNULL_END
