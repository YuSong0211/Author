//
//  KKPubTagVC.h
//  KK
//
//  Created by 小鱼 on 2021/7/1.
//

#import "KKSecondBaseVC.h"
#import "KKPubTagVCModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKPubTagVC : KKSecondBaseVC
@property (nonatomic, strong) NSMutableArray *selecteDataArray;
@property (nonatomic, strong)KKPubTagVCModel *model;
@property(nonatomic, copy) void (^comBtnActionBlock) (NSMutableArray *dataArray);
@end

NS_ASSUME_NONNULL_END
