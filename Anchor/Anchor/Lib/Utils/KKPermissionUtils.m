//
//  KKPermissionUtils.m
//  richers
//
//  Created by grass on 2022/2/27.
//

#import "KKPermissionUtils.h"

@implementation KKPermissionUtils
    
+ (void)requestPhotoAuthorization:(void (^)(PHAuthorizationStatus))handler{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    handler(status);
                });
            }else{
                   //注，这里一定要回归的主线程操作UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    KKAltItemConfig* item = [KKAltItemConfig initWithItemConfig:@"取消" buttonEnable:YES];
                    KKAltItemConfig* item1 = [KKAltItemConfig initWithItemConfig:@"前去开启" buttonEnable:YES];
                    KKAltStyleConfig* controller = [[KKAltStyleConfig initWithTitleAndContent:[NSString stringWithFormat:@"权限提示"] content:@"相册权限未设置,请开启相册权限"] setViewEnable:NO];
                    [controller.itemConfigArray  addObject:item];
                    [controller.itemConfigArray  addObject:item1];
                    [KKAltView showAltViewWithConfigModel:controller WithClickBlock:^(NSInteger clickIndex) {
                        if(clickIndex == 1){
                            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                        }
                    }];
                    
                    handler(status);
                });
               
            }
        }];
}
@end
