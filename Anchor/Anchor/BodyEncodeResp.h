//
//  BodyEncodeResp.h
//  richers
//
//  Created by hk on 2021/9/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BodyEncodeResp : NSObject
@property(nonatomic,strong)NSString* encodeKey;
@property(nonatomic,strong)NSData* body;
@end

NS_ASSUME_NONNULL_END
