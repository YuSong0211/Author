//
//  KKADAlertView.h
//  mt
//
//  Created by 小鱼 on 2021/10/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKADAlertView : UIView
-(void)loadRequestWithArray:(NSArray *)urlArray withIndex:(NSInteger)index;

@property (nonatomic,copy) void(^openNewPage) (NSInteger nowIndex);
@end

NS_ASSUME_NONNULL_END
