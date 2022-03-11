//
//  MenuItem.h
//  KK
//
//  Created by hk on 2021/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuItem : NSObject

//初始化参数
-(MenuItem*)initWithParam :(NSString*)p_title :(NSString*)p_content :(int)p_index :(BOOL)p_hasmesh;

//菜单标题
@property (strong,nonatomic) NSString* title;

//菜单内容
@property(strong,nonatomic) NSString* content;

//菜单下表
@property(assign,nonatomic) int index;

//是否有分割线
@property(assign,nonatomic) bool hasMesh;

@end

NS_ASSUME_NONNULL_END
