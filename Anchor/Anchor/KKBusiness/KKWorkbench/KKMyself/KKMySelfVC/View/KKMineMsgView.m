//
//  KKMineMsgView.m
//  KK
//
//  Created by 小草 on 2021/7/12.
//

#import "KKMineMsgView.h"

@interface KKMineMsgView ()


// 消息按钮
@property (nonatomic,strong) UIImageView * messageIcon;

// 消息标签
@property (nonatomic,strong) UILabel * messageCountLab;

// 点击消息遮罩button
@property (nonatomic,strong) UIButton * messageMaskButton;

@end

@implementation KKMineMsgView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        [self addSubview:self.messageIcon];
        [self addSubview:self.messageCountLab];
        [self addSubview:self.messageMaskButton];
        
    }
    return self;
}

-(void)layoutSubviews{

    // 消息
    self.messageIcon.frame = CGRectMake(self.frame.size.width - 15 - 25, 7, 25, 25);
    if (self.isShowCount == YES) {
        if ([self.messageCountLab.text containsString:@"+"]) {
            // 消息个数
            self.messageCountLab.frame = CGRectMake(self.frame.size.width - 30, 3, 22, 11.5);
        }else{
            // 消息个数
            self.messageCountLab.frame = CGRectMake(self.frame.size.width - 28, 3, 20, 11.5);
        }
        self.messageCountLab.layer.cornerRadius = 6.3;
        self.messageCountLab.layer.masksToBounds = YES;
    }else{
        // 显示红点
        self.messageCountLab.text = @"";
        self.messageCountLab.frame = CGRectMake(CGRectGetMaxX(self.messageIcon.frame)-8, CGRectGetMinY(self.messageIcon.frame), 10, 10);
        self.messageCountLab.layer.cornerRadius = 5;
        self.messageCountLab.layer.masksToBounds = YES;
    }
   
    // 消息遮罩
    self.messageMaskButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

// 消息点击事件
-(void)messageButtonClick{

}

// 消息icon
-(UIImageView *)messageIcon{
    if (!_messageIcon) {
        _messageIcon = [[UIImageView alloc]init];
        _messageIcon.image = [KKTool decodeResourceFileImageName:@"icon_mine_message"];
    }
    return _messageIcon;
}

// 消息个数
-(UILabel *)messageCountLab{
    if (!_messageCountLab) {
        _messageCountLab = [[UILabel alloc]init];
        _messageCountLab.font = [UIFont mediumWithSize:9];
        _messageCountLab.textColor = [UIColor whiteColor];
        _messageCountLab.textAlignment = NSTextAlignmentCenter;
        _messageCountLab.backgroundColor = KKRGBA(250, 61, 88, 1);
        _messageCountLab.layer.cornerRadius = 6.3;
        _messageCountLab.layer.masksToBounds = YES;
        _messageCountLab.text = @"0";
        self.messageCountLab.hidden = YES;
    }
    return _messageCountLab;
}

-(UIButton *)messageMaskButton{
    if (!_messageMaskButton) {
        _messageMaskButton = [[UIButton alloc]init];
        [_messageMaskButton addTarget:self action:@selector(messageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageMaskButton;
}

- (void)setUnReadTotalCount:(NSInteger)unReadTotalCount {
   
    
}

-(void)setIsShowCount:(BOOL)isShowCount{
    _isShowCount = isShowCount;
    [self layoutSubviews];
}
@end
