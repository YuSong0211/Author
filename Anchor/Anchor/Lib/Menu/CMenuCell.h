//
//  CMenuCell.h
//  KK
//
//  Created by hk on 2021/6/24.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"
#import "ISysEventCommon.h"
NS_ASSUME_NONNULL_BEGIN

@interface CMenuCell : UITableViewCell

    
-(void)setData :(MenuItem*)data;

//数据集合
@property(strong,nonatomic) MenuItem* celldata;

//回调函数
@property (assign,nonatomic) id<IOnClickEvent> delegate;

@end

NS_ASSUME_NONNULL_END
