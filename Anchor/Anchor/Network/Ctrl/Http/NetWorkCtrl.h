//
//  NetWorkCtrl.h
//  KK
//
//  Created by hk on 2021/6/23.
//

#import <Foundation/Foundation.h>
#import "HeadsConfig.h"
#import "UcPrimaryApiSign.pbobjc.h"// pb登录请求头文件
#import "GProtoBufferMessage.h"
#import "BaseModel.h"
NS_ASSUME_NONNULL_BEGIN

// 请求状态
typedef enum {
    HttpReqInvied = -1,// 失败
    HttpReqSuccess = 1// 成功
} RequsetStates;

// 请求类型
typedef enum {
    HttpReqGet = 0,// get请求
    HttpReqPost = 1,// post请求
    HttpReqPostTest = 2,// 模拟post请求数据(预留)
    HttpReqGetTest = 3,// 模拟get请求数据(预留)
    ApiUcLogin = 4
} RequsetType;

//请求成功示例
typedef void (^HttpResp)(RequsetStates state,NSData* data);

 

//http 通用请求。 使用pb
@interface NetWorkCtrl : NSObject
+ (instancetype)requestShare;


+ (instancetype)requestShareWithRespose:(GPBMessage*)resp;


//新增请求
+(instancetype)requestWithParams:(id)message;





//通用处理请求
- (NetWorkCtrl*)KK_request:(id)message
                   heads:(nullable NSMutableArray<HeadsConfig *> *)heads
                   requestType:(RequsetType)requestType
                        complete:(OnComplete)complete
                        failed:(OnFailed)failed;
                           
                    


/**
 /// 请求url类型
 /// 1:登录请求 2:其他请求
 */
@property (assign, nonatomic) NSInteger requestStates;

/**
 /// api网络请求
 @param url 请求url
 @param paramsBody 请求headerBody参数
 @param heads 自定义添加请求头
 @param requestType 请求类型
 @param respBlock 返回数据
 */
- (NetWorkCtrl*)KK_requestWhitUrl:(NSString *)url
                    paramsBody:(GPBMessage *)paramsBody
                         heads:(nullable NSMutableArray<HeadsConfig *> *)heads
                   requestType:(RequsetType)requestType
                        respBlock:(HttpResp)respBlock;

/**
 /// api网络请求(登录)
 @param url 请求url
 @param paramsBody 请求headerBody参数
 @param heads 自定义添加请求头
 @param requestType 请求类型
 @param respBlock 返回数据
 */
- (NetWorkCtrl*)KK_requestSignWhitUrl:(NSString *)url
                       paramsBody:(GPBMessage *)paramsBody
                            heads:(nullable NSMutableArray<HeadsConfig *> *)heads
                      requestType:(RequsetType)requestType
                            respBlock:(HttpResp)respBlock;
/**
 /// api网络请求(entwithUC用户信息基类)
 @param url 请求url
 @param paramsBody 请求headerBody参数
 @param heads 自定义添加请求头
 @param requestType 请求类型
 @param respBlock 返回数据
 */
- (NetWorkCtrl*)KK_requestSignTongWhitUrl:(NSString *)url
                       paramsBody:(GPBMessage *)paramsBody
                            heads:(nullable NSMutableArray<HeadsConfig *> *)heads
                      requestType:(RequsetType)requestType
                            respBlock:(HttpResp)respBlock;

 

@end

NS_ASSUME_NONNULL_END
