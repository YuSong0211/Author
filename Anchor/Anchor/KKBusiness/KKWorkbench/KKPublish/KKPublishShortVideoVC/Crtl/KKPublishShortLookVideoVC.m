//
//  KKPublishShortLookVideoVC.m
//  KK
//
//  Created by ProgramMa on 2021/7/8.
//

#import "KKPublishShortLookVideoVC.h"
#import <AVFoundation/AVFoundation.h>
@interface KKPublishShortLookVideoVC ()
//播放器
@property(nonatomic,strong) AVPlayer *myPlayer;
//播放单元(多媒体资源)
@property(nonatomic,strong) AVPlayerItem *item;
//播放界面
@property(nonatomic,strong) AVPlayerLayer *playerLayer;
@end

@implementation KKPublishShortLookVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //播放网站
    NSURL *mediaURL = [NSURL URLWithString:@"https://flv2.bn.netease.com/0f30656af3618b10e941ab6539b31a072d3d3173139c40bab50f171b7191cd91c19ed006ecbf878f19f0db8574a942f3001d6db6a59a310917f71c248c39478be73e84f3392d9ba94668179499d5fbc2f5e4f34d16ce8843de2460c4082fa1edecc110ee394d857d9d035958fab993db7c567620dc131c35.mp4"];
    //初始化一个播放单元
    self.item = [AVPlayerItem playerItemWithURL:mediaURL];
    //初始化一个对象播放器
    self.myPlayer = [AVPlayer playerWithPlayerItem:self.item];

    //初始化一个播放器的Layer
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];
    self.playerLayer.frame = CGRectMake(0, 15, KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT - 60);
    [self.view.layer addSublayer:self.playerLayer];
    //开始播放视频
    [self.myPlayer play];
}

@end
