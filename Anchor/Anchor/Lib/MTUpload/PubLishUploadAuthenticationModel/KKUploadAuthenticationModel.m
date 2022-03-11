//
//  KKUploadAuthenticationModel.m
//  KK
//
//  Created by 小草 on 2021/8/6.
//

#import "KKUploadAuthenticationModel.h"

@implementation KKUploadAuthenticationModel

-(NSMutableArray *)fileEventsArray{
    if (!_fileEventsArray) {
        _fileEventsArray =[NSMutableArray array];
    }
    
    return _fileEventsArray;
    
}

@end
