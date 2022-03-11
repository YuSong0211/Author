//
//  UIImageView+Extension.m
//  KK
//
//  Created by Gwynne on 2021/7/8.
//

#import "UIImageView+Extension.h"
#import "FileMgr.h"
#import "NSString+Extension.h"

@implementation UIImageView (Extension)

- (void)setImageWithUrlString:(NSString *__nonnull)string animated:(BOOL)animated {
    [self kk_setImageWithUrlString:string placeholderImage:@""];
}

- (void)setImageWithUrlString:(NSString *__nonnull)string placeholderImage:(nullable NSString *)placeholderImageName animated:(BOOL)animated  {
    [self kk_setImageWithUrlString:string placeholderImage:placeholderImageName];
}

- (void)kk_setImageWithUrlString:(NSString *__nonnull)string placeholderImage:(nullable NSString *)placeholderImageName  {
    
    [SDWebImageDownloader sharedDownloader].config.urlCredential = [KKTool myUrlCredential];
    
    NSString *url = string;
//    if (([string rangeOfString:@"https://"].location !=NSNotFound)) {
//        url = [string stringByReplacingOccurrencesOfString:@"https://" withString:@"http://"];
//    }
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[KKTool decodeResourceFileImageName:placeholderImageName] options:SDWebImageAllowInvalidSSLCertificates completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        
    }];
}
- (void)kk_setImageWithUrlString:(NSString *__nonnull)string placeholderImage:(nullable NSString *)placeholderImageName WithcompletedBlock:(void (^)(void))completedBlock {
    NSString *url = string;
    if (([string rangeOfString:@"https://"].location !=NSNotFound)) {
        url = [string stringByReplacingOccurrencesOfString:@"https://" withString:@"http://"];
    }
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[KKTool decodeResourceFileImageName:placeholderImageName] options:SDWebImageAllowInvalidSSLCertificates completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        completedBlock();
    }];
}
@end
