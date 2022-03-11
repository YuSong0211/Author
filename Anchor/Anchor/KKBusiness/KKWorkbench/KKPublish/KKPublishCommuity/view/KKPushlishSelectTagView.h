//
//  KKPushlishSelectTagView.h
//  mt
//
//  Created by 小草 on 2021/10/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface KKPushlishSelectTagView : UIView

@property (nonatomic,strong) UILabel * selectTagDesLab; // 选择标签

@property (nonatomic,strong) UILabel * tagDesc; // 标签说明

@property (nonatomic,strong) UIButton * selectTagButton; // 选择标签按钮

@property (nonatomic, strong) NSMutableArray *tagDataArray;//标签数组
@property (nonatomic,copy) void (^selectTagBlock)(NSMutableArray *selecteArray);//
@property (nonatomic,copy) void (^cancleselectTagBlock)(KKPubTagVCDataModel *tagVCDataModel);//
@property (nonatomic, strong) UICollectionView *collectionView;
@end

NS_ASSUME_NONNULL_END
