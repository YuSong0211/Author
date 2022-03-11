//
//  KKPubTagTableViewCell.h
//  KK
//
//  Created by 小鱼 on 2021/7/1.
//

#import <UIKit/UIKit.h>
#import "KKPubTagVCModel.h"
//#import "KKCommunityTagModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface KKPubTagCell : UICollectionViewCell
@property (nonatomic,strong) KKPubTagVCDataModel *model;
@property (nonatomic,strong) KKPubTagVCDataModel *tagModel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,assign) BOOL isSelect;
@property (nonatomic,strong)CAGradientLayer *layerNew;

-(void)createByCAGradientLayer:(UIColor *)startColor endColor:(UIColor *)endColor layerFrame:(CGRect)frame direction:(GradientType)direction;
@end

NS_ASSUME_NONNULL_END
