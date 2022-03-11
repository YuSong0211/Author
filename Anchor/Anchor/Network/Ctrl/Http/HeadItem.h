//
//  HeadItem.h
//  KK
//
//  Created by hk on 2021/8/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    
    xToken = 1,
    xUcChannel = 2,
    xNetCore = 3,
    ContentType = 4,
    ApiToken = 5,
    Applink = 6,
    
}HeadType;

@interface HeadItem : NSObject

-(HeadItem*)initWithDataKey:(NSString*)key value:(NSString*)value type:(HeadType)type;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *value;
@property(assign,nonatomic) HeadType headType;

@end

NS_ASSUME_NONNULL_END
