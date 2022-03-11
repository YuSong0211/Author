//
//  BaseBean.h
//  KK
//
//  Created by hk on 2021/8/17.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseBean : BaseModel
        

/// 加载数据
/// @param complete <#complete description#>
-(void)loadData:(OnComplete)complete;

@end

NS_ASSUME_NONNULL_END
