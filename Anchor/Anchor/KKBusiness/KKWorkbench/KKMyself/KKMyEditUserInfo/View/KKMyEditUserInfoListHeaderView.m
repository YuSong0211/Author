//
//  KKMyEditUserInfoListHeaderView.m
//  KK
//
//  Created by 小草 on 2021/6/30.
//

#import "KKMyEditUserInfoListHeaderView.h"
#import "SelectMediaMoudle.h"
#import "UIImageView+Extension.h"
#import "KKPermissionUtils.h"
@interface KKMyEditUserInfoListHeaderView ()

@property (nonatomic,strong) CoustomButton * userIcon;

@end

@implementation KKMyEditUserInfoListHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.userIcon];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.userIcon.frame = CGRectMake(self.frame.size.width/2-50, 17, 100, 110);
    self.userIcon.yc_buttonStyle = YcButtonStyleTextBottomImageTopType;
}
-(void)setBasic:(appvapiUserInfoBasic *)basic {
    _basic = basic;
    
    // 后台返回用户头像为空，并且本地头像不为空，则取本地
    if (basic.avatarURL.URL.length == 0 && [KKUserInfo share].userImage !=nil) {
        _userIcon.buttonIcon.image =  [KKUserInfo share].userImage;
    }else{
        if ([KKUserInfo share].userImage) {
            _userIcon.buttonIcon.image =  [KKUserInfo share].userImage;
        }else{
            [_userIcon.buttonIcon setImageWithUrlString:basic.avatarURL.URL placeholderImage:@"default_head" animated:NO];
        }
       
    }
}
- (void)setSelectImage:(UIImage *)selectImage {
    _selectImage = selectImage;
    self.userIcon.yc_buttonImage = selectImage;
}
-(void)usericonClick{
    
    [KKPermissionUtils requestPhotoAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            
            SelectMediaMoudle * seleMedia = [[SelectMediaMoudle alloc]init];
            seleMedia.mediaType = SelectOnlyImageType;
            [seleMedia showMedia:[KKTool getCurrentVC]];
            WS
            seleMedia.didSelectSingleImage = ^(UIImage *image) {
                SS
                if (self.selectAvterImageBlock) {
                    self.selectAvterImageBlock(image);
                }
            };
        }
    }];
    
 
}
// 用户更换头像
-(CoustomButton *)userIcon{
    if (!_userIcon) {
        _userIcon = [[CoustomButton alloc]init];
        _userIcon.yc_buttonimagesize = CGSizeMake(75, 75);
        _userIcon.cornerRadius = 75/2;
        _userIcon.yc_buttontitle = @"点击更换头像";
        _userIcon.yc_titleColor =  [KKColor getColor:appMainTextColor];
        _userIcon.yc_titleFont = [UIFont mediumWithSize:14];
        _userIcon.yc_controlMargin = 15;
        [_userIcon addTarget:self action:@selector(usericonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userIcon;
}
@end
