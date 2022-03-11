//
//  AppLinkDomainConfig.m
//  KK
//
//  Created by hk on 2021/9/1.
//

#import "AppLinkDomainConfig.h"
#define mConfigPath @"domain/domain.ini"
//#import "richers.h"
@implementation AppLinkDomainConfig
    

/// 读取域名配置文件
//-(NSString*)start{
//    NSString* filePath = [NSString stringWithFormat:@"%@%@",KKConfigPath,mConfigPath];
//    NSString* content = @"";
//    [self createDirectorys:filePath];
//    //先创建好目录
//    if(![FileMgr isfileExit:filePath]){
//        //如果文件不存在,就要写入文件
//         NSString* addr =  [[NSBundle mainBundle] pathForResource:@"domain" ofType:@"json"];
//         NSData *data = [[NSData alloc] initWithContentsOfFile:addr];
//         content =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//        [FileMgr writeToFileWithString:content withFileName:filePath append:NO];
//    }
//    else{
//        //从本地读取文件
//        content = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    }
//    return content;
//    NSString* content = [richers getDoaminData];
//    if([content isEqual:@""]){
//        //如果文件不存在,就要写入文件
//         NSString* addr =  [[NSBundle mainBundle] pathForResource:@"domain" ofType:@"json"];
//         NSData *data = [[NSData alloc] initWithContentsOfFile:addr];
//         content =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//         [richers refreshDomainData:content];
//    }
//    return content;
//}

- (void)refehCache:(NSString *)content{
    NSString* filePath = [NSString stringWithFormat:@"%@%@",KKConfigPath,mConfigPath];
    [FileMgr writeToFileWithString:content withFileName:filePath append:NO];
//    [richers refreshDomainData:content];
}
 
@end

