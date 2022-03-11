//
//  UITextField+Extension.m
//  KK
//
//  Created by ProgramMa on 2021/7/28.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)
- (void)calculateTextViewWordNum:(UILabel *)wordsNumTitleLabel num:(NSInteger)num {
    UITextRange *selectedRange = [self markedTextRange];
     // 获取高亮部分
    UITextPosition *pos = [self  positionFromPosition :selectedRange. start offset : 0];
    // 如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return ;
    }
    NSString   *nsTextContent = self.text ;
    NSInteger existTextNum = nsTextContent.length ;
    if (existTextNum > num){
        // 截取到最大位置的字符 ( 由于超出截部分在 should 时被处理了所在这里这了提高效率不再判断 )
        NSString *s = [nsTextContent  substringToIndex :num];
        [self setText:s];
       

    }
    else{
        wordsNumTitleLabel.text = [NSString stringWithFormat:@"%ld/%ld" ,MAX( 0 ,existTextNum),num];
        
    }
     // 不让显示负数
//    wordsNumTitleLabel.text = [NSString stringWithFormat:@"%ld/%ld" ,MAX( 0 , num - existTextNum),num];
    
}
- (void)bbCalculateTextViewWordNum:(UILabel *)wordsNumTitleLabel num:(NSInteger)num {
    UITextRange *selectedRange = [self markedTextRange];
     // 获取高亮部分
    UITextPosition *pos = [self  positionFromPosition :selectedRange. start offset : 0];
    // 如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return ;
    }
    NSString   *nsTextContent = self.text ;
    NSInteger existTextNum = nsTextContent.length ;
    if (existTextNum > num){
        // 截取到最大位置的字符 ( 由于超出截部分在 should 时被处理了所在这里这了提高效率不再判断 )
        NSString *s = [nsTextContent  substringToIndex :num];
        [self setText:s];
    }
    // 不让显示负数
    wordsNumTitleLabel.text = [NSString stringWithFormat:@"%ld" ,existTextNum];
}
@end
