//
//  TokenCtrl.m
//  KK
//
//  Created by hk on 2021/6/23.
//

#import "TokenCtrl.h"
#import "NSDefaultUtils.h"
#import "AvatarPlayer.h"
@implementation TokenCtrl

- (void)saveUcToken:(NSString *)ucTokens{
    self.ucToken = ucTokens;
    [NSDefaultUtils setString:default_ucToken :self.ucToken];
}

- (void)saveApiToken:(NSString *)apiTokens{
    self.apiToken = apiTokens;
}


- (void)initToken{
   self.ucToken = [NSDefaultUtils getString:default_ucToken];
}

//获取uc
//+ (NSMutableArray<HeadsConfig *> *)getUcTokenHeads{
//    AvatarPlayer* avatar = [AvatarPlayer init];
//    HeadsConfig *heads = [[HeadsConfig alloc] initWithData:@"token" :avatar.tokenCtrl.ucToken];
//    NSMutableArray<HeadsConfig*>* headlist = [[NSMutableArray alloc]init];
//    [headlist addObject:heads];
//    return headlist;
//}

@end
