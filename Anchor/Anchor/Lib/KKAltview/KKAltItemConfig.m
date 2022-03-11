//
//  KKAltItemConfig.m
//  KK
//
//  Created by 小草 on 2021/9/1.
//

#import "KKAltItemConfig.h"

@implementation KKAltItemConfig

+(KKAltItemConfig*)initWithItemConfig:(NSString*)buttonName buttonEnable:(BOOL)buttonEnable{
 
    KKAltItemConfig * itemConfig = [[KKAltItemConfig alloc]init];
    itemConfig.buttonName = buttonName;
    itemConfig.buttonEnable = buttonEnable;
    return itemConfig;
}


+(KKAltItemConfig*)initWithCoustomViewItemConfig:(NSString*)buttonName buttonBackGroundColor:(NSString *)buttonBackGroundColor buttonEnable:(BOOL)buttonEnable{
    KKAltItemConfig * itemConfig = [[KKAltItemConfig alloc]init];
    itemConfig.buttonName = buttonName;
    itemConfig.buttonEnable = buttonEnable;
    itemConfig.buttonBackGroundColor = buttonBackGroundColor;
    return itemConfig;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.buttonTextColor = @"#007AFF";
        self.cornerRadius = 10;
        self.buttonBackGroundColor = @"#007AFF";
    }
    return self;
}
@end
