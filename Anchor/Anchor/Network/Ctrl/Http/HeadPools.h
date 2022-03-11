//
//  HeadPools.h
//  KK
//
//  Created by hk on 2021/8/3.
//
//http head 管理器，自动调用，无特殊请求情况下无须需改此类参数
#import <Foundation/Foundation.h>
#import "HeadItem.h"
NS_ASSUME_NONNULL_BEGIN


@interface HeadPools : NSObject

//token
@property (strong,nonatomic) HeadItem* xTokenHead;

//uc voyage-dev
@property(strong,nonatomic) HeadItem* xUcChannelKeyHead;

//net core head.
@property(strong,nonatomic) HeadItem* netCoreHead;

//content type
@property(strong,nonatomic) HeadItem* contentType;

//api head
@property(strong,nonatomic) HeadItem* apiHead;

@property(strong,nonatomic) HeadItem* appvlink;
    
    //获取实体对象
+(HeadPools*)getHeadPool;
    
//修改head 缓存值
-(void)updateHeadVal:(HeadType)type :(NSString*)val;

//根据传入type 获取组合头
-(NSMutableArray<HeadItem*>*) getHeadList:(NSMutableArray*)types;

//根据type，获取headitem
-(HeadItem*)getHeadByType:(HeadType)type;


//通过package name 获取对应head
-(NSMutableURLRequest*) setNetWillSendHead:(NSMutableURLRequest*)request :(NSString*)packageName:(BOOL)useToken;

@end

NS_ASSUME_NONNULL_END
