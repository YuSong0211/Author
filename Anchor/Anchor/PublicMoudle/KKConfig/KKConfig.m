//
//  KKConfig.m
//  mt
//
//  Created by Gwynne on 2021/9/17.
//

#import "KKConfig.h"

@implementation KKConfig

+ (instancetype)share {
    static KKConfig *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

- (NSString *)imageCachePath {
    if (!_imageCachePath) {
        return [NSString stringWithFormat:@"%@/",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]];
    }
    return _imageCachePath;
}

- (void)clearImageInMemory {
    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.imageCachePath error:nil];
    for (NSString *fileName in array) {
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@",self.imageCachePath,fileName] error:nil];
    }
}

- (NSMutableArray *)unReadWorkOrderIdArray {
    if (!_unReadWorkOrderIdArray) {
        _unReadWorkOrderIdArray = [[NSMutableArray alloc] init];
    }
    return _unReadWorkOrderIdArray;
}

- (void)setServerConten:(NSString *)serverConten {
    [[NSUserDefaults standardUserDefaults] setObject:serverConten forKey:[NSString stringWithFormat:@"%@_serverConten",[KKUserInfo share].uid]];
    [[NSUserDefaults standardUserDefaults]  synchronize];
}

- (NSString *)serverConten {
    return [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@_serverConten",[KKUserInfo share].uid]];
}

- (void)setServerTime:(NSInteger)serverTime {
    [[NSUserDefaults standardUserDefaults] setInteger:serverTime forKey:[NSString stringWithFormat:@"%@_serverTime",[KKUserInfo share].uid]];
    [[NSUserDefaults standardUserDefaults]  synchronize];
}

- (NSInteger)serverTime {
    return [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"%@_serverTime",[KKUserInfo share].uid]];
}

- (BOOL)isHkIM {
    return NO;
}

- (CGFloat)safeBottomHeight {
    return self.isFullScreen ? 34 : 0;
}

- (NSData *)pingData {
    if (!_pingData) {
        char data [4] = {8,1,8,1};
        _pingData = [[NSData alloc] initWithBytes:data length:4];
    }
    return _pingData;
}

//- (BOOL)isLandscape {
//    //宽大于高就是横屏模式
//    return KK_SCREEN_WIDTH > KK_SCREEN_HEIGHT ? YES : NO;
//}

- (CGFloat)screenWidth {
    return self.isLandscape ? KK_SCREEN_HEIGHT : KK_SCREEN_WIDTH;
}

- (CGFloat)screenHeight {
    return self.isLandscape ? KK_SCREEN_WIDTH : KK_SCREEN_HEIGHT;
}

- (void)setSuspensionButtonX:(CGFloat)suspensionButtonX {
    [[NSUserDefaults standardUserDefaults] setFloat:suspensionButtonX forKey:[NSString stringWithFormat:@"MTKJSuspensionButtonX%@",@(self.isLandscape)]];
}

- (CGFloat)suspensionButtonX {
    if ([[NSUserDefaults standardUserDefaults] floatForKey:[NSString stringWithFormat:@"MTKJSuspensionButtonX%@",@(self.isLandscape)]] == 0) {
        return self.screenWidth - 55 - 30;
    }else {
        return [[NSUserDefaults standardUserDefaults] floatForKey:[NSString stringWithFormat:@"MTKJSuspensionButtonX%@",@(self.isLandscape)]];
    }
    
}

- (void)setSuspensionButtonY:(CGFloat)suspensionButtonY {
    [[NSUserDefaults standardUserDefaults] setFloat:suspensionButtonY forKey:[NSString stringWithFormat:@"MTKJSuspensionButtonY%@",@(self.isLandscape)]];
}

- (CGFloat)suspensionButtonY {
    if ([[NSUserDefaults standardUserDefaults] floatForKey:[NSString stringWithFormat:@"MTKJSuspensionButtonY%@",@(self.isLandscape)]] == 0) {
        return self.screenHeight - 55 - 55;
    }else {
        return [[NSUserDefaults standardUserDefaults] floatForKey:[NSString stringWithFormat:@"MTKJSuspensionButtonY%@",@(self.isLandscape)]];
    }
    
}

@end
