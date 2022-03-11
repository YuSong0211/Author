//
//  KKPubCommunityTagController.h
//  mt
//
//  Created by ProgramMa on 2021/10/14.
//

#import "KKSecondBaseVC.h"
#import "KKPubTagVCModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface KKPubCommunityTagController : KKSecondBaseVC
@property (nonatomic, strong) NSMutableArray *selecteDataArray;
@property (nonatomic, strong)KKPubTagVCModel *model;
@property(nonatomic, copy) void (^comBtnActionBlock) (NSMutableArray *dataArray);
@end

NS_ASSUME_NONNULL_END
