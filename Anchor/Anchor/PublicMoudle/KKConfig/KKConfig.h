//
//  KKConfig.h
//  mt
//
//  Created by Gwynne on 2021/9/17.
//

#import <Foundation/Foundation.h>
#import "KKTabbarVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKConfig : NSObject

+ (instancetype)share;

///图片缓存主路径
@property (nonatomic,strong) NSString *imageCachePath;

///清除图片缓存
- (void)clearImageInMemory;

///是否是横屏
@property (nonatomic,assign) BOOL isLandscape;

///是否是全面屏设备
@property (nonatomic,assign) BOOL isFullScreen;

///真实的屏幕宽度
@property (nonatomic,assign) CGFloat screenWidth;

///真实的屏幕高度
@property (nonatomic,assign) CGFloat screenHeight;

@property (nonatomic,assign) CGFloat suspensionButtonX;

@property (nonatomic,assign) CGFloat suspensionButtonY;

@property (nonatomic,strong) NSMutableArray *unReadWorkOrderIdArray;

@property (nonatomic,strong) NSString *serverConten;

@property (nonatomic,assign) NSInteger serverTime;

@property (nonatomic,assign) NSInteger serverUnReadCount;

@property (nonatomic,strong) KKTabbarVC *mainTabbatViewController;

@property (nonatomic,assign) BOOL isHkIM;

@property (nonatomic,assign) CGFloat safeBottomHeight;

@property (nonatomic,strong) NSData *pingData;

@end

NS_ASSUME_NONNULL_END
