//
//  AvExtraBean.h
//  lmtest
//
//  Created by hk on 2021/11/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AvExtraBean : NSObject



/// 创建结构
/// @param type 类型
/// @param data 数据
+(AvExtraBean*)createExtraWithData:(int)type data:(NSString*)data;


/// 创建结构,返回列表
/// @param type 类型
/// @param data 数据
+(NSMutableArray*)createArrayExtraWithData:(int)type data:(NSString*)data;


/// 扩展参数类型
@property(nonatomic,assign)int type;


/// 扩展参数数据
@property(nonatomic,strong)NSString* data;




@end

NS_ASSUME_NONNULL_END
