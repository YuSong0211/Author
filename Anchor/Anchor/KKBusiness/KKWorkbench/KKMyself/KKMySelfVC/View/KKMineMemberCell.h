//
//  KKMineMemberCell.h
//  KK
//
//  Created by Gwynne on 2021/8/9.
//

#import <UIKit/UIKit.h>
#import "KKBaseTableViewCell.h"
#import "KKMySelfModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface KKMineMemberCell : KKBaseTableViewCell

@property (nonatomic,copy) void(^btnActionCallBack)(void);
@property (nonatomic,copy)KKMySelfModel *model;

-(void)reloadVIPData;

@end

NS_ASSUME_NONNULL_END
