//
//  TokenCtrl.h
//  KK
//
//  Created by hk on 2021/6/23.
//

#import <Foundation/Foundation.h>
#import "HeadsConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface TokenCtrl : NSObject

//uc token
@property(strong,nonatomic) NSString* ucToken;

//api token
@property(strong,nonatomic) NSString* apiToken;


//+(NSMutableArray<HeadsConfig*>*)getUcTokenHeads;

-(void)initToken;

-(void)saveUcToken:(NSString * )ucToken;


-(void)saveApiToken:(NSString * )apiToken;

@end

NS_ASSUME_NONNULL_END
