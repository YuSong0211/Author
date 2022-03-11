//
//  MenuItemCell.h
//  KK
//
//  Created by hk on 2021/6/24.
//

#import <Foundation/Foundation.h>
#include "MenuItem.h"
#import "CMenuCell.h"
NS_ASSUME_NONNULL_BEGIN

//所有自定义数据继承此类即可
@interface MenuItemCell : CMenuCell
    
    //标题
    @property (strong,nonatomic) UILabel* title;
    //内容
    @property (strong,nonatomic) UILabel *content;
    //前进按钮
    @property(strong,nonatomic) UIImageView *btn_forward;

  
@end

NS_ASSUME_NONNULL_END
