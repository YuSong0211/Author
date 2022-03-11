//
//  KKLoginAuthenticationCollectionCell.m
//  KK
//
//  Created by 小草 on 2021/7/5.
//

#import "KKLoginAuthenticationCollectionCell.h"

@interface KKLoginAuthenticationCollectionCell ()

@property (nonatomic,strong) UIImageView * showIcon;

@property (nonatomic,strong) UIImageView * selectIcon;


@end

@implementation KKLoginAuthenticationCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.showIcon];
        [self addSubview:self.selectIcon];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.showIcon.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.selectIcon.frame = CGRectMake(self.frame.size.width - 28, self.showIcon.frame.size.height - 20.5, 20, 20);
}

// 展示icon
-(UIImageView *)showIcon{
    if (!_showIcon) {
        _showIcon = [[UIImageView alloc]init];
        _showIcon.image = [UIImage imageNamed:@"mine_header_backGround_ic"];
    }
    return _showIcon;
}

// 选择icon
-(UIImageView *)selectIcon{
    if (!_selectIcon) {
        _selectIcon = [[UIImageView alloc]init];
        _selectIcon.image = [UIImage imageNamed:@"login_authenction_code_select_ic"];
    }
    return _selectIcon;
}
@end
