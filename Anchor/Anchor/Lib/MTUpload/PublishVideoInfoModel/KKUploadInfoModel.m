//
//  KKUploadInfoModel.m
//  KK
//
//  Created by 小草 on 2021/7/28.
//

#import "KKUploadInfoModel.h"

@implementation KKUploadInfoModel


-(void)setVideoName:(NSString *)videoName{
    _videoName = videoName;
    [self.fileNameArray addObject:videoName];
}

-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    [self.fileNameArray addObject:imageName];
}

-(void)setFirstImageName:(NSString *)firstImageName{
    _firstImageName = firstImageName;
    [self.fileNameArray addObject:firstImageName];
}

-(NSMutableArray *)fileNameArray{
    if (!_fileNameArray) {
        _fileNameArray = [[NSMutableArray alloc]init];
    }
    return _fileNameArray;
}

// OSS所需要的数据源
-(NSMutableArray *)soucreArray{
    if (!_soucreArray) {
        _soucreArray = [[NSMutableArray alloc]init];
    }
    return _soucreArray;
}
@end


@implementation UploadOSSDataModel



@end
