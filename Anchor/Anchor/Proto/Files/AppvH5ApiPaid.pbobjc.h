// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: appv-h5-api-paid.proto

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

@class appvapiIdEncode;
@class appvapiRechargeSalePrice;
@class appvapiVipProduct;
@class appvapiVipProductPrice;
@class appvapiVipRightInterests;
@class appvapiWalletRechargeProduct;
GPB_ENUM_FWD_DECLARE(appvapiVipProductType);

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum appvapiPaymentType

/** 支付类型 */
typedef GPB_ENUM(appvapiPaymentType) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  appvapiPaymentType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  /** 无效类型 */
  appvapiPaymentType_PaymentTypeUnspecified = 0,

  /** apple支付 */
  appvapiPaymentType_PaymentTypeApple = 1,

  /** 金额支付 */
  appvapiPaymentType_PaymentTypeAmount = 2,
};

GPBEnumDescriptor *appvapiPaymentType_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL appvapiPaymentType_IsValidValue(int32_t value);

#pragma mark - appvapiAppvH5ApiPaidRoot

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
GPB_FINAL @interface appvapiAppvH5ApiPaidRoot : GPBRootObject
@end

#pragma mark - appvapiListWalletRechargeProductsRequest

typedef GPB_ENUM(appvapiListWalletRechargeProductsRequest_FieldNumber) {
  appvapiListWalletRechargeProductsRequest_FieldNumber_PaymentType = 1,
};

/**
 * 获取钱包充值产品列表的请求参数
 **/
GPB_FINAL @interface appvapiListWalletRechargeProductsRequest : GPBMessage

/** 支付类型 */
@property(nonatomic, readwrite) appvapiPaymentType paymentType;

@end

/**
 * Fetches the raw value of a @c appvapiListWalletRechargeProductsRequest's @c paymentType property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t appvapiListWalletRechargeProductsRequest_PaymentType_RawValue(appvapiListWalletRechargeProductsRequest *message);
/**
 * Sets the raw value of an @c appvapiListWalletRechargeProductsRequest's @c paymentType property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetappvapiListWalletRechargeProductsRequest_PaymentType_RawValue(appvapiListWalletRechargeProductsRequest *message, int32_t value);

#pragma mark - appvapiListWalletRechargeProductsResponse

typedef GPB_ENUM(appvapiListWalletRechargeProductsResponse_FieldNumber) {
  appvapiListWalletRechargeProductsResponse_FieldNumber_WalletRechargeProductsArray = 1,
};

/**
 * 获取钱包充值产品列表的响应参数
 **/
GPB_FINAL @interface appvapiListWalletRechargeProductsResponse : GPBMessage

/** 钱包充值产品列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<appvapiWalletRechargeProduct*> *walletRechargeProductsArray;
/** The number of items in @c walletRechargeProductsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger walletRechargeProductsArray_Count;

@end

#pragma mark - appvapiListVipProductsRequest

typedef GPB_ENUM(appvapiListVipProductsRequest_FieldNumber) {
  appvapiListVipProductsRequest_FieldNumber_PaymentType = 1,
};

/**
 * 获取vip列表时的请求参数
 **/
GPB_FINAL @interface appvapiListVipProductsRequest : GPBMessage

/** 支付类型 */
@property(nonatomic, readwrite) appvapiPaymentType paymentType;

@end

/**
 * Fetches the raw value of a @c appvapiListVipProductsRequest's @c paymentType property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t appvapiListVipProductsRequest_PaymentType_RawValue(appvapiListVipProductsRequest *message);
/**
 * Sets the raw value of an @c appvapiListVipProductsRequest's @c paymentType property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetappvapiListVipProductsRequest_PaymentType_RawValue(appvapiListVipProductsRequest *message, int32_t value);

#pragma mark - appvapiListVipProductsResponse

typedef GPB_ENUM(appvapiListVipProductsResponse_FieldNumber) {
  appvapiListVipProductsResponse_FieldNumber_VipPriceArray = 1,
  appvapiListVipProductsResponse_FieldNumber_VipsArray = 2,
  appvapiListVipProductsResponse_FieldNumber_VipRightInterestssArray = 3,
};

/**
 * 获取vip列表时的响应参数
 **/
GPB_FINAL @interface appvapiListVipProductsResponse : GPBMessage

/** vip 产品价格的列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<appvapiVipProductPrice*> *vipPriceArray;
/** The number of items in @c vipPriceArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger vipPriceArray_Count;

/** vip 产品信息 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<appvapiVipProduct*> *vipsArray;
/** The number of items in @c vipsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger vipsArray_Count;

/** vip权益信息 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<appvapiVipRightInterests*> *vipRightInterestssArray;
/** The number of items in @c vipRightInterestssArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger vipRightInterestssArray_Count;

@end

#pragma mark - appvapiVipBuyRequest

typedef GPB_ENUM(appvapiVipBuyRequest_FieldNumber) {
  appvapiVipBuyRequest_FieldNumber_Id_p = 1,
};

/**
 * 用户购买vip时的请求参数
 **/
GPB_FINAL @interface appvapiVipBuyRequest : GPBMessage

/** vip产品价格id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *id_p;
/** Test to see if @c id_p has been set. */
@property(nonatomic, readwrite) BOOL hasId_p;

@end

#pragma mark - appvapiVipBuyResponse

typedef GPB_ENUM(appvapiVipBuyResponse_FieldNumber) {
  appvapiVipBuyResponse_FieldNumber_JwtVipBuy = 1,
};

/**
 * 用户购买vip时的响应参数
 **/
GPB_FINAL @interface appvapiVipBuyResponse : GPBMessage

/** 用户、vip金额、jwt的签名token */
@property(nonatomic, readwrite, copy, null_resettable) NSString *jwtVipBuy;

@end

#pragma mark - appvapiWalletRechargeProduct

typedef GPB_ENUM(appvapiWalletRechargeProduct_FieldNumber) {
  appvapiWalletRechargeProduct_FieldNumber_Id_p = 1,
  appvapiWalletRechargeProduct_FieldNumber_RechargeAmount = 2,
  appvapiWalletRechargeProduct_FieldNumber_DisplayPrice = 3,
  appvapiWalletRechargeProduct_FieldNumber_GiveVipDays = 4,
  appvapiWalletRechargeProduct_FieldNumber_GiveVipType = 5,
  appvapiWalletRechargeProduct_FieldNumber_RechargeSalePrice = 6,
};

/**
 * 钱包充值产品定义
 **/
GPB_FINAL @interface appvapiWalletRechargeProduct : GPBMessage

/** 产品id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *id_p;
/** Test to see if @c id_p has been set. */
@property(nonatomic, readwrite) BOOL hasId_p;

/** 钱包充值产品的充值金额 */
@property(nonatomic, readwrite) uint32_t rechargeAmount;

/** 钱包充值产品的展示价格 */
@property(nonatomic, readwrite) uint32_t displayPrice;

/** 赠送VIP天数 */
@property(nonatomic, readwrite) uint32_t giveVipDays;

/** 赠送VIP类型 */
@property(nonatomic, readwrite) enum appvapiVipProductType giveVipType;

/** 充值产品的折扣信息（如果没有则表示没有折扣） */
@property(nonatomic, readwrite, strong, null_resettable) appvapiRechargeSalePrice *rechargeSalePrice;
/** Test to see if @c rechargeSalePrice has been set. */
@property(nonatomic, readwrite) BOOL hasRechargeSalePrice;

@end

/**
 * Fetches the raw value of a @c appvapiWalletRechargeProduct's @c giveVipType property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t appvapiWalletRechargeProduct_GiveVipType_RawValue(appvapiWalletRechargeProduct *message);
/**
 * Sets the raw value of an @c appvapiWalletRechargeProduct's @c giveVipType property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetappvapiWalletRechargeProduct_GiveVipType_RawValue(appvapiWalletRechargeProduct *message, int32_t value);

#pragma mark - appvapiWalletRechargeRequest

typedef GPB_ENUM(appvapiWalletRechargeRequest_FieldNumber) {
  appvapiWalletRechargeRequest_FieldNumber_Id_p = 1,
};

/**
 * 用户给钱包充值的接口请求参数
 **/
GPB_FINAL @interface appvapiWalletRechargeRequest : GPBMessage

/** 产品id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *id_p;
/** Test to see if @c id_p has been set. */
@property(nonatomic, readwrite) BOOL hasId_p;

@end

#pragma mark - appvapiWalletRechargeResponse

typedef GPB_ENUM(appvapiWalletRechargeResponse_FieldNumber) {
  appvapiWalletRechargeResponse_FieldNumber_OrderJwtToken = 1,
};

/**
 * 用户给钱包充值的接口响应参数
 **/
GPB_FINAL @interface appvapiWalletRechargeResponse : GPBMessage

/** 提供给UC服务的jwt-token */
@property(nonatomic, readwrite, copy, null_resettable) NSString *orderJwtToken;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
