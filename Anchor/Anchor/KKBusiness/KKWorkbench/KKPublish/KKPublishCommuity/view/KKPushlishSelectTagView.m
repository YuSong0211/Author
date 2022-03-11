//
//  KKPushlishSelectTagView.m
//  mt
//
//  Created by 小草 on 2021/10/10.
//

#import "KKPushlishSelectTagView.h"
//#import "KKPubCommunityTagController.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "KKPublishShortVideoCell.h"
#import "KKPubTagVCModel.h"

@interface KKPushlishSelectTagView()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation KKPushlishSelectTagView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.selectTagDesLab];
        [self addSubview:self.tagDesc];
        [self addSubview:self.selectTagButton];
        [self addSubview:self.collectionView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.selectTagDesLab.frame = CGRectMake(0, 0, 70, 18);
    self.tagDesc.frame =  CGRectMake(CGRectGetMaxX(self.selectTagDesLab.frame), 0, 70, 18);
    self.selectTagButton.frame = CGRectMake(self.frame.size.width-86, -5, 86, 30);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_selectTagButton.mas_bottom).offset(20);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@80);
    }];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //        _collectionView.scrollEnabled = false;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.alwaysBounceHorizontal = NO;
        [_collectionView registerClass:[KKPublishShortVideoCell class] forCellWithReuseIdentifier:@"KKSHortTagCellID"];
    }
    return _collectionView;
}

-(UILabel *)selectTagDesLab{
    if (!_selectTagDesLab) {
        _selectTagDesLab = [[UILabel alloc]init];
        [_selectTagDesLab setText:@"添加标签"];
        [_selectTagDesLab setFont:[UIFont mediumWithSize:15]];
        [_selectTagDesLab setTextColor: [KKColor getColor:appMainTextColor]];
    }
    return _selectTagDesLab;
}


-(UILabel *)tagDesc{
    if (!_tagDesc) {
        _tagDesc = [[UILabel alloc]init];
        [_tagDesc setText:@"(最多5个)"];
        [_tagDesc setFont:[UIFont mediumWithSize:14]];
        [_tagDesc setTextColor:[KKColor getColor:appHintTextColor]];
    }
    return _tagDesc;
}

-(UIButton *)selectTagButton{
    if (!_selectTagButton) {
        _selectTagButton = [[UIButton alloc]init];
        [_selectTagButton setBackgroundColor:[KKColor getColor:colorSecondBtnBg]];
        [_selectTagButton setTitle:@"选择标签" forState:UIControlStateNormal];
        [_selectTagButton.titleLabel setFont:[UIFont mediumWithSize:13]];
        [_selectTagButton setTitleColor: [KKColor getColor:colorSecondBtnText] forState:UIControlStateNormal];
        [_selectTagButton.layer setCornerRadius:15];
        [_selectTagButton.layer setMasksToBounds:YES];
        [_selectTagButton addTarget:self action:@selector(selectTagBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectTagButton;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tagDataArray.count > 0 && indexPath.row <= self.tagDataArray.count - 1) {
        KKPubTagVCDataModel *Model = self.tagDataArray[indexPath.row];
        self.cancleselectTagBlock(Model);
        [self.tagDataArray removeObjectAtIndex:indexPath.row];
        [collectionView reloadData];
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KKPublishShortVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKSHortTagCellID" forIndexPath:indexPath];
    KKPubTagVCDataModel *selectDataModel = self.tagDataArray[indexPath.row];
    cell.titleLabel.text =[NSString stringWithFormat:@"#%@",selectDataModel.title];
    [cell.titleLabel setTextColor:[KKColor getColor:colorPrimary]];
    cell.titleLabel.backgroundColor = KK_RELES_PAGE_THEMECOLOR;
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tagDataArray.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 5, 15);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //return CGSizeMake((KSCREEN_WIDTH-70)/4, 106);
    KKPubTagVCDataModel *selectDataModel = self.tagDataArray[indexPath.row];
    NSString *text = selectDataModel.title;
    CGFloat width = [text singleLineSizeWithText:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular]].width;
    return CGSizeMake(width + 30, 32);
}
-(void)setTagDataArray:(NSMutableArray *)tagDataArray{
    _tagDataArray = tagDataArray;
    //    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
    //        make.height.mas_equalTo(self.collectionView.contentSize.height);
    //    }];
    [_collectionView reloadData];
}

-(void)selectTagBtnAction{
   
    // 选择标签回调
    
    if (self.selectTagBlock) {
        self.selectTagBlock(self.tagDataArray);
    }
 
//    KKPubCommunityTagController *pubTagVc = [[KKPubCommunityTagController alloc] init];
////    pubTagVc.selecteDataArray = self.selecteDataArray;
//    WS
//    [pubTagVc setComBtnActionBlock:^(NSMutableArray * _Nonnull dataArray) {
//        SS
//    }];
//    [[KKTool getCurrentVC].navigationController pushViewController:pubTagVc animated:YES];
    
}

@end
