//
//  ISysEventCommon.h
//  KK
//
//  Created by hk on 2021/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol IOnClickEvent <NSObject>

@optional
-(void)onClick :(int) index;
-(void)onLongClick :(int)index;
@end
@interface ISysEventCommon : NSObject

@end

NS_ASSUME_NONNULL_END
