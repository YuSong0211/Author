//
//  KKMyLikeViewController.m
//  KK
//
//  Created by 小草 on 2021/6/27.
//

#import "KKMyLikeViewController.h"
#import "KKMyLikeListViewController.h"
#import "KKMyLikeCommunityVController.h"
@interface KKMyLikeViewController ()


@end

@implementation KKMyLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的点赞";
}

- (NSArray<UIViewController *> *)childViewControllerArray {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [[self titleArray] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            KKMyLikeListViewController *vc = [[KKMyLikeListViewController alloc] init];
            vc.vcType = KKMainPageListShortVideoType;
            [array addObject:vc];
        }else{
            KKMyLikeCommunityVController *vc = [[KKMyLikeCommunityVController alloc]init];
            vc.vcType = KKMainPageListShortCommunityType;
            [array addObject:vc];
        }
    }];
    return array;
}

- (NSArray<NSString *> *)titleArray {
    return @[@"短视频",@"社区帖子"];
}

-(void)dealloc{
    NSLog(@"我的点赞页面释放了");
}

@end
