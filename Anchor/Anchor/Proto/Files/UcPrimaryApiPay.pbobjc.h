// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: uc-primary-api-pay.proto

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

@class serviceucIdEncode;
@class serviceucPaymentAppleApiProductId;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - serviceucUcPrimaryApiPayRoot

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
GPB_FINAL @interface serviceucUcPrimaryApiPayRoot : GPBRootObject
@end

#pragma mark - serviceucPaymentLookupRequest

typedef GPB_ENUM(serviceucPaymentLookupRequest_FieldNumber) {
  serviceucPaymentLookupRequest_FieldNumber_PrepayId = 1,
};

GPB_FINAL @interface serviceucPaymentLookupRequest : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) serviceucIdEncode *prepayId;
/** Test to see if @c prepayId has been set. */
@property(nonatomic, readwrite) BOOL hasPrepayId;

@end

#pragma mark - serviceucPaymentLookupResponse

typedef GPB_ENUM(serviceucPaymentLookupResponse_FieldNumber) {
  serviceucPaymentLookupResponse_FieldNumber_IsSuccess = 1,
};

GPB_FINAL @interface serviceucPaymentLookupResponse : GPBMessage

/** ?????????????????? */
@property(nonatomic, readwrite) BOOL isSuccess;

@end

#pragma mark - serviceucPaymentAppleApiConfigRequest

GPB_FINAL @interface serviceucPaymentAppleApiConfigRequest : GPBMessage

@end

#pragma mark - serviceucPaymentAppleApiConfigResponse

typedef GPB_ENUM(serviceucPaymentAppleApiConfigResponse_FieldNumber) {
  serviceucPaymentAppleApiConfigResponse_FieldNumber_ProductIdsArray = 1,
};

GPB_FINAL @interface serviceucPaymentAppleApiConfigResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<serviceucPaymentAppleApiProductId*> *productIdsArray;
/** The number of items in @c productIdsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger productIdsArray_Count;

@end

#pragma mark - serviceucPaymentAppleApiProductId

typedef GPB_ENUM(serviceucPaymentAppleApiProductId_FieldNumber) {
  serviceucPaymentAppleApiProductId_FieldNumber_ProductId = 1,
  serviceucPaymentAppleApiProductId_FieldNumber_Amount = 2,
};

GPB_FINAL @interface serviceucPaymentAppleApiProductId : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *productId;

@property(nonatomic, readwrite) uint32_t amount;

@end

#pragma mark - serviceucPaymentAppleCreatePrepayRequest

typedef GPB_ENUM(serviceucPaymentAppleCreatePrepayRequest_FieldNumber) {
  serviceucPaymentAppleCreatePrepayRequest_FieldNumber_ProductId = 1,
  serviceucPaymentAppleCreatePrepayRequest_FieldNumber_PaymentArgs = 2,
};

GPB_FINAL @interface serviceucPaymentAppleCreatePrepayRequest : GPBMessage

/** ??????????????????ID */
@property(nonatomic, readwrite, copy, null_resettable) NSString *productId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *paymentArgs;

@end

#pragma mark - serviceucPaymentAppleCreatePrepayResponse

typedef GPB_ENUM(serviceucPaymentAppleCreatePrepayResponse_FieldNumber) {
  serviceucPaymentAppleCreatePrepayResponse_FieldNumber_PrepayId = 1,
  serviceucPaymentAppleCreatePrepayResponse_FieldNumber_ProductId = 2,
};

GPB_FINAL @interface serviceucPaymentAppleCreatePrepayResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) serviceucIdEncode *prepayId;
/** Test to see if @c prepayId has been set. */
@property(nonatomic, readwrite) BOOL hasPrepayId;

@property(nonatomic, readwrite, strong, null_resettable) serviceucPaymentAppleApiProductId *productId;
/** Test to see if @c productId has been set. */
@property(nonatomic, readwrite) BOOL hasProductId;

@end

#pragma mark - serviceucPaymentAppleVerifyReceiptRequest

typedef GPB_ENUM(serviceucPaymentAppleVerifyReceiptRequest_FieldNumber) {
  serviceucPaymentAppleVerifyReceiptRequest_FieldNumber_PrepayId = 1,
  serviceucPaymentAppleVerifyReceiptRequest_FieldNumber_TransactionId = 2,
  serviceucPaymentAppleVerifyReceiptRequest_FieldNumber_Receipt = 3,
};

GPB_FINAL @interface serviceucPaymentAppleVerifyReceiptRequest : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) serviceucIdEncode *prepayId;
/** Test to see if @c prepayId has been set. */
@property(nonatomic, readwrite) BOOL hasPrepayId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *transactionId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *receipt;

@end

#pragma mark - serviceucPaymentAppleVerifyReceiptResponse

typedef GPB_ENUM(serviceucPaymentAppleVerifyReceiptResponse_FieldNumber) {
  serviceucPaymentAppleVerifyReceiptResponse_FieldNumber_IsTest = 1,
};

GPB_FINAL @interface serviceucPaymentAppleVerifyReceiptResponse : GPBMessage

/**
 * ????????????????????? ???????????????????????????????????????????????????????????? ??????????????????????????????
 * ????????????????????? ????????????????????????????????????????????? ???????????????????????????
 **/
@property(nonatomic, readwrite) BOOL isTest;

@end

#pragma mark - serviceucPaymentMyh5CreatePrepayRequest

typedef GPB_ENUM(serviceucPaymentMyh5CreatePrepayRequest_FieldNumber) {
  serviceucPaymentMyh5CreatePrepayRequest_FieldNumber_PaymentArgs = 1,
};

GPB_FINAL @interface serviceucPaymentMyh5CreatePrepayRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *paymentArgs;

@end

#pragma mark - serviceucPaymentMyh5CreatePrepayResponse

typedef GPB_ENUM(serviceucPaymentMyh5CreatePrepayResponse_FieldNumber) {
  serviceucPaymentMyh5CreatePrepayResponse_FieldNumber_PrepayId = 1,
  serviceucPaymentMyh5CreatePrepayResponse_FieldNumber_H5RedirectURL = 2,
};

GPB_FINAL @interface serviceucPaymentMyh5CreatePrepayResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) serviceucIdEncode *prepayId;
/** Test to see if @c prepayId has been set. */
@property(nonatomic, readwrite) BOOL hasPrepayId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *h5RedirectURL;

@end

#pragma mark - serviceucListSupportTypeRequest

GPB_FINAL @interface serviceucListSupportTypeRequest : GPBMessage

@end

#pragma mark - serviceucListSupportTypeResponse

typedef GPB_ENUM(serviceucListSupportTypeResponse_FieldNumber) {
  serviceucListSupportTypeResponse_FieldNumber_PayTypesArray = 1,
};

GPB_FINAL @interface serviceucListSupportTypeResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *payTypesArray;
/** The number of items in @c payTypesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger payTypesArray_Count;

@end

#pragma mark - serviceucPaymentDirectorCreatePrepayRequest

typedef GPB_ENUM(serviceucPaymentDirectorCreatePrepayRequest_FieldNumber) {
  serviceucPaymentDirectorCreatePrepayRequest_FieldNumber_PaymentArgs = 1,
};

GPB_FINAL @interface serviceucPaymentDirectorCreatePrepayRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *paymentArgs;

@end

#pragma mark - serviceucPaymentDirectorCreatePrepayResponse

typedef GPB_ENUM(serviceucPaymentDirectorCreatePrepayResponse_FieldNumber) {
  serviceucPaymentDirectorCreatePrepayResponse_FieldNumber_PrepayId = 1,
  serviceucPaymentDirectorCreatePrepayResponse_FieldNumber_RedirectURL = 2,
};

GPB_FINAL @interface serviceucPaymentDirectorCreatePrepayResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) serviceucIdEncode *prepayId;
/** Test to see if @c prepayId has been set. */
@property(nonatomic, readwrite) BOOL hasPrepayId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *redirectURL;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
