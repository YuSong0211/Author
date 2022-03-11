//
//  MenuItem.m
//  KK
//
//  Created by hk on 2021/6/24.
//

#import "MenuItem.h"

@implementation MenuItem

- (MenuItem*)initWithParam:(NSString *)p_title :(NSString *)p_content :(int)p_index :(BOOL)p_hasmesh{
    self.title = p_title;
    self.content = p_content;
    self.index = p_index;
    self.hasMesh = p_hasmesh;
    return  self;
}

@end
