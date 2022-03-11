//
//  KKShareCodeModel.h
//  mt
//
//  Created by ProgramMa on 2021/10/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^sendShareCode)(BOOL isSucess,NSInteger errorCode);

typedef void(^getShareCode)(NSString *shareCode);
@interface KKShareCodeModel : NSObject

-(void)getShareCode:(getShareCode)Block;

@property (nonatomic,strong)NSString *shareCode;

-(void)sendShareCode:(NSString *)shareCode withBlock:(sendShareCode)block;
@end

NS_ASSUME_NONNULL_END
