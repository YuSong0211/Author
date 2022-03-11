//
//  BaseModel.h
//  KK
//
//  Created by hk on 2021/8/2.
//
#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#import <Foundation/Foundation.h>
#import "NetWorkMgr.h"
 
NS_ASSUME_NONNULL_BEGIN
typedef void(^OnComplete)(id message);

typedef void(^OnBoolComplete)(BOOL isOk);

typedef void (^OnFailed)(NSInteger errorCode);
@interface BaseModel : NSObject
 
@end

NS_ASSUME_NONNULL_END
