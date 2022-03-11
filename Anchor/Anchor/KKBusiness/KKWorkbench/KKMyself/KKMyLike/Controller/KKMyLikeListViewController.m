//
//  KKMyLikeListViewController.m
//  KK
//
//  Created by 小草 on 2021/6/27.

#import "KKMyLikeListViewController.h"
#import "KKSecondVideoVC.h"
#import "KKMyLikeViewModel.h"
#import "KKMyLikeCollectionCell.h"

@interface KKMyLikeListViewController ()

@property (nonatomic,strong) KKMyLikeViewModel *viewModel;

@end

@implementation KKMyLikeListViewController

- (KKMyLikeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[KKMyLikeViewModel alloc] init];
        _viewModel.delegate = self;
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseViewModel = (BaseVideoListViewModel *)self.viewModel;
    self.pageType = KKLoadMYLoveNodata;
}

- (void)createUI{
    [self addCollectionViewWithIdentifiers:@[NSStringFromClass([KKMyLikeCollectionCell class])] isConfigRefresh:YES];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KKMyLikeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KKMyLikeCollectionCell class]) forIndexPath:indexPath];
    cell.model = self.viewModel.videoList[indexPath.row];
    return cell;
}

@end
