// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: appv-primary-tag.proto

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
@class appvapiMIMEInfo;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum appvapiContentTagType

typedef GPB_ENUM(appvapiContentTagType) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  appvapiContentTagType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  /** 无效标签类型 */
  appvapiContentTagType_ContentTagTypeUnspecified = 0,

  /** 视频标签 */
  appvapiContentTagType_ContentTagTypeVideo = 1,

  /** 帖子标签 */
  appvapiContentTagType_ContentTagTypePost = 2,

  /** 直播标签 */
  appvapiContentTagType_ContentTagTypeLive = 3,
};

GPBEnumDescriptor *appvapiContentTagType_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL appvapiContentTagType_IsValidValue(int32_t value);

#pragma mark - appvapiAppvPrimaryTagRoot

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
GPB_FINAL @interface appvapiAppvPrimaryTagRoot : GPBRootObject
@end

#pragma mark - appvapiContentTag

typedef GPB_ENUM(appvapiContentTag_FieldNumber) {
  appvapiContentTag_FieldNumber_Id_p = 1,
  appvapiContentTag_FieldNumber_TagName = 2,
  appvapiContentTag_FieldNumber_BackgroundImgURL = 3,
  appvapiContentTag_FieldNumber_HasBackground = 4,
  appvapiContentTag_FieldNumber_IsMain = 5,
  appvapiContentTag_FieldNumber_ContentTagType = 6,
  appvapiContentTag_FieldNumber_IsHot = 7,
};

GPB_FINAL @interface appvapiContentTag : GPBMessage

/** id */
@property(nonatomic, readwrite, strong, null_resettable) appvapiIdEncode *id_p;
/** Test to see if @c id_p has been set. */
@property(nonatomic, readwrite) BOOL hasId_p;

/** 标签名 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *tagName;

/** 标签背景url */
@property(nonatomic, readwrite, strong, null_resettable) appvapiMIMEInfo *backgroundImgURL;
/** Test to see if @c backgroundImgURL has been set. */
@property(nonatomic, readwrite) BOOL hasBackgroundImgURL;

/** 是否有背景图 */
@property(nonatomic, readwrite) BOOL hasBackground;

/** 是否是主推标签 */
@property(nonatomic, readwrite) BOOL isMain;

/** 标签类型 */
@property(nonatomic, readwrite) appvapiContentTagType contentTagType;

/** 是否是热门标签 */
@property(nonatomic, readwrite) BOOL isHot;

@end

/**
 * Fetches the raw value of a @c appvapiContentTag's @c contentTagType property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t appvapiContentTag_ContentTagType_RawValue(appvapiContentTag *message);
/**
 * Sets the raw value of an @c appvapiContentTag's @c contentTagType property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetappvapiContentTag_ContentTagType_RawValue(appvapiContentTag *message, int32_t value);

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
