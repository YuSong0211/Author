//
//  KKMyEditUserInfoListFooterView.m
//  KK
//
//  Created by 小草 on 2021/6/30.
//

#import "KKMyEditUserInfoListFooterView.h"
#import "UITextView+Placeholder.h"

@interface KKMyEditUserInfoListFooterView ()<UITextViewDelegate>



@end

@implementation KKMyEditUserInfoListFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textView];
        // [kNotificationCenter addObserver:self selector:@selector(textViewTextDidChangeNotification) name:UITextViewTextDidChangeNotification object:nil];
        // [kNotificationCenter addObserver:self selector:@selector(textViewTextDidEndNotification) name:UITextViewTextDidEndEditingNotification object:nil];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.textView.frame = CGRectMake(self.frame.size.width/2-(345/2), 0, 345, 110);
}

-(void)setBasic:(appvapiUserInfoBasic *)basic {
    _basic = basic;
//    self.textView.text = basic.intro;
}

-(void)textViewDidChangeSelection:(UITextView *)textView{
    if (self.textViewTextDidChangeNotificationBlock) {
         self.textViewTextDidChangeNotificationBlock(self.textView.text);
     }
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    
    if (textView.text.length<2) {
//        [SVProgressHUD showMessage:@"最少两个字符呦"];
        return;
    }if (textView.text.length>60){
        [SVProgressHUD showMessage:@"至多60个字符呦"];
        return;
    }
    if (self.textViewTextDidEndNotificationBlock) {
        self.textViewTextDidEndNotificationBlock(textView.text);
    }
}
//-(UITextView *)descptionTextV{
//    if (!_descptionTextV) {
//        _descptionTextV = [[UITextView alloc]init];
//        _descptionTextV.layer.cornerRadius = 11.5;
//        _descptionTextV.layer.masksToBounds = YES;
//        _descptionTextV.backgroundColor = KKRGBA(37, 39, 47, 1);
//        _descptionTextV.delegate = self;
//        _descptionTextV.textColor = [UIColor whiteColor];
//        _descptionTextV.tintColor = [UIColor whiteColor];
//        _descptionTextV.font = [UIFont regularWithSize:14];
//        _descptionTextV.contentInset = UIEdgeInsetsMake(0, 10, 4, 4);
//        _descptionTextV.placeholder = @"这家伙很懒，什么都没有留下";
//        _descptionTextV.placeholderColor = [KKColor getColor:appHintTextColor];
//    }
//    return _descptionTextV;
//}
-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        [_textView setFont:[UIFont mediumWithSize:14]];
        _textView.placeholder = @"这家伙很懒，什么都没有留下";
        if ([KKUserInfo share].intro) {
//            [_textView setText:[KKUserInfo share].intro];
            _textView.placeholder =[KKUserInfo share].intro ;
        }
        
        _textView.layer.masksToBounds = YES;
        [_textView setDelegate:self];
        [_textView.layer setCornerRadius:8];
        _textView.placeholderColor = [KKColor getColor:appHintTextColor];
        _textView.textColor =  [KKColor getColor:appMainTextColor];
        _textView.backgroundColor = [KKColor getColor:appEditTextBgColor];
    }
    return _textView;
}
@end
