//
//  UIButton+Extension.m
//  mt
//
//  Created by 小鱼 on 2021/9/17.
//

#import "UIButton+Extension.h"
#import "FileMgr.h"
#import "NSString+Extension.h"

@implementation UIButton (Extension)


- (void)kk_setImageWithUrlString:(NSString *__nonnull)string placeholderImage:(nullable NSString *)placeholderImageName {
    [self checkPath:string placeholderImage:placeholderImageName];
}

/// 检查路径
/// @param urlString 图片url
/// @param placeholderImageName 占位图
- (void)checkPath:(NSString *)urlString placeholderImage:(nullable NSString *)placeholderImageName{
    [self setImage:[UIImage imageNamed:placeholderImageName] forState:UIControlStateNormal];
    NSString *filePath = [NSString stringWithFormat:@"%@%@%@.byte",[self getMainPath],cacheImagePath,[urlString md5]];
    [[FileMgr defaultFileMgr] createDirectorys:filePath];
    if(![FileMgr isfileExit:filePath]) {
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlString parameters:nil error:nil];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        request.timeoutInterval = netWork_timeoutInterval;
        [request.allHTTPHeaderFields setValue:@"application/octet-stream" forKey:@"Content-Type"];
        //end
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:^(NSProgress *downloads){
        } completionHandler:^(NSURLResponse * _Nonnull response, id  responseObject, NSError * _Nullable error) {
            if (!error) {
                NSData *data = [NSData encode:(NSData *)responseObject];
                [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
                [self setImageWith:data];
            }
        }];
        [dataTask resume];
    }else{
        //从本地读取文件
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        [self setImageWith:data];
    }
}

- (void)setImageWith:(NSData *)data {
    UIImage *image = [UIImage imageWithData:data];
    [self setImage:image forState:UIControlStateNormal];

}

///获取主路径
- (NSString *)getMainPath {
    NSString *path = nil;
    // 获取Caches目录路径
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    path = [NSString stringWithFormat:@"%@/",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]];
    return path;
}


@end
