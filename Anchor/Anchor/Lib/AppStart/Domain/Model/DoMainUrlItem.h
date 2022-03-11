//
//  DoMainUrlItem.h
//  KK
//
//  Created by hk on 2021/8/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    DomainTypeUpdate,
    DomainTypeUc,
    DomainTypeApi,
    DomainTypeIm,
    DomainTypeShare,
    DomainTypeNoticeResource,
    DomainTypeGray
}AppLinkDomainType;
@interface DoMainUrlItem : NSObject


/// 更新域名列表
@property (nonatomic,strong) NSMutableArray* updateList;


/// uc域名列表
@property (nonatomic,strong) NSMutableArray* ucList;


/// api域名列表
@property (nonatomic,strong) NSMutableArray* apiList;

///分享域名
@property (nonatomic,strong) NSMutableArray* appVlink;

///公告域名
@property (nonatomic,strong) NSMutableArray* noticeResource;

@property (nonatomic, strong)NSMutableArray*   appvGrayscaleLink;
@end

NS_ASSUME_NONNULL_END
