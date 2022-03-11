//
//  KKPubCommunityTagController.m
//  mt
//
//  Created by ProgramMa on 2021/10/14.
//

#import "KKPubCommunityTagController.h"
#import "KKPubTagCell.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "NSString+Extension.h"
@interface KKPubCommunityTagController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *tagDataArray;
@property (nonatomic, strong) NSMutableArray *selectTagDataArray;
@property (nonatomic, strong) NSMutableArray *addDataArray;
@property (nonatomic, strong) UIButton *pubBtn;
@property (nonatomic, strong) UIView *releaseButtonBgView;
@property (nonatomic, strong) UIButton *releaseButton;

@end

@implementation KKPubCommunityTagController

-(KKPubTagVCModel *)model{
    if (!_model) {
        _model = [[KKPubTagVCModel alloc]init];
    }
    return _model;
}
-(NSMutableArray *)tagDataArray{
    if (!_tagDataArray) {
        _tagDataArray = [NSMutableArray new];
    }
    return _tagDataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:KKMainColor];
    self.title = @"选择标签";

    [self setUpView];

    NSMutableArray *indexPathArr =[NSMutableArray  array];
    for (int i = 0; i <self.selecteDataArray.count; i ++) {
        KKPubTagVCDataModel *selectDataModel = self.selecteDataArray[i];
        [indexPathArr addObject:[NSString stringWithFormat:@"%ld",selectDataModel.indexPathRow]];
    }
    [self.selectTagDataArray addObjectsFromArray:indexPathArr];
    [self.addDataArray addObjectsFromArray:self.selecteDataArray];
    [self.collectionView reloadData];
    // Do any additional setup after loading the view.
}
-(void)setUpView{
    [self.view addSubview:self.releaseButtonBgView];
    [self.releaseButtonBgView addSubview:self.releaseButton];
    [self.view addSubview:self.collectionView];
    [self.releaseButtonBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(-15-KK_BOTTOM_SECURITY_HEIGHT);
    }];
    [self.releaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.releaseButtonBgView.mas_left).offset(15);
        make.right.equalTo(self.releaseButtonBgView.mas_right).offset(-15);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(0);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(300);
    }];
    [KKGeneralGradientColor KK_createByCAGradientLayer:KK_GRDIENT_THEMECOLOR direction:GradientTypeLeftToRight layerView:self.releaseButton isConstraint:YES];
//    [KKGeneralGradientColor KK_createByCAGradientLayer:@[(id)[KKColor getColor:colorPrimary].CGColor,(id)[KKColor getColor:colorPrimaryDark].CGColor] direction:GradientTypeLeftToRightCenter layerView:self.releaseButtonBgView isConstraint:YES];
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [layout setSectionInset:UIEdgeInsetsMake(15, 15, -5, 15)];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = false;
        [_collectionView registerClass:[KKPubTagCell class] forCellWithReuseIdentifier:@"KKAllSHortTagCellID"];
    }
    return _collectionView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    KKPubTagCell *cell = (KKPubTagCell*)[collectionView cellForItemAtIndexPath:indexPath];
    KKPubTagVCDataModel *selecteModel = [KKPubTagVCModel shareToolGetManager].communityTagList[indexPath.row];
    cell.isSelect = !cell.isSelect;
    for (int i = 0; i < self.addDataArray.count; i++) {
        KKPubTagVCDataModel *selectDataModel = self.addDataArray[i];
        if ([selectDataModel.title isEqualToString:selecteModel.title]) {
            cell.isSelect = NO;
        }
    }
    if (cell.isSelect) {
        selecteModel.isSelect = 0;
        if (self.addDataArray.count < 5) {
            selecteModel.indexPathRow = indexPath.row;
            [self.addDataArray addObject:selecteModel];
            [self.selectTagDataArray addObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
        }else {
            cell.isSelect = NO;
            selecteModel.isSelect = 1;
            NSLog(@"=============最多选择5个标签");
            [SVProgressHUD showMessage:@"最多选择5个标签"];
        }
    }else {
        selecteModel.isSelect = 1;
        for (int i = 0; i < self.addDataArray.count; i++) {
            KKPubTagVCDataModel *selectDataModel1 = self.addDataArray[i];
            if ([selectDataModel1.title isEqualToString:selecteModel.title]) {
//                NSLog(@"==========%d",i);
                [self.addDataArray removeObjectAtIndex:i];
            }
        }
        if ([self.selectTagDataArray containsObject:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
            [self.selectTagDataArray removeObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
        }
    }
    cell.tagModel = selecteModel;
}
    
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KKPubTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKAllSHortTagCellID" forIndexPath:indexPath];
    cell.titleLabel.text =[NSString stringWithFormat:@"#%@",[KKPubTagVCModel shareToolGetManager].communityTagList[indexPath.row].title];

    if ([self.selectTagDataArray containsObject:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
        // 选中
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [cell createByCAGradientLayer:[KKColor getColor:colorPrimary] endColor:[KKColor getColor:colorPrimaryDark] layerFrame:cell.contentView.frame direction:GradientTypeLeftToRight];
            [cell.titleLabel setTextColor:[KKColor getColor:colorMainBtnText]];
        });
        
    }else{
        // 取消
        [cell.layerNew removeFromSuperlayer];
        [cell.titleLabel setTextColor:[KKColor getColor:colorSecondBtnText]];
    }
    return cell;
}
    
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [KKPubTagVCModel shareToolGetManager].communityTagList.count;
}
    
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //return CGSizeMake((KSCREEN_WIDTH-70)/4, 106);
//    KKPubTagVCDataModel *model = self.tagDataArray[indexPath.row];
    NSString *text = [KKPubTagVCModel shareToolGetManager].communityTagList[indexPath.row].title;
    CGFloat width = [text singleLineSizeWithText:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular]].width;
    return CGSizeMake(width + 30, 32);
}
-(void)createByCAGradientLayer:(UIColor *)startColor endColor:(UIColor *)endColor layerFrame:(CGRect)frame direction:(GradientType)direction{
    CAGradientLayer *layer = [CAGradientLayer new];
    //存放渐变的颜色的数组
    layer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    //起点和终点表示的坐标系位置，(0,0)表示左上角，(1,1)表示右下角
    switch (direction) {
        case GradientTypeTopToBottom:
            layer.startPoint = CGPointMake(0.0, 0.0);
            layer.endPoint = CGPointMake(0.0, 1);
            break;
        case GradientTypeLeftToRight:
            layer.startPoint = CGPointMake(0.0, 0.0);
            layer.endPoint = CGPointMake(.5, 0.0);
            break;
        default:
            break;
    }
    layer.frame = frame;
    [self.releaseButtonBgView.layer addSublayer:layer];
}
-(void)comBtnAction{
    if (self.comBtnActionBlock) {
//        if (self.addDataArray.count == 0) {
//            [SVProgressHUD showMessage:@"请选择标签"];
//            return;
//        }
        NSLog(@"-------   %@",self.addDataArray);
        self.comBtnActionBlock(self.addDataArray);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (NSMutableArray *)selectTagDataArray {
    if (!_selectTagDataArray) {
        _selectTagDataArray = [NSMutableArray array];
    }
    return _selectTagDataArray;
}
- (NSMutableArray *)addDataArray {
    if (!_addDataArray) {
        _addDataArray = [NSMutableArray array];
    }
    return _addDataArray;
}
- (UIView *)releaseButtonBgView {
    if (!_releaseButtonBgView) {
        _releaseButtonBgView = [[UIView alloc] init];
        _releaseButtonBgView.layer.cornerRadius = 23;
        _releaseButtonBgView.layer.masksToBounds = YES;
        
    }
    return _releaseButtonBgView;
}
- (UIButton *)releaseButton {
    if (!_releaseButton) {
        _releaseButton = [[UIButton alloc] init];
        [_releaseButton setTitle:@"确定" forState:UIControlStateNormal];
        _releaseButton.backgroundColor = [UIColor clearColor];
        [_releaseButton setTitleColor:[KKColor getColor:colorMainBtnText] forState:UIControlStateNormal];
        _releaseButton.titleLabel.font = [UIFont mediumWithSize:16];
        _releaseButton.layer.cornerRadius = 23;
        _releaseButton.layer.masksToBounds = YES;
        [_releaseButton addTarget:self action:@selector(comBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _releaseButton;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
