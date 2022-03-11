//
//  KKMySettingTableViewCell.m
//  KK
//
//  Created by 小草 on 2021/6/29.
//

#import "KKMySettingTableViewCell.h"
#import "AppVersionMgr.h"
@interface KKMySettingTableViewCell ()

// 标签
@property (nonatomic,strong) UILabel * titleLab;

// 当前系统占用手机缓存大小
@property (nonatomic,strong) UILabel * currentCacheSizeLab;

// 右边三角icon
@property (nonatomic,strong) UIImageView * arrowIcon;

@property (nonatomic,strong) UIView *redView;

@end

@implementation KKMySettingTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.currentCacheSizeLab];
        [self.contentView addSubview:self.arrowIcon];
        [self.contentView addSubview:self.redView];
    }
    return self;
}

-(void)setCellIndex:(NSInteger)cellIndex{
    _cellIndex = cellIndex;
    self.currentCacheSizeLab.hidden = cellIndex==0||cellIndex == 1?YES:NO;
    self.redView.hidden = cellIndex ==0 ||cellIndex == 1||cellIndex == 2?YES:NO;
    if (cellIndex == 3) {
        if (![AppVersionMgr shareMgr].isNewVersion) {
            self.currentCacheSizeLab.hidden = NO;
            self.redView.hidden = YES;
            self.arrowIcon.hidden = NO;
        }else{
            self.currentCacheSizeLab.hidden = NO;
            self.redView.hidden = NO;
            self.arrowIcon.hidden = NO;
           
        }
    }
    
//    self.currentCacheSizeLab.hidden = cellIndex==2?YES:NO;
}

-(void)setTitleName:(NSString *)titleName{
    _titleName = titleName;
    self.titleLab.text = titleName;
    if (self.cellIndex == 2) {
        _currentCacheSizeLab.text = @"";
    }else if (self.cellIndex == 3){
        if ([AppVersionMgr shareMgr].isNewVersion) {
            NSString *version =[[AppVersionMgr shareMgr]getVersion:YES];
            _currentCacheSizeLab.text =[NSString stringWithFormat:@"发现新版本: %@",version];
        }else{
            NSString *version =[[AppVersionMgr shareMgr]getVersion:YES];
            _currentCacheSizeLab.text =[NSString stringWithFormat:@"已是最新版本: v%@",version];
        }
       
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLab.frame = CGRectMake(15, self.frame.size.height/2-10.5, 100, 21);
    self.arrowIcon.frame = CGRectMake(self.contentView.frame.size.width - 26, self.frame.size.height/2-5.5, 11, 11);
    self.currentCacheSizeLab.frame = CGRectMake(self.contentView.frame.size.width - 41 - 200, self.contentView.frame.size.height/2 - 10, 200, 20);
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowIcon.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.arrowIcon).offset(-5);
        make.size.mas_equalTo(CGSizeMake(6, 6));
    }];
    self.redView.layer.masksToBounds = YES;
    self.redView.layer.cornerRadius = 3;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [KKColor getColor:appMainTextColor];
        _titleLab.font = [UIFont regularWithSize:15];
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}

-(UILabel *)currentCacheSizeLab{
    if (!_currentCacheSizeLab) {
        _currentCacheSizeLab = [[UILabel alloc]init];
        _currentCacheSizeLab.textColor = [KKColor getColor:appHintTextColor];
        _currentCacheSizeLab.textAlignment = NSTextAlignmentRight;
        _currentCacheSizeLab.font = [UIFont regularWithSize:14];
    }
    return _currentCacheSizeLab;
}

-(UIImageView *)arrowIcon{
    if (!_arrowIcon) {
        _arrowIcon = [[UIImageView alloc]init];
        UIImage *image = [UIImage imageNamed:@"mine_setting_cell_arrow_ic"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _arrowIcon.image = image;
        [_arrowIcon setTintColor:[KKColor getColor:appHintTextColor]];
    }
    return _arrowIcon;
}

-(UIView *)redView{
    if (!_redView) {
        _redView = [[UIView alloc]init];
        _redView.backgroundColor  =[UIColor redColor];
    }
    return _redView;
}
@end
