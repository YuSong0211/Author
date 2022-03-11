// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: appv-primary-api-ad.proto

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

@class appvapiClickAdvertisementClick;
@class appvapiDisplayAdvertisement;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - appvapiAppvPrimaryApiAdRoot

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
GPB_FINAL @interface appvapiAppvPrimaryApiAdRoot : GPBRootObject
@end

#pragma mark - appvapiRecordAdvertisementRequest

typedef GPB_ENUM(appvapiRecordAdvertisementRequest_FieldNumber) {
  appvapiRecordAdvertisementRequest_FieldNumber_Display = 1,
  appvapiRecordAdvertisementRequest_FieldNumber_Click = 2,
};

typedef GPB_ENUM(appvapiRecordAdvertisementRequest_Record_OneOfCase) {
  appvapiRecordAdvertisementRequest_Record_OneOfCase_GPBUnsetOneOfCase = 0,
  appvapiRecordAdvertisementRequest_Record_OneOfCase_Display = 1,
  appvapiRecordAdvertisementRequest_Record_OneOfCase_Click = 2,
};

GPB_FINAL @interface appvapiRecordAdvertisementRequest : GPBMessage

@property(nonatomic, readonly) appvapiRecordAdvertisementRequest_Record_OneOfCase recordOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) appvapiDisplayAdvertisement *display;

@property(nonatomic, readwrite, strong, null_resettable) appvapiClickAdvertisementClick *click;

@end

/**
 * Clears whatever value was set for the oneof 'record'.
 **/
void appvapiRecordAdvertisementRequest_ClearRecordOneOfCase(appvapiRecordAdvertisementRequest *message);

#pragma mark - appvapiDisplayAdvertisement

typedef GPB_ENUM(appvapiDisplayAdvertisement_FieldNumber) {
  appvapiDisplayAdvertisement_FieldNumber_AdId = 1,
};

GPB_FINAL @interface appvapiDisplayAdvertisement : GPBMessage

@property(nonatomic, readwrite) uint64_t adId;

@end

#pragma mark - appvapiClickAdvertisementClick

typedef GPB_ENUM(appvapiClickAdvertisementClick_FieldNumber) {
  appvapiClickAdvertisementClick_FieldNumber_AdId = 1,
};

GPB_FINAL @interface appvapiClickAdvertisementClick : GPBMessage

@property(nonatomic, readwrite) uint64_t adId;

@end

#pragma mark - appvapiRecordAdvertisementResponse

GPB_FINAL @interface appvapiRecordAdvertisementResponse : GPBMessage

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)