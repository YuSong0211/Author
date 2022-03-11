//
//  NativeCallback.h
//  richers
//
//  Created by hk on 2021/12/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum {
    NATIVE_DOWNLOAD_FILE,
    NATIVE_DOWNLOAD_FAIL,
    NATIVE_TIMEDOMAIN_SUCCESS
    
}NativeEventType;

//监听回调
@protocol NativeListener <NSObject>

@optional
     
-(NSString*)callNative:(NativeEventType)type:(NSString*)content;

@end


@interface NativeCallback : NSObject

@end

NS_ASSUME_NONNULL_END
