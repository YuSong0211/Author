//
//  KKAdModel.h
//  mt
//
//  Created by 小鱼 on 2021/10/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKAdModel : NSObject
+ (KKAdModel *)share;
///公告数组
@property (nonatomic, strong)NSMutableArray<serviceapplinkNotice*> *noticesArray;
///视频广告数组
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<serviceapplinkAdvertisement*> *advertisementArray;
+(void)openPageWithParams:(NSDictionary *)paramDic;
@end

NS_ASSUME_NONNULL_END
