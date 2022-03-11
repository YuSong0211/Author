// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: gateway_grpc_wrapper(1).proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30004
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30004 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

@class gatewayGrpcUnaryBody;
@class gatewayGrpcUnaryGatewayCommand;
@class gatewayGrpcUnaryGatewayCommandAuth;
@class gatewayGrpcUnaryGatewayCommandPing;
@class gatewayGrpcUnaryGatewayCommandReconnect;
@class gatewayGrpcUnaryHeader;
@class gatewayGrpcUnaryRequest;
@class gatewayGrpcUnaryResponseContextBody;
@class gatewayGrpcUnaryResponseInitiativeBody;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum gatewayGrpcUnaryProtocolError

/** grpc 代理到后台 server 后台server 返回的 grpc 错误码 */
typedef GPB_ENUM(gatewayGrpcUnaryProtocolError) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  gatewayGrpcUnaryProtocolError_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  gatewayGrpcUnaryProtocolError_Ok = 0,
  gatewayGrpcUnaryProtocolError_Canceled = 1,
  gatewayGrpcUnaryProtocolError_Unknown = 2,
  gatewayGrpcUnaryProtocolError_InvalidArgument = 3,
  gatewayGrpcUnaryProtocolError_DeadlineExceeded = 4,
  gatewayGrpcUnaryProtocolError_NotFound = 5,
  gatewayGrpcUnaryProtocolError_AlreadyExists = 6,
  gatewayGrpcUnaryProtocolError_PermissionDenied = 7,
  gatewayGrpcUnaryProtocolError_Unauthenticated = 8,
  gatewayGrpcUnaryProtocolError_ResourceExhausted = 9,
  gatewayGrpcUnaryProtocolError_FailedPrecondition = 10,
  gatewayGrpcUnaryProtocolError_Aborted = 11,
  gatewayGrpcUnaryProtocolError_OutOfRange = 12,
  gatewayGrpcUnaryProtocolError_Unimplemented = 13,
  gatewayGrpcUnaryProtocolError_Internal = 14,
  gatewayGrpcUnaryProtocolError_Unavailable = 15,
  gatewayGrpcUnaryProtocolError_DataLoss = 16,
};

GPBEnumDescriptor *gatewayGrpcUnaryProtocolError_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL gatewayGrpcUnaryProtocolError_IsValidValue(int32_t value);

#pragma mark - gatewayGatewayGrpcWrapper1Root

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
GPB_FINAL @interface gatewayGatewayGrpcWrapper1Root : GPBRootObject
@end

#pragma mark - gatewayGrpcUnaryRequests

typedef GPB_ENUM(gatewayGrpcUnaryRequests_FieldNumber) {
  gatewayGrpcUnaryRequests_FieldNumber_RequestId = 1,
  gatewayGrpcUnaryRequests_FieldNumber_Request = 2,
  gatewayGrpcUnaryRequests_FieldNumber_Command = 3,
};

typedef GPB_ENUM(gatewayGrpcUnaryRequests_RequestBody_OneOfCase) {
  gatewayGrpcUnaryRequests_RequestBody_OneOfCase_GPBUnsetOneOfCase = 0,
  gatewayGrpcUnaryRequests_RequestBody_OneOfCase_Request = 2,
  gatewayGrpcUnaryRequests_RequestBody_OneOfCase_Command = 3,
};

/**
 * 在 gateway v1 java 版本上对该协议进行更好的抽象
 **/
GPB_FINAL @interface gatewayGrpcUnaryRequests : GPBMessage

/** 客户端自定确保请求的队列 ID 在 ack body 原封不动的返回 */
@property(nonatomic, readwrite) uint64_t requestId;

/** 请求的消息体 */
@property(nonatomic, readonly) gatewayGrpcUnaryRequests_RequestBody_OneOfCase requestBodyOneOfCase;

/** fixme 该协议目前暂时不支持 */
@property(nonatomic, readwrite, strong, null_resettable) gatewayGrpcUnaryRequest *request;

/** 网关本身的协议命令 */
@property(nonatomic, readwrite, strong, null_resettable) gatewayGrpcUnaryGatewayCommand *command;

@end

/**
 * Clears whatever value was set for the oneof 'requestBody'.
 **/
void gatewayGrpcUnaryRequests_ClearRequestBodyOneOfCase(gatewayGrpcUnaryRequests *message);

#pragma mark - gatewayGrpcUnaryRequest

typedef GPB_ENUM(gatewayGrpcUnaryRequest_FieldNumber) {
  gatewayGrpcUnaryRequest_FieldNumber_ServiceFullName = 1,
  gatewayGrpcUnaryRequest_FieldNumber_Body = 2,
};

GPB_FINAL @interface gatewayGrpcUnaryRequest : GPBMessage

/** grpc 请求地址, 全路径 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *serviceFullName;

/** 请求 body 信息 */
@property(nonatomic, readwrite, strong, null_resettable) gatewayGrpcUnaryBody *body;
/** Test to see if @c body has been set. */
@property(nonatomic, readwrite) BOOL hasBody;

@end

#pragma mark - gatewayGrpcUnaryResponse

typedef GPB_ENUM(gatewayGrpcUnaryResponse_FieldNumber) {
  gatewayGrpcUnaryResponse_FieldNumber_ServerTime = 1,
  gatewayGrpcUnaryResponse_FieldNumber_ContextBody = 2,
  gatewayGrpcUnaryResponse_FieldNumber_StreamBody = 3,
};

/**
 * 回复消息给 客户端
 **/
GPB_FINAL @interface gatewayGrpcUnaryResponse : GPBMessage

/**
 * 时间戳 秒/仅心跳时返回 该字段大于 0 则无须进一步解析,该消息是 pong 消息
 * 设置使用 wb socket ping/pong
 **/
@property(nonatomic, readwrite) uint64_t serverTime;

/**
 * contextBody ,initiativeBody 可能同时存在，后期扩展 支持 在一次请求返回要推送的数据
 * contextBody header: traceId: xxx222222222222
 * 服务器正常响应的
 **/
@property(nonatomic, readwrite, strong, null_resettable) gatewayGrpcUnaryResponseContextBody *contextBody;
/** Test to see if @c contextBody has been set. */
@property(nonatomic, readwrite) BOOL hasContextBody;

/** 服务器主动响应的数据 */
@property(nonatomic, readwrite, strong, null_resettable) gatewayGrpcUnaryResponseInitiativeBody *streamBody;
/** Test to see if @c streamBody has been set. */
@property(nonatomic, readwrite) BOOL hasStreamBody;

@end

#pragma mark - gatewayGrpcUnaryResponseContextBody

typedef GPB_ENUM(gatewayGrpcUnaryResponseContextBody_FieldNumber) {
  gatewayGrpcUnaryResponseContextBody_FieldNumber_GrpcError = 1,
  gatewayGrpcUnaryResponseContextBody_FieldNumber_RequestId = 2,
  gatewayGrpcUnaryResponseContextBody_FieldNumber_Body = 3,
};

/**
 * 上下文回复，针对，客户端请求的回复
 **/
GPB_FINAL @interface gatewayGrpcUnaryResponseContextBody : GPBMessage

/** 请求响应的错误码 该错误码为协议层错误码，业务层错误码 可以通过 header 自行定义 */
@property(nonatomic, readwrite) gatewayGrpcUnaryProtocolError grpcError;

/** 客户端自定确保请求的队列 ID 在 ack body 原封不动的返回 */
@property(nonatomic, readwrite) uint64_t requestId;

/**
 * header 会包含集群调度的错误详细信息 仅 debug 模式下返回
 * protocol-error-message: fatal error
 * 返回的 body header 会加上 x- 为前缀
 **/
@property(nonatomic, readwrite, strong, null_resettable) gatewayGrpcUnaryBody *body;
/** Test to see if @c body has been set. */
@property(nonatomic, readwrite) BOOL hasBody;

@end

/**
 * Fetches the raw value of a @c gatewayGrpcUnaryResponseContextBody's @c grpcError property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t gatewayGrpcUnaryResponseContextBody_GrpcError_RawValue(gatewayGrpcUnaryResponseContextBody *message);
/**
 * Sets the raw value of an @c gatewayGrpcUnaryResponseContextBody's @c grpcError property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetgatewayGrpcUnaryResponseContextBody_GrpcError_RawValue(gatewayGrpcUnaryResponseContextBody *message, int32_t value);

#pragma mark - gatewayGrpcUnaryResponseInitiativeBody

typedef GPB_ENUM(gatewayGrpcUnaryResponseInitiativeBody_FieldNumber) {
  gatewayGrpcUnaryResponseInitiativeBody_FieldNumber_EventName = 1,
  gatewayGrpcUnaryResponseInitiativeBody_FieldNumber_Body = 2,
};

/**
 * 这个是服务端主动回复的消息
 **/
GPB_FINAL @interface gatewayGrpcUnaryResponseInitiativeBody : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *eventName;

@property(nonatomic, readwrite, strong, null_resettable) gatewayGrpcUnaryBody *body;
/** Test to see if @c body has been set. */
@property(nonatomic, readwrite) BOOL hasBody;

@end

#pragma mark - gatewayGrpcUnaryGatewayCommand

typedef GPB_ENUM(gatewayGrpcUnaryGatewayCommand_FieldNumber) {
  gatewayGrpcUnaryGatewayCommand_FieldNumber_Ping = 1,
  gatewayGrpcUnaryGatewayCommand_FieldNumber_Auth = 2,
  gatewayGrpcUnaryGatewayCommand_FieldNumber_Reconnect = 3,
};

typedef GPB_ENUM(gatewayGrpcUnaryGatewayCommand_Command_OneOfCase) {
  gatewayGrpcUnaryGatewayCommand_Command_OneOfCase_GPBUnsetOneOfCase = 0,
  gatewayGrpcUnaryGatewayCommand_Command_OneOfCase_Ping = 1,
  gatewayGrpcUnaryGatewayCommand_Command_OneOfCase_Auth = 2,
  gatewayGrpcUnaryGatewayCommand_Command_OneOfCase_Reconnect = 3,
};

/**
 * 网关本身的登录，业务层的ping，重连等接口操作
 **/
GPB_FINAL @interface gatewayGrpcUnaryGatewayCommand : GPBMessage

@property(nonatomic, readonly) gatewayGrpcUnaryGatewayCommand_Command_OneOfCase commandOneOfCase;

/**
 * ping
 * 也可以使用 websocket 自带的 ping 帧
 **/
@property(nonatomic, readwrite, strong, null_resettable) gatewayGrpcUnaryGatewayCommandPing *ping;

/** 登录认证 */
@property(nonatomic, readwrite, strong, null_resettable) gatewayGrpcUnaryGatewayCommandAuth *auth;

/** 重连 */
@property(nonatomic, readwrite, strong, null_resettable) gatewayGrpcUnaryGatewayCommandReconnect *reconnect;

@end

/**
 * Clears whatever value was set for the oneof 'command'.
 **/
void gatewayGrpcUnaryGatewayCommand_ClearCommandOneOfCase(gatewayGrpcUnaryGatewayCommand *message);

#pragma mark - gatewayGrpcUnaryGatewayCommandPing

/**
 * --------------------------------------------------- 网关本身的行为 -----------------------------------------------------
 * ping
 * 只是语义字段, client 可以不用处理
 **/
GPB_FINAL @interface gatewayGrpcUnaryGatewayCommandPing : GPBMessage

@end

#pragma mark - gatewayGrpcUnaryGatewayCommandPong

/**
 * GrpcUnaryResponse.contextBody 返回 pong
 **/
GPB_FINAL @interface gatewayGrpcUnaryGatewayCommandPong : GPBMessage

@end

#pragma mark - gatewayGrpcUnaryGatewayCommandAuth

typedef GPB_ENUM(gatewayGrpcUnaryGatewayCommandAuth_FieldNumber) {
  gatewayGrpcUnaryGatewayCommandAuth_FieldNumber_Appkey = 1,
  gatewayGrpcUnaryGatewayCommandAuth_FieldNumber_Token = 2,
};

/**
 * 网关 认证
 * GrpcUnaryResponse.contextBody = GrpcUnaryGatewayCommandResponseBodyAuth
 **/
GPB_FINAL @interface gatewayGrpcUnaryGatewayCommandAuth : GPBMessage

/** authToken */
@property(nonatomic, readwrite, copy, null_resettable) NSString *appkey;

/** 如果使用jwt 模式则需要保证 sdk uid 全局唯一 appkey 仅做标识作用 jwt 需要包含 uid(long) */
@property(nonatomic, readwrite, copy, null_resettable) NSString *token;

@end

#pragma mark - gatewayGrpcUnaryGatewayCommandReconnect

typedef GPB_ENUM(gatewayGrpcUnaryGatewayCommandReconnect_FieldNumber) {
  gatewayGrpcUnaryGatewayCommandReconnect_FieldNumber_Appkey = 1,
  gatewayGrpcUnaryGatewayCommandReconnect_FieldNumber_ReconnectAuthToken = 2,
};

/**
 * 重连网关
 * GrpcUnaryResponse.contextBody = GrpcUnaryGatewayCommandResponseBodyAuth
 **/
GPB_FINAL @interface gatewayGrpcUnaryGatewayCommandReconnect : GPBMessage

/**
 * 网关本身的认证 token 重连时使用
 * authToken
 **/
@property(nonatomic, readwrite, copy, null_resettable) NSString *appkey;

/** GrpcUnaryGatewayCommandAuth 成功之后返回的 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *reconnectAuthToken;

@end

#pragma mark - gatewayGrpcUnaryGatewayCommandResponseBodyAuth

typedef GPB_ENUM(gatewayGrpcUnaryGatewayCommandResponseBodyAuth_FieldNumber) {
  gatewayGrpcUnaryGatewayCommandResponseBodyAuth_FieldNumber_ReconnectAuthToken = 1,
};

/**
 * 登录和重连返回的 body
 **/
GPB_FINAL @interface gatewayGrpcUnaryGatewayCommandResponseBodyAuth : GPBMessage

/** 会返回刷新之后的 网关 token */
@property(nonatomic, readwrite, copy, null_resettable) NSString *reconnectAuthToken;

@end

#pragma mark - gatewayGrpcUnaryHeader

typedef GPB_ENUM(gatewayGrpcUnaryHeader_FieldNumber) {
  gatewayGrpcUnaryHeader_FieldNumber_Key = 1,
  gatewayGrpcUnaryHeader_FieldNumber_ValueArray = 2,
};

/**
 * ----------------------------------------------------- 通用定义 --------------------------------------------------------
 **/
GPB_FINAL @interface gatewayGrpcUnaryHeader : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *key;

/** 这个 完全兼容 http 协议 header value 允许多个值 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *valueArray;
/** The number of items in @c valueArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger valueArray_Count;

@end

#pragma mark - gatewayGrpcUnaryBody

typedef GPB_ENUM(gatewayGrpcUnaryBody_FieldNumber) {
  gatewayGrpcUnaryBody_FieldNumber_HeadersArray = 1,
  gatewayGrpcUnaryBody_FieldNumber_Body = 2,
};

GPB_FINAL @interface gatewayGrpcUnaryBody : GPBMessage

/** 头信息 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<gatewayGrpcUnaryHeader*> *headersArray;
/** The number of items in @c headersArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger headersArray_Count;

/**
 * 请求的 body
 * 在 rpc 传书中 body 不拆包就足够了
 * 头信息会被拆包，对整体效率影响不大
 **/
@property(nonatomic, readwrite, copy, null_resettable) NSData *body;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
