//
//  KKMyEditUserInfoTableviewCell.m
//  KK
//
//  Created by 小草 on 2021/6/30.
//

#import "KKMyEditUserInfoTableviewCell.h"

@interface KKMyEditUserInfoTableviewCell ()

// 标题
@property (nonatomic,strong) UILabel * titleNameLab;

// 文本输入框
@property (nonatomic,strong) UITextField * userInfoInputTextF;

// 文本选择框
@property (nonatomic,strong) UILabel * selectSexLab;

// 箭头
@property (nonatomic,strong) UIImageView * arrowIcon;

@end

@implementation KKMyEditUserInfoTableviewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleNameLab];
        [self.contentView addSubview:self.userInfoInputTextF];
        [self.contentView addSubview:self.selectSexLab];
        [self.contentView addSubview:self.arrowIcon];
        
    }
    return self;
}


-(void)setBasic:(appvapiUserInfoBasic *)basic {
    _basic = basic;
    if ([KKUserInfo share].gender == appvapiGenders_Male) {
        _selectSexLab.text = @"男";
    }else if([KKUserInfo share].gender == appvapiGenders_Female){
        _selectSexLab.text = @"女";
    }else{
        _selectSexLab.text = @"女";
    }
    
//    if ([KKUserInfo share].gender == 0) {
//        // 未知
//        _selectSexLab.text = @"男";
//    }if ([KKUserInfo share].gender == 2) {
//        // 男
//        _selectSexLab.text = @"男";
//    }else {
//        // 女
//        _selectSexLab.text = @"女";
//    }
    if (self.cellIndex == 0) {
        self.userInfoInputTextF.text = !kStringIsEmpty(self.basic.nickname) ? self.basic.nickname : @"昵称";
    }
    if (self.cellIndex == 2) {
        self.userInfoInputTextF.text = [KKUserInfo share].hasBindingTelephone ? [KKUserInfo share].telephone : @"请绑定手机号";
    }
}
- (void)setNikeName:(NSString *)nikeName {
    _nikeName = nikeName;
    if (self.cellIndex == 0) {
        self.userInfoInputTextF.text = self.nikeName;
    }
}
-(void)setTitleName:(NSString *)titleName{
    _titleName = titleName;
    self.titleNameLab.text = titleName;
}
-(void)setGenderName:(NSString *)genderName {
    _genderName = genderName;
    _selectSexLab.text = kStringIsEmpty(genderName) ? @"" : genderName;
}
-(void)setPhone:(NSString *)phone {
    _phone = phone;
    if (self.cellIndex == 2) {
        self.userInfoInputTextF.text = phone;
    }
}
-(void)setCellIndex:(NSInteger)cellIndex{
    _cellIndex = cellIndex;
    
    
    self.userInfoInputTextF.hidden = cellIndex == 1?YES:NO;
    self.selectSexLab.hidden = cellIndex == 1?NO:YES;
    self.arrowIcon.hidden = cellIndex == 0?YES:NO;
    
    if (cellIndex == 3) {
        self.userInfoInputTextF.hidden = YES;
        self.selectSexLab.hidden = YES;
        self.arrowIcon.hidden = YES;
    }
    
    if (cellIndex == 0) {
        [self userNickNameInput];
    }else{
        [self userinfoPhoneInput];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleNameLab.frame = CGRectMake(15, self.contentView.frame.size.height/2-10, 100, 20);
    CGFloat userInfoInputText = self.cellIndex==0?self.contentView.frame.size.width - 15 - 172:self.contentView.frame.size.width - 20 - 172;
    self.userInfoInputTextF.frame = CGRectMake(userInfoInputText, self.contentView.frame.size.height/2-15, 172, 30);
    self.selectSexLab.frame = CGRectMake(self.frame.size.width - 72, self.contentView.frame.size.height/2-10, 36, 20);
    self.arrowIcon.frame = CGRectMake(self.contentView.frame.size.width-15-11, self.frame.size.height/2-(11/2), 11, 11);
}

-(UILabel *)titleNameLab{
    if (!_titleNameLab) {
        _titleNameLab = [[UILabel alloc]init];
        _titleNameLab.textColor = [KKColor getColor:appMainTextColor];
        _titleNameLab.font = [UIFont mediumWithSize:14];
        _titleNameLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleNameLab;
}

-(UITextField *)userInfoInputTextF{
    if (!_userInfoInputTextF) {
        _userInfoInputTextF = [[UITextField alloc]init];
        _userInfoInputTextF.textAlignment = NSTextAlignmentRight;
        _userInfoInputTextF.tintColor =  [KKColor getColor:appMainTextColor];// 设置光标颜色
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
        _userInfoInputTextF.rightView = paddingView;
        _userInfoInputTextF.rightViewMode = UITextFieldViewModeAlways;
        _userInfoInputTextF.userInteractionEnabled = NO;
    }
    return _userInfoInputTextF;
}

-(UILabel *)selectSexLab{
    if (!_selectSexLab) {
        _selectSexLab = [[UILabel alloc]init];
        _selectSexLab.textColor = [KKColor getColor:appHintTextColor];
        _selectSexLab.font = [UIFont regularWithSize:14];
        _selectSexLab.textAlignment = NSTextAlignmentRight;
    }
    return _selectSexLab;
}

-(UIImageView *)arrowIcon{
    if (!_arrowIcon) {
        _arrowIcon = [[UIImageView alloc]init];
//        _arrowIcon.image = [UIImage imageNamed:@"mine_edit_user_info_cell_arrow_ic"];
         UIImage *img=[UIImage imageNamed:@"mine_edit_user_info_cell_arrow_ic"];
            img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
          _arrowIcon.image =img;
            [_arrowIcon setTintColor:[KKColor getColor:appHintTextColor]];
            [_arrowIcon setTintColor:[KKColor getColor:appHintTextColor]];
    }
    return _arrowIcon;
}

// 改变文本框的提示文字
-(void)changetextFiledPlaceholder:(NSString *)placeholderStr{
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:placeholderStr attributes:@{NSForegroundColorAttributeName:[KKColor getColor:appHintTextColor],NSFontAttributeName:self.userInfoInputTextF.font}];
    self.userInfoInputTextF.attributedPlaceholder = attrString;
}

-(void)userNickNameInput{
    self.userInfoInputTextF.backgroundColor = [KKColor getColor:appEditTextBgColor];
    self.userInfoInputTextF.textColor = [KKColor getColor:appHintTextColor];
    self.userInfoInputTextF.font = [UIFont regularWithSize:14];
    self.userInfoInputTextF.layer.cornerRadius = 7;
    self.userInfoInputTextF.layer.masksToBounds = YES;
    
}

-(void)userinfoPhoneInput{
    self.userInfoInputTextF.backgroundColor = [UIColor clearColor];
    self.userInfoInputTextF.textColor = [KKColor getColor:appHintTextColor];
    self.userInfoInputTextF.font = [UIFont regularWithSize:14];

}
@end
