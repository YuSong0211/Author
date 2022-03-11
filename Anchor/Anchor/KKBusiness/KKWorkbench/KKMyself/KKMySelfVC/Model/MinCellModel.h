//
//  MinCellModel.h
//  KK
//
//  Created by 小草 on 2021/6/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MinCellModelDataSource;

@interface MinCellModel : NSObject

@property (nonatomic,strong) NSMutableArray <MinCellModelDataSource*>* dataSource;

@end


@interface MinCellModelDataSource : NSObject

// icon
@property (nonatomic,strong) NSString * iconName;

// 标题
@property (nonatomic,strong) NSString * titleName;

// 控制器名称
@property (nonatomic,strong) NSString * controllerClass;



@end

NS_ASSUME_NONNULL_END
