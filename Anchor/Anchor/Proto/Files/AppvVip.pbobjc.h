// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: appv-vip.proto

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
@class appvapiVipSalePrice;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum appvapiVipProductValidTimeType

/** vip有效期时长类型定义 */
typedef GPB_ENUM(appvapiVipProductValidTimeType) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  appvapiVipProductValidTimeType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  /** 无效类型 */
  appvapiVipProductValidTimeType_VipProductValidTimeTypeUnspecified = 0,

  /** 终身（无限） */
  appvapiVipProductValidTimeType_VipProductValidTimeTypeLifetime = 1,

  /** 一周（7天） */
  appvapiVipProductValidTimeType_VipProductValidTimeTypeWeek = 2,

  /** 半个月（15天） */
  appvapiVipProductValidTimeType_VipProductValidTimeTypeHalfMonth = 3,

  /** 一月（30天） */
  appvapiVipProductValidTimeType_VipProductValidTimeTypeMonth = 4,

  /** 三个月（90天一季度） */
  appvapiVipProductValidTimeType_VipProductValidTimeTypeQuarter = 5,

  /** 半年（180天） */
  appvapiVipProductValidTimeType_VipProductValidTimeTypeHalfYear = 6,

  /** 一年（360天） */
  appvapiVipProductValidTimeType_VipProductValidTimeTypeYear = 7,
};

GPBEnumDescriptor *appvapiVipProductValidTimeType_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL appvapiVipProductValidTimeType_IsValidValue(int32_t value);

#pragma mark - Enum appvapiVipProductType

/** vip类型定义 */
typedef GPB_ENUM(appvapiVipProductType) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  appvapiVipProductType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  /** 没有会员 */
  appvapiVipProductType_VipProductTypeUnspecified = 0,

  /** 1级会员 */
  appvapiVipProductType_VipProductType1 = 1,

  /** 2级会员 */
  appvapiVipProductType_VipProductType2 = 2,
};

GPBEnumDescriptor *appvapiVipProductType_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL appvapiVipProductType_IsValidValue(int32_t value);

#pragma mark - Enum appvapiVipRightInterestsKey

/** vip权益枚举 */
typedef GPB_ENUM(appvapiVipRightInterestsKey) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  appvapiVipRightInterestsKey_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  /** 无效类型 */
  appvapiVipRightInterestsKey_VipRightInterestsKeyUnspecified = 0,

  /** 视频评论 */
  appvapiVipRightInterestsKey_VipRightInterestsKeyEmberVideoComment = 1,

  /** 视频观看 */
  appvapiVipRightInterestsKey_VipRightInterestsKeyMemberVideoView = 2,

  /** 视频下载 */
  appvapiVipRightInterestsKey_VipRightInterestsKeyMemberVideoDownload = 3,
};

GPBEnumDescriptor *appvapiVipRightInterestsKey_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL appvapiVipRightInterestsKey_IsValidValue(int32_t value);

#pragma mark - appvapiAppvVipRoot

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
GPB_FINAL @interface appvapiAppvVipRoot : GPBRootObject
@end

#pragma mark - appvapiVipProductPrice

typedef GPB_ENUM(appvapiVipProductPrice_FieldNumber) {
  appvapiVipProductPrice_FieldNumber_VipProductPriceId = 1,
  appvapiVipProductPrice_FieldNumber_VipProductId = 2,
  appvapiVipProductPrice_FieldNumber_Price = 3,
  appvapiVipProductPrice_FieldNumber_SalePriceInfo = 4,
};

GPB_FINAL @interface appvapiVipProductPrice : GPBMessage

/** vip产品价格Id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *vipProductPriceId;
/** Test to see if @c vipProductPriceId has been set. */
@property(nonatomic, readwrite) BOOL hasVipProductPriceId;

/** vip产品id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *vipProductId;
/** Test to see if @c vipProductId has been set. */
@property(nonatomic, readwrite) BOOL hasVipProductId;

/** 商品金额 */
@property(nonatomic, readwrite) uint32_t price;

/** vip产品的折扣信息（如果没有则表示没有折扣） */
@property(nonatomic, readwrite, strong, null_resettable) appvapiVipSalePrice *salePriceInfo;
/** Test to see if @c salePriceInfo has been set. */
@property(nonatomic, readwrite) BOOL hasSalePriceInfo;

@end

#pragma mark - appvapiVipProduct

typedef GPB_ENUM(appvapiVipProduct_FieldNumber) {
  appvapiVipProduct_FieldNumber_Id_p = 1,
  appvapiVipProduct_FieldNumber_Type = 2,
  appvapiVipProduct_FieldNumber_MemberValidTimeType = 3,
};

/**
 * vip产品的定义
 **/
GPB_FINAL @interface appvapiVipProduct : GPBMessage

/** vip产品id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *id_p;
/** Test to see if @c id_p has been set. */
@property(nonatomic, readwrite) BOOL hasId_p;

/** vip类型，需要通过pb.enum.VipProductType与移动端进行约定 */
@property(nonatomic, readwrite) appvapiVipProductType type;

/** vip产品的有效期定义，需要通过pb.enum.VipProductValidTimeType与移动端进行约定 */
@property(nonatomic, readwrite) appvapiVipProductValidTimeType memberValidTimeType;

@end

/**
 * Fetches the raw value of a @c appvapiVipProduct's @c type property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t appvapiVipProduct_Type_RawValue(appvapiVipProduct *message);
/**
 * Sets the raw value of an @c appvapiVipProduct's @c type property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetappvapiVipProduct_Type_RawValue(appvapiVipProduct *message, int32_t value);

/**
 * Fetches the raw value of a @c appvapiVipProduct's @c memberValidTimeType property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t appvapiVipProduct_MemberValidTimeType_RawValue(appvapiVipProduct *message);
/**
 * Sets the raw value of an @c appvapiVipProduct's @c memberValidTimeType property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetappvapiVipProduct_MemberValidTimeType_RawValue(appvapiVipProduct *message, int32_t value);

#pragma mark - appvapiVipRightInterests

typedef GPB_ENUM(appvapiVipRightInterests_FieldNumber) {
  appvapiVipRightInterests_FieldNumber_Id_p = 1,
  appvapiVipRightInterests_FieldNumber_VipProductType = 2,
  appvapiVipRightInterests_FieldNumber_VipRightInterestsKey = 3,
  appvapiVipRightInterests_FieldNumber_VipRightInterestsValue = 4,
};

GPB_FINAL @interface appvapiVipRightInterests : GPBMessage

/** 权益id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *id_p;
/** Test to see if @c id_p has been set. */
@property(nonatomic, readwrite) BOOL hasId_p;

/** 会员产品类型 */
@property(nonatomic, readwrite) appvapiVipProductType vipProductType;

/** 会员权益key */
@property(nonatomic, readwrite) appvapiVipRightInterestsKey vipRightInterestsKey;

/** 会员权益value */
@property(nonatomic, readwrite, copy, null_resettable) NSString *vipRightInterestsValue;

@end

/**
 * Fetches the raw value of a @c appvapiVipRightInterests's @c vipProductType property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t appvapiVipRightInterests_VipProductType_RawValue(appvapiVipRightInterests *message);
/**
 * Sets the raw value of an @c appvapiVipRightInterests's @c vipProductType property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetappvapiVipRightInterests_VipProductType_RawValue(appvapiVipRightInterests *message, int32_t value);

/**
 * Fetches the raw value of a @c appvapiVipRightInterests's @c vipRightInterestsKey property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t appvapiVipRightInterests_VipRightInterestsKey_RawValue(appvapiVipRightInterests *message);
/**
 * Sets the raw value of an @c appvapiVipRightInterests's @c vipRightInterestsKey property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetappvapiVipRightInterests_VipRightInterestsKey_RawValue(appvapiVipRightInterests *message, int32_t value);

#pragma mark - appvapiRechargeSalePrice

typedef GPB_ENUM(appvapiRechargeSalePrice_FieldNumber) {
  appvapiRechargeSalePrice_FieldNumber_SalePrice = 1,
  appvapiRechargeSalePrice_FieldNumber_ActivityEndTime = 2,
};

GPB_FINAL @interface appvapiRechargeSalePrice : GPBMessage

/** 折扣价 */
@property(nonatomic, readwrite) uint32_t salePrice;

/** 活动截止时间 */
@property(nonatomic, readwrite) uint64_t activityEndTime;

@end

#pragma mark - appvapiVipSalePrice

typedef GPB_ENUM(appvapiVipSalePrice_FieldNumber) {
  appvapiVipSalePrice_FieldNumber_SalePrice = 1,
  appvapiVipSalePrice_FieldNumber_ActivityEndTime = 2,
};

GPB_FINAL @interface appvapiVipSalePrice : GPBMessage

/** 折扣价 */
@property(nonatomic, readwrite) uint32_t salePrice;

/** 活动截止时间 */
@property(nonatomic, readwrite) uint64_t activityEndTime;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
