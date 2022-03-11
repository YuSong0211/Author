//
//  KKCollor.m
//  mt
//
//  Created by 小鱼 on 2021/9/18.
//

#import "KKColor.h"

@implementation KKColor
+(UIColor*)getColor:(kkColerType)colorType{
    NSString *colorKey = [self getColorKey:colorType];
    NSDictionary *colorDic = [self getJsonDataWith:colorKey];
    if (colorType == appTabUnActiveColor) {
        NSLog(@"");
    }
    NSString *ColorValue = colorDic[@"ColorValue"];
    return [self colorChangeWithColorStr:ColorValue withColorType:colorType];
}

+(UIColor *)colorChangeWithColorStr:(NSString *)colorStr withColorType:(kkColerType)colorType{
    colorStr= [colorStr stringByReplacingCharactersInRange:[colorStr rangeOfString:@"#" ] withString:@"0x"];
    long colorLong = strtoul([colorStr cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);// 通过位与方法获取三色值 
    int R = (colorLong & 0xFF0000 )>>16;
    int G = (colorLong & 0x00FF00 )>>8;
    int B =  colorLong & 0x0000FF;
    UIColor *wordColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
    if(colorType == appHintTextColor){
        
    }
//    if (colorType == colorVideoTabUnSelectedText) {
//     wordColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:0.7];
//    }
//    else if(colorType == appHintTextColor){
//        wordColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:0.5];
//    }
//    else{
//    wordColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
//    }
    return wordColor;
}

+(UIColor *)colorWithstr:(NSString *)colorStr{
    colorStr= [colorStr stringByReplacingCharactersInRange:[colorStr rangeOfString:@"#" ] withString:@"0x"];
    long colorLong = strtoul([colorStr cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);// 通过位与方法获取三色值
    int R = (colorLong & 0xFF0000 )>>16;
    int G = (colorLong & 0x00FF00 )>>8;
    int B =  colorLong & 0x0000FF;
    UIColor *wordColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
    return wordColor;
}

+(NSDictionary *)getJsonDataWith:(NSString *)dicKey{
    if (dicKey == @"appHintTextColor") {
        NSLog(@"");
    }
    NSString *mainBundleDirectory=[[NSBundle mainBundle] bundlePath];
    NSString *path=[mainBundleDirectory stringByAppendingPathComponent:@"appcolor.json"];
    NSURL *url=[NSURL fileURLWithPath:path];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *colorDic = dic[@"color"][dicKey];
    return colorDic;
}
+(NSString *)getColorKey:(kkColerType)colerType{
    switch (colerType) {
        case appBgColor:
            return @"appBgColor";
            break;
        case appMainTextColor:
            return @"appMainTextColor";
            break;
        case appHintTextColor:
            return @"appHintTextColor";
            break;
        case appTextBgColor:
            return @"appTextBgColor";
            break;
        case appEditTextBgColor:
            return @"appEditTextBgColor";
            break;
        case appMainCardBgColor:
            return @"appMainCardBgColor";
            break;
        case appTabUnActiveColor:
            return @"appTabUnActiveColor";
            break;
        case appTabActiveColor:
            return @"appTabActiveColor";
            break;
        case appTabBgColor:
            return @"appTabBgColor";
            break;
        case colorPrimary:
            return @"colorPrimary";
            break;
        case colorPrimaryDark:
            return @"colorPrimaryDark";
            break;
        case colorAccent:
            return @"colorAccent";
            break;
        case colorMainBtnText:
            return @"colorMainBtnText";
            break;
        case colorSecondBtnText:
            return @"colorSecondBtnText";
            break;
        case colorSecondBtnBg:
            return @"colorSecondBtnBg";
            break;
        case colorPlayerSeekBarProgress:
            return @"colorPlayerSeekBarProgress";
            break;
        case colorPlayerSeekBarBg:
            return @"colorPlayerSeekBarBg";
            break;
        case colorLoadingLeft:
            return @"colorLoadingLeft";
            break;
        case colorLoadingRight:
            return @"colorLoadingRight";
            break;
        case colorChatLeftBg:
            return @"colorChatLeftBg";
            break;
        case colorChatRightBg:
            return @"colorChatRightBg";
            break;
        case colorChatLeftText:
            return @"colorChatLeftText";
            break;
        case colorChatRightText:
            return @"colorChatRightText";
            break;
        case colorChatTextBtn:
            return @"colorChatTextBtn";
            break;
        case colorVideoRankBtnSelectedBg:
            return @"colorVideoRankBtnSelectedBg";
            break;
        case colorVideoRankBtnSelectedText:
            return @"colorVideoRankBtnSelectedText";
            break;
        case colorVideoRankBtnUnSelectedText:
            return @"colorVideoRankBtnUnSelectedText";
            break;
        case colorVideoTabBg:
            return @"colorVideoTabBg";
            break;
        case colorVideoTabSelectedText:
            return @"colorVideoTabSelectedText";
            break;
        case colorVideoTabUnSelectedText:
            return @"colorVideoTabUnSelectedText";
            break;
        case colorTextBtn:
            return @"colorTextBtn";
            break;
        case colorTextSilver:
            return @"colorTextSilver";
            break;
        case colorTextGold:
            return @"colorTextGold";
            break;
        case colorDialogBg:
            return @"colorDialogBg";
            break;
        case colorDialogBtnBg:
            return @"colorDialogBtnBg";
            break;
        case memberalerAlertBgColor:
            return @"memberalerAlertBgColor";
            break;
        case memberalertAlertTitleColor:
            return @"memberalertAlertTitleColor";
            break;
        case memberalertAlertTextColor:
            return @"memberalertAlertTextColor";
            break;
        case memberalertAlertExtensionColor:
            return @"memberalertAlertExtensionColor";
            break;
        case memberalertAlertExtensionDarkColor:
            return @"memberalertAlertExtensionDarkColor";
            break;
        case memberalertAlertBuyColor:
            return @"memberalertAlertBuyColor";
            break;
        case memberalertAlertBuyDarkColor:
            return @"memberalertAlertBuyDarkColor";
            break;
        default:
            break;
    }
}


+ (NSString *)hexadecimalFromUIColor: (UIColor*) color {
    if(CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components =CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    if(CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) !=kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    NSString *r,*g,*b;
    (int)((CGColorGetComponents(color.CGColor))[0]*255.0) == 0?(r =[NSString stringWithFormat:@"0%x",(int)((CGColorGetComponents(color.CGColor))[0]*255.0)]):(r= [NSString stringWithFormat:@"%x",(int)((CGColorGetComponents(color.CGColor))[0]*255.0)]);
    (int)((CGColorGetComponents(color.CGColor))[1]*255.0)== 0?(g = [NSString stringWithFormat:@"0%x",(int)((CGColorGetComponents(color.CGColor))[1]*255.0)]):(g= [NSString stringWithFormat:@"%x",(int)((CGColorGetComponents(color.CGColor))[1]*255.0)]);
    (int)((CGColorGetComponents(color.CGColor))[2]*255.0)== 0?(b = [NSString stringWithFormat:@"0%x",(int)((CGColorGetComponents(color.CGColor))[2]*255.0)]):(b= [NSString stringWithFormat:@"%x",(int)((CGColorGetComponents(color.CGColor))[2]*255.0)]);
    return [NSString stringWithFormat:@"#%@%@%@",r,g,b];
}

@end


