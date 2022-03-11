//
//  KKActivityView.h
//  richers
//
//  Created by Gwynne on 2022/1/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface KKActivityView : UIView

@property (nonatomic,strong) NSDictionary * params;
@property (nonatomic,copy)void (^parmeToDataArrBlock)(BOOL isHidden);

@end

NS_ASSUME_NONNULL_END
