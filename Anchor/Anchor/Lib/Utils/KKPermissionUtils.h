//
//  KKPermissionUtils.h
//  richers
//
//  Created by grass on 2022/2/27.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN

@interface KKPermissionUtils : NSObject

+(void)requestPhotoAuthorization:(void(^)(PHAuthorizationStatus status))handler;

@end

NS_ASSUME_NONNULL_END
