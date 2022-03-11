//
//  KKMinewallteCell.h
//  mt
//
//  Created by ProgramMa on 2021/10/18.
//

#import "KKBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKMinewallteCell : KKBaseTableViewCell
@property (nonatomic,copy) void(^clickWebViewCallBack)(void);
@property (nonatomic,strong)UILabel *walletLab;
-(void)reloadWeb;
@end

NS_ASSUME_NONNULL_END
