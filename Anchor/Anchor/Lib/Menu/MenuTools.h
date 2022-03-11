//
//  MenuTools.h
//  KK
//
//  Created by hk on 2021/6/24.
//

#import <Foundation/Foundation.h>
#import "ISysEventCommon.h"
#import "MenuItem.h"
#import "MenuItemCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface MenuTools : NSObject<IOnClickEvent>

//cell 高度
@property (assign,nonatomic) int cellheight;

@property (strong,nonatomic) Class cellclass;

//初始化的数据组
@property (strong,nonatomic)NSMutableArray<MenuItem*> *menuList;


//初始化
-(MenuTools*)initWithParam :(NSMutableArray<MenuItem*>*)array :(Class)cellclass :(int)cellheight;

//添加数据
-(void)addItem :(MenuItem*)menu;

//添加一组数据
-(void)addRangeItem :(NSMutableArray<MenuItem*>*)array;

//开始创建
-(UIView*)create;

@end

NS_ASSUME_NONNULL_END
