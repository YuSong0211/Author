//
//  FileMgr.m
//  KK
//
//  Created by hk on 2021/8/16.
//

#import "FileMgr.h"
#include "sys/stat.h"
static FileMgr* instance = NULL;

@implementation FileMgr


//获取实例对象
+ (FileMgr *)defaultFileMgr{
    if(instance == NULL){
        instance = [[FileMgr alloc] init];
    }
    return instance;
}

- (BOOL)createDirectorys:(NSString *)path{
    if(path == NULL){
        return false;
    }
    NSArray* array = [path componentsSeparatedByString:@"/"];
    NSUInteger index = [array indexOfObject:@"Application"];
    NSString* mAppPath = @"";
    ///var/mobile/Containers/Data/Application/A8E0C44C-F40F-4A0C-A508-ACE865D9D4C0/Library/Caches/db/user_PPO.db
    for(int i=0;i<index+2;i++){
        mAppPath = [NSString stringWithFormat:@"%@%@/",mAppPath, array[i]];
    }
    index+=2; 
    NSString* tempPath = mAppPath;
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    for(NSUInteger i=index;i<array.count;i++){
        tempPath = [NSString stringWithFormat:@"%@%@/",tempPath,array[i]];
        if([tempPath containsString:@"."]){
            break;
        }
        bool isDir = NO;
        [fileMgr fileExistsAtPath:tempPath isDirectory:&isDir];
        if(!isDir){
            [fileMgr createDirectoryAtPath:tempPath withIntermediateDirectories:false attributes:nil error:nil];
            
        }
    }
    return true;
}



/// 判断文件是否存在
/// @param path 文件名
+(BOOL)isfileExit:(NSString*)path{
    bool isDir = NO;
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    return [fileMgr fileExistsAtPath:path isDirectory:&isDir];
}


/// 获取文件代销
/// @param filePath 文件路径
- (long long) cfileSizeAtPath:(NSString*) filePath{
    NSString* path = filePath;
    if([path hasPrefix:@"file:///"]){
        path = [path stringByReplacingOccurrencesOfString:@"file:///" withString:@""];
    }
    struct stat st;
    if(lstat([path cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return st.st_size;
    }
    return 0;
}


/// 获取文件大小
/// @param filePath 文件路径
- (long long)fileSizeAtPath:(NSString *)filePath{
    NSString* path = filePath;
    if([path hasPrefix:@"file:///"]){
        path = [path stringByReplacingOccurrencesOfString:@"file:///" withString:@""];
    }
    NSFileManager* manager = [NSFileManager defaultManager];
      if ([manager fileExistsAtPath:path]){
        return [[manager attributesOfItemAtPath:path error:nil] fileSize];
      } 
  return 0;
}



/// 写入本地文件
/// @param string 内容
/// @param fileName 文件名
/// @param append 是否追加
+(void)writeToFileWithString:(NSString*)string withFileName:(NSString*)fileName append:(BOOL)append{
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString* str = nil;
    if (append) {
        if ( [fileManager fileExistsAtPath:fileName]) {

            NSData* data = [NSData dataWithContentsOfFile:fileName];
            str =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            string = [NSString stringWithFormat:@"%@\n%@",str,string];
        }
    }
    [fileManager removeItemAtPath:fileName error:nil]; //直接替换旧文件
    [fileManager createFileAtPath:fileName contents:[ string dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];

}
@end
