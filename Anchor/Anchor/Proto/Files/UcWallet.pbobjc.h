// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: uc-wallet.proto

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

@class serviceucWalletObtain;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - serviceucUcWalletRoot

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
GPB_FINAL @interface serviceucUcWalletRoot : GPBRootObject
@end

#pragma mark - serviceucWalletAmount

typedef GPB_ENUM(serviceucWalletAmount_FieldNumber) {
  serviceucWalletAmount_FieldNumber_Amount = 1,
  serviceucWalletAmount_FieldNumber_Obtain = 2,
  serviceucWalletAmount_FieldNumber_TotalWalletAmount = 3,
};

GPB_FINAL @interface serviceucWalletAmount : GPBMessage

/** APP余额 */
@property(nonatomic, readwrite) uint32_t amount;

/** 附加余额 */
@property(nonatomic, readwrite, strong, null_resettable) serviceucWalletObtain *obtain;
/** Test to see if @c obtain has been set. */
@property(nonatomic, readwrite) BOOL hasObtain;

/** 钱包内内的总金额 */
@property(nonatomic, readwrite) uint32_t totalWalletAmount;

@end

#pragma mark - serviceucWalletObtain

typedef GPB_ENUM(serviceucWalletObtain_FieldNumber) {
  serviceucWalletObtain_FieldNumber_RelatedAmount = 1,
  serviceucWalletObtain_FieldNumber_ScrollAmount = 2,
  serviceucWalletObtain_FieldNumber_LiveAmount = 3,
};

GPB_FINAL @interface serviceucWalletObtain : GPBMessage

/** 代理余额 */
@property(nonatomic, readwrite) uint32_t relatedAmount;

/** 滚动余额 */
@property(nonatomic, readwrite) uint32_t scrollAmount;

/** 直播收益余额 */
@property(nonatomic, readwrite) uint32_t liveAmount;

@end

#pragma mark - serviceucBankInfo

typedef GPB_ENUM(serviceucBankInfo_FieldNumber) {
  serviceucBankInfo_FieldNumber_BankNumber = 1,
  serviceucBankInfo_FieldNumber_BankName = 2,
  serviceucBankInfo_FieldNumber_BankNickname = 3,
  serviceucBankInfo_FieldNumber_BankArea = 4,
  serviceucBankInfo_FieldNumber_BankAreaName = 5,
  serviceucBankInfo_FieldNumber_ReservedTel = 6,
};

GPB_FINAL @interface serviceucBankInfo : GPBMessage

/** 银行卡号 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *bankNumber;

/** 银行名字 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *bankName;

/** 开户姓名 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *bankNickname;

/** 开户地区 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *bankArea;

/** 开户行 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *bankAreaName;

/** 预留手机号 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *reservedTel;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
