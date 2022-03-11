//
//  IComplete.h
//  KK
//
//  Created by hk on 2021/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//公共完成事件
@protocol ICompleteEvent <NSObject>
    
@optional
-(void)Complete;

@end

@interface IComplete : NSObject

@end

NS_ASSUME_NONNULL_END
