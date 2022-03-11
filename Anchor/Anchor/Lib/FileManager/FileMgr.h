//
//  FileMgr.h
//  KK
//
//  Created by hk on 2021/8/16.
//

#import <Foundation/Foundation.h>

//文件管理类，可以创建多级文件夹
NS_ASSUME_NONNULL_BEGIN

@interface FileMgr : NSObject
    
//获取实例
+(FileMgr*)defaultFileMgr;

//创建目录
-(BOOL)createDirectorys:(NSString*) path;



/// 获取文件大小
/// @param filePath 文件路径
-(long long) fileSizeAtPath:(NSString*) filePath;

/// 获取文件代销
/// @param filePath 文件路径
- (long long) cfileSizeAtPath:(NSString*) filePath;

/// 判断文件是否存在
/// @param path 文件名
+(BOOL)isfileExit:(NSString*)path;


/// 写入本地文件
/// @param string 内容
/// @param fileName 文件名
/// @param append 是否追加
+(void)writeToFileWithString:(NSString*)string withFileName:(NSString*)fileName append:(BOOL)append;
@end

NS_ASSUME_NONNULL_END
