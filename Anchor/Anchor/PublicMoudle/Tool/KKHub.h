//
//  KKHub.h
//  KK
//
//  Created by 小鱼 on 2021/8/9.
//

#import <Foundation/Foundation.h>
@class allertView;
NS_ASSUME_NONNULL_BEGIN
typedef void(^alertBtnAction)(NSInteger index);
@interface KKHub : NSObject
+(void)showMtTostWithTitle:(NSString *)title WithText:(NSString *)text WithBtnText:(NSString *)btnText WithClickBlock:(alertBtnAction)alertBlock;
@end

@interface KKAllertView :UIView
@property (nonatomic, copy) alertBtnAction aletBlock;
@end
NS_ASSUME_NONNULL_END
