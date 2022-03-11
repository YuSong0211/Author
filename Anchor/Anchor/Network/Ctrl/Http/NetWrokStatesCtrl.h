//
//  NetWrokStatesCtrl.h
//  KK
//
//  Created by hk on 2021/8/6.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTCellularData.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSInteger,KKNetWorkState){
    KKNetWIFI  =  2,
    KKNetPhone = 1,
    KKNetLose = 0,
    KKNetUnknown = -1
};
   

//网络状态控制器
@interface NetWrokStatesCtrl : NSObject
    
//获取单例
+(NetWrokStatesCtrl*)getInstance;

//初始化网络控制器
-(void)initCtrl;

@property (nonatomic, assign) KKNetWorkState KKNetWorkState;

//网络是否可用
-(BOOL)networkIsAvailable;

//网络是否真正可用
-(BOOL)isRealyNetAvailable;

@end

NS_ASSUME_NONNULL_END
