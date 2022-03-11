// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: appv-primary-api-customer.proto

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

@class appvapiCustomerServiceCategories;
@class appvapiCustomerServiceCategory;
@class appvapiIdEncode;
@class appvapiMIMEInfo;
@class appvapiOssEvents;
@class appvapiQuestion;
@class appvapiUnreadWorkOrders;
@class appvapiUserInfoBasic;
@class appvapiWorkOrder;
@class appvapiWorkOrderInstantMessage;
GPB_ENUM_FWD_DECLARE(appvapiWorkOrderStatus);

NS_ASSUME_NONNULL_BEGIN

#pragma mark - appvapiAppvPrimaryApiCustomerRoot

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
GPB_FINAL @interface appvapiAppvPrimaryApiCustomerRoot : GPBRootObject
@end

#pragma mark - appvapiListWorkOrderImResponse

typedef GPB_ENUM(appvapiListWorkOrderImResponse_FieldNumber) {
  appvapiListWorkOrderImResponse_FieldNumber_WorkOrderInstantMessagesArray = 1,
};

GPB_FINAL @interface appvapiListWorkOrderImResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<appvapiWorkOrderInstantMessage*> *workOrderInstantMessagesArray;
/** The number of items in @c workOrderInstantMessagesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger workOrderInstantMessagesArray_Count;

@end

#pragma mark - appvapiReadImRequest

typedef GPB_ENUM(appvapiReadImRequest_FieldNumber) {
  appvapiReadImRequest_FieldNumber_WorkOrderId = 1,
  appvapiReadImRequest_FieldNumber_WorkOrderImId = 2,
};

/**
 * 读取更多IM 消息请求参数
 **/
GPB_FINAL @interface appvapiReadImRequest : GPBMessage

/** 工单 id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *workOrderId;
/** Test to see if @c workOrderId has been set. */
@property(nonatomic, readwrite) BOOL hasWorkOrderId;

/** 工单IM id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *workOrderImId;
/** Test to see if @c workOrderImId has been set. */
@property(nonatomic, readwrite) BOOL hasWorkOrderImId;

@end

#pragma mark - appvapiWorkOrderDetailResponse

typedef GPB_ENUM(appvapiWorkOrderDetailResponse_FieldNumber) {
  appvapiWorkOrderDetailResponse_FieldNumber_WorkOrder = 1,
  appvapiWorkOrderDetailResponse_FieldNumber_WorkOrderInstantMessagesArray = 2,
};

/**
 * 客户端 返回所有 问题类型 及其 对应问题 的列表
 **/
GPB_FINAL @interface appvapiWorkOrderDetailResponse : GPBMessage

/** 工单详情 */
@property(nonatomic, readwrite, strong, null_resettable) appvapiWorkOrder *workOrder;
/** Test to see if @c workOrder has been set. */
@property(nonatomic, readwrite) BOOL hasWorkOrder;

/** 工单互动消息集合 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<appvapiWorkOrderInstantMessage*> *workOrderInstantMessagesArray;
/** The number of items in @c workOrderInstantMessagesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger workOrderInstantMessagesArray_Count;

@end

#pragma mark - appvapiCreateWorkOrderResponse

typedef GPB_ENUM(appvapiCreateWorkOrderResponse_FieldNumber) {
  appvapiCreateWorkOrderResponse_FieldNumber_WorkOrderId = 1,
  appvapiCreateWorkOrderResponse_FieldNumber_OssEvents = 2,
};

/**
 * 创建工单返回参数
 **/
GPB_FINAL @interface appvapiCreateWorkOrderResponse : GPBMessage

/** 工单Id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *workOrderId;
/** Test to see if @c workOrderId has been set. */
@property(nonatomic, readwrite) BOOL hasWorkOrderId;

/** Oss内容信息 */
@property(nonatomic, readwrite, strong, null_resettable) appvapiOssEvents *ossEvents;
/** Test to see if @c ossEvents has been set. */
@property(nonatomic, readwrite) BOOL hasOssEvents;

@end

#pragma mark - appvapiListAllQuestionGroupByCategoryResponse

typedef GPB_ENUM(appvapiListAllQuestionGroupByCategoryResponse_FieldNumber) {
  appvapiListAllQuestionGroupByCategoryResponse_FieldNumber_CategoriesArray = 1,
};

/**
 * 客户端 返回所有 问题类型 及其 对应问题 的列表
 **/
GPB_FINAL @interface appvapiListAllQuestionGroupByCategoryResponse : GPBMessage

/** 问题列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<appvapiCustomerServiceCategories*> *categoriesArray;
/** The number of items in @c categoriesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger categoriesArray_Count;

@end

#pragma mark - appvapiCreateWorkOrderRequest

typedef GPB_ENUM(appvapiCreateWorkOrderRequest_FieldNumber) {
  appvapiCreateWorkOrderRequest_FieldNumber_CategoryId = 1,
  appvapiCreateWorkOrderRequest_FieldNumber_DescribeContent = 2,
  appvapiCreateWorkOrderRequest_FieldNumber_DescribeImagesArray = 3,
};

/**
 * 创建工单请求参数
 **/
GPB_FINAL @interface appvapiCreateWorkOrderRequest : GPBMessage

/** 问题类型Id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *categoryId;
/** Test to see if @c categoryId has been set. */
@property(nonatomic, readwrite) BOOL hasCategoryId;

/** 工单描述内容 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *describeContent;

/** 工单图片内容 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<appvapiMIMEInfo*> *describeImagesArray;
/** The number of items in @c describeImagesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger describeImagesArray_Count;

@end

#pragma mark - appvapiListMyWorkOrderResponse

typedef GPB_ENUM(appvapiListMyWorkOrderResponse_FieldNumber) {
  appvapiListMyWorkOrderResponse_FieldNumber_WorkOrdersArray = 1,
};

/**
 * 工单集合返回参数
 **/
GPB_FINAL @interface appvapiListMyWorkOrderResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<appvapiWorkOrder*> *workOrdersArray;
/** The number of items in @c workOrdersArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger workOrdersArray_Count;

@end

#pragma mark - appvapiCheckUnreadMessagesResponse

typedef GPB_ENUM(appvapiCheckUnreadMessagesResponse_FieldNumber) {
  appvapiCheckUnreadMessagesResponse_FieldNumber_UnreadWorkOrderssArray = 1,
};

/**
 * 未读消息工单返回参数
 **/
GPB_FINAL @interface appvapiCheckUnreadMessagesResponse : GPBMessage

/** 工单Id集合 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<appvapiUnreadWorkOrders*> *unreadWorkOrderssArray;
/** The number of items in @c unreadWorkOrderssArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger unreadWorkOrderssArray_Count;

@end

#pragma mark - appvapiUnreadWorkOrders

typedef GPB_ENUM(appvapiUnreadWorkOrders_FieldNumber) {
  appvapiUnreadWorkOrders_FieldNumber_Id_p = 1,
  appvapiUnreadWorkOrders_FieldNumber_WorkOrderStatus = 2,
  appvapiUnreadWorkOrders_FieldNumber_Time = 3,
};

GPB_FINAL @interface appvapiUnreadWorkOrders : GPBMessage

/** 工单Id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *id_p;
/** Test to see if @c id_p has been set. */
@property(nonatomic, readwrite) BOOL hasId_p;

/** 工单状态 */
@property(nonatomic, readwrite) enum appvapiWorkOrderStatus workOrderStatus;

/** 工单回复时间 */
@property(nonatomic, readwrite) uint64_t time;

@end

/**
 * Fetches the raw value of a @c appvapiUnreadWorkOrders's @c workOrderStatus property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t appvapiUnreadWorkOrders_WorkOrderStatus_RawValue(appvapiUnreadWorkOrders *message);
/**
 * Sets the raw value of an @c appvapiUnreadWorkOrders's @c workOrderStatus property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetappvapiUnreadWorkOrders_WorkOrderStatus_RawValue(appvapiUnreadWorkOrders *message, int32_t value);

#pragma mark - appvapiWorkOrder

typedef GPB_ENUM(appvapiWorkOrder_FieldNumber) {
  appvapiWorkOrder_FieldNumber_Id_p = 1,
  appvapiWorkOrder_FieldNumber_UserInfo = 2,
  appvapiWorkOrder_FieldNumber_Category = 3,
  appvapiWorkOrder_FieldNumber_WorkOrderStatus = 5,
  appvapiWorkOrder_FieldNumber_DescribeContent = 6,
  appvapiWorkOrder_FieldNumber_DescribeImagesArray = 7,
  appvapiWorkOrder_FieldNumber_StartTime = 8,
  appvapiWorkOrder_FieldNumber_IsRead = 9,
};

/**
 * 工单对象
 **/
GPB_FINAL @interface appvapiWorkOrder : GPBMessage

/** 工单Id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *id_p;
/** Test to see if @c id_p has been set. */
@property(nonatomic, readwrite) BOOL hasId_p;

/** 用户 */
@property(nonatomic, readwrite, strong, null_resettable) appvapiUserInfoBasic *userInfo;
/** Test to see if @c userInfo has been set. */
@property(nonatomic, readwrite) BOOL hasUserInfo;

/** 问题类型 */
@property(nonatomic, readwrite, strong, null_resettable) appvapiCustomerServiceCategory *category;
/** Test to see if @c category has been set. */
@property(nonatomic, readwrite) BOOL hasCategory;

/** 工单状态 */
@property(nonatomic, readwrite) enum appvapiWorkOrderStatus workOrderStatus;

/** 客户描述内容 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *describeContent;

/** 描述附图Url 存json */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<appvapiMIMEInfo*> *describeImagesArray;
/** The number of items in @c describeImagesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger describeImagesArray_Count;

/** 发起时间 */
@property(nonatomic, readwrite) uint64_t startTime;

/** 是否已读 */
@property(nonatomic, readwrite) BOOL isRead;

@end

/**
 * Fetches the raw value of a @c appvapiWorkOrder's @c workOrderStatus property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t appvapiWorkOrder_WorkOrderStatus_RawValue(appvapiWorkOrder *message);
/**
 * Sets the raw value of an @c appvapiWorkOrder's @c workOrderStatus property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetappvapiWorkOrder_WorkOrderStatus_RawValue(appvapiWorkOrder *message, int32_t value);

#pragma mark - appvapiCustomerServiceCategory

typedef GPB_ENUM(appvapiCustomerServiceCategory_FieldNumber) {
  appvapiCustomerServiceCategory_FieldNumber_Id_p = 1,
  appvapiCustomerServiceCategory_FieldNumber_Category = 2,
};

/**
 * 问题类型
 **/
GPB_FINAL @interface appvapiCustomerServiceCategory : GPBMessage

/**  Id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *id_p;
/** Test to see if @c id_p has been set. */
@property(nonatomic, readwrite) BOOL hasId_p;

/**  类型名称 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *category;

@end

#pragma mark - appvapiQuestion

typedef GPB_ENUM(appvapiQuestion_FieldNumber) {
  appvapiQuestion_FieldNumber_Id_p = 1,
  appvapiQuestion_FieldNumber_CategoryId = 2,
  appvapiQuestion_FieldNumber_Question = 3,
  appvapiQuestion_FieldNumber_Answer = 4,
  appvapiQuestion_FieldNumber_EnableWorkOrder = 5,
};

/**
 * 问题
 **/
GPB_FINAL @interface appvapiQuestion : GPBMessage

/**  Id  Id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *id_p;
/** Test to see if @c id_p has been set. */
@property(nonatomic, readwrite) BOOL hasId_p;

/**  问题类型Id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *categoryId;
/** Test to see if @c categoryId has been set. */
@property(nonatomic, readwrite) BOOL hasCategoryId;

/**  问题内容 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *question;

/**  答案内容 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *answer;

/**  工单开关 */
@property(nonatomic, readwrite) BOOL enableWorkOrder;

@end

#pragma mark - appvapiListCategoryResponse

typedef GPB_ENUM(appvapiListCategoryResponse_FieldNumber) {
  appvapiListCategoryResponse_FieldNumber_CategoryArray = 1,
};

/**
 * 问题类型集合
 **/
GPB_FINAL @interface appvapiListCategoryResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<appvapiCustomerServiceCategory*> *categoryArray;
/** The number of items in @c categoryArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger categoryArray_Count;

@end

#pragma mark - appvapiCustomerServiceCategories

typedef GPB_ENUM(appvapiCustomerServiceCategories_FieldNumber) {
  appvapiCustomerServiceCategories_FieldNumber_Id_p = 1,
  appvapiCustomerServiceCategories_FieldNumber_Category = 2,
  appvapiCustomerServiceCategories_FieldNumber_QuestionsArray = 4,
};

/**
 * 包含问题内容的问题类型包装类
 **/
GPB_FINAL @interface appvapiCustomerServiceCategories : GPBMessage

/**  Id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *id_p;
/** Test to see if @c id_p has been set. */
@property(nonatomic, readwrite) BOOL hasId_p;

/**  类型名称 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *category;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<appvapiQuestion*> *questionsArray;
/** The number of items in @c questionsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger questionsArray_Count;

@end

#pragma mark - appvapiListQuestionResponse

typedef GPB_ENUM(appvapiListQuestionResponse_FieldNumber) {
  appvapiListQuestionResponse_FieldNumber_QuestionsArray = 1,
};

/**
 * 类型查询问题列表 出参
 **/
GPB_FINAL @interface appvapiListQuestionResponse : GPBMessage

/** 问题列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<appvapiQuestion*> *questionsArray;
/** The number of items in @c questionsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger questionsArray_Count;

@end

#pragma mark - appvapiWorkOrderInstantMessage

typedef GPB_ENUM(appvapiWorkOrderInstantMessage_FieldNumber) {
  appvapiWorkOrderInstantMessage_FieldNumber_Id_p = 1,
  appvapiWorkOrderInstantMessage_FieldNumber_WorkOrderId = 2,
  appvapiWorkOrderInstantMessage_FieldNumber_Message = 3,
  appvapiWorkOrderInstantMessage_FieldNumber_Sender = 4,
  appvapiWorkOrderInstantMessage_FieldNumber_SendTime = 5,
};

GPB_FINAL @interface appvapiWorkOrderInstantMessage : GPBMessage

/** 工单消息Id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *id_p;
/** Test to see if @c id_p has been set. */
@property(nonatomic, readwrite) BOOL hasId_p;

/** 工单Id *客户端必传 */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *workOrderId;
/** Test to see if @c workOrderId has been set. */
@property(nonatomic, readwrite) BOOL hasWorkOrderId;

/** 消息内容 *客户端必传 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *message;

/** 发送人类型 0：用户 1：客服 */
@property(nonatomic, readwrite) uint32_t sender;

/** 发送信息时间 */
@property(nonatomic, readwrite) uint64_t sendTime;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)