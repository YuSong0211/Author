//
//  MineHeaderView.m
//  KK
//
//  Created by 小草 on 2021/6/24.
//  height 325.5

#import "MineHeaderView.h"


@interface MineHeaderView ()

@property (nonatomic,assign) BOOL isFirst;

@end


@implementation MineHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headerIcon];
        [self addSubview:self.bottomView];
        [self addSubview:self.headerMsgView];

        [self resetFrame];
       
    }
    return self;
}

-(void)resetFrame{
    self.headerIcon.frame = CGRectMake(0, 0, self.frame.size.width, 150);
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.headerIcon.frame), self.frame.size.width, KK_NAV_BAR_HEIGHT + 91.5);
    self.headerMsgView.frame = CGRectMake(15, KK_NAV_BAR_HEIGHT - 5, self.frame.size.width - 30, 233);
}

// 消息点击
-(void)messageButtonClick{
    
}

// 头部icon
-(UIImageView *)headerIcon{
    if (!_headerIcon) {
        _headerIcon = [[UIImageView alloc]init];
        //_headerIcon.image = [UIImage imageNamed:@"header_ic"];
        _headerIcon.image = [KKTool decodeResourceFileImageName:@"icon_mine_list_header"];
        _headerIcon.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headerIcon;
}

// 底部视图
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [KKColor getColor:appBgColor];
    }
    return _bottomView;
}

// 头部信息视图
-(MineHeaderMsgView *)headerMsgView{
    if (!_headerMsgView) {
        _headerMsgView = [[MineHeaderMsgView alloc]init];
    }
    return _headerMsgView;
}



@end
