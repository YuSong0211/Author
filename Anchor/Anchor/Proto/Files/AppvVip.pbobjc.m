// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: appv-vip.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

#import <stdatomic.h>

#import "AppvVip.pbobjc.h"
#import "AppvBasic.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdollar-in-identifier-extension"

#pragma mark - Objective C Class declarations
// Forward declarations of Objective C classes that we can use as
// static values in struct initializers.
// We don't use [Foo class] because it is not a static value.
GPBObjCClassDeclaration(appvapiIdEncode);
GPBObjCClassDeclaration(appvapiVipSalePrice);

#pragma mark - appvapiAppvVipRoot

@implementation appvapiAppvVipRoot

// No extensions in the file and none of the imports (direct or indirect)
// defined extensions, so no need to generate +extensionRegistry.

@end

#pragma mark - appvapiAppvVipRoot_FileDescriptor

static GPBFileDescriptor *appvapiAppvVipRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"appvapi"
                                                 objcPrefix:@"appvapi"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - Enum appvapiVipProductValidTimeType

GPBEnumDescriptor *appvapiVipProductValidTimeType_EnumDescriptor(void) {
  static _Atomic(GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    static const char *valueNames =
        "VipProductValidTimeTypeUnspecified\000VipPr"
        "oductValidTimeTypeLifetime\000VipProductVal"
        "idTimeTypeWeek\000VipProductValidTimeTypeHa"
        "lfMonth\000VipProductValidTimeTypeMonth\000Vip"
        "ProductValidTimeTypeQuarter\000VipProductVa"
        "lidTimeTypeHalfYear\000VipProductValidTimeT"
        "ypeYear\000";
    static const int32_t values[] = {
        appvapiVipProductValidTimeType_VipProductValidTimeTypeUnspecified,
        appvapiVipProductValidTimeType_VipProductValidTimeTypeLifetime,
        appvapiVipProductValidTimeType_VipProductValidTimeTypeWeek,
        appvapiVipProductValidTimeType_VipProductValidTimeTypeHalfMonth,
        appvapiVipProductValidTimeType_VipProductValidTimeTypeMonth,
        appvapiVipProductValidTimeType_VipProductValidTimeTypeQuarter,
        appvapiVipProductValidTimeType_VipProductValidTimeTypeHalfYear,
        appvapiVipProductValidTimeType_VipProductValidTimeTypeYear,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(appvapiVipProductValidTimeType)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:appvapiVipProductValidTimeType_IsValidValue];
    GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
      
    }
  }
  return descriptor;
}

BOOL appvapiVipProductValidTimeType_IsValidValue(int32_t value__) {
  switch (value__) {
    case appvapiVipProductValidTimeType_VipProductValidTimeTypeUnspecified:
    case appvapiVipProductValidTimeType_VipProductValidTimeTypeLifetime:
    case appvapiVipProductValidTimeType_VipProductValidTimeTypeWeek:
    case appvapiVipProductValidTimeType_VipProductValidTimeTypeHalfMonth:
    case appvapiVipProductValidTimeType_VipProductValidTimeTypeMonth:
    case appvapiVipProductValidTimeType_VipProductValidTimeTypeQuarter:
    case appvapiVipProductValidTimeType_VipProductValidTimeTypeHalfYear:
    case appvapiVipProductValidTimeType_VipProductValidTimeTypeYear:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - Enum appvapiVipProductType

GPBEnumDescriptor *appvapiVipProductType_EnumDescriptor(void) {
  static _Atomic(GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    static const char *valueNames =
        "VipProductTypeUnspecified\000VipProductType"
        "1\000VipProductType2\000";
    static const int32_t values[] = {
        appvapiVipProductType_VipProductTypeUnspecified,
        appvapiVipProductType_VipProductType1,
        appvapiVipProductType_VipProductType2,
    };
    static const char *extraTextFormatInfo = "\002\001c\347\344\201\000\002c\347\344\201\000";
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(appvapiVipProductType)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:appvapiVipProductType_IsValidValue
                              extraTextFormatInfo:extraTextFormatInfo];
    GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
      
    }
  }
  return descriptor;
}

BOOL appvapiVipProductType_IsValidValue(int32_t value__) {
  switch (value__) {
    case appvapiVipProductType_VipProductTypeUnspecified:
    case appvapiVipProductType_VipProductType1:
    case appvapiVipProductType_VipProductType2:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - Enum appvapiVipRightInterestsKey

GPBEnumDescriptor *appvapiVipRightInterestsKey_EnumDescriptor(void) {
  static _Atomic(GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    static const char *valueNames =
        "VipRightInterestsKeyUnspecified\000VipRight"
        "InterestsKeyEmberVideoComment\000VipRightIn"
        "terestsKeyMemberVideoView\000VipRightIntere"
        "stsKeyMemberVideoDownload\000";
    static const int32_t values[] = {
        appvapiVipRightInterestsKey_VipRightInterestsKeyUnspecified,
        appvapiVipRightInterestsKey_VipRightInterestsKeyEmberVideoComment,
        appvapiVipRightInterestsKey_VipRightInterestsKeyMemberVideoView,
        appvapiVipRightInterestsKey_VipRightInterestsKeyMemberVideoDownload,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(appvapiVipRightInterestsKey)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:appvapiVipRightInterestsKey_IsValidValue];
    GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
      
    }
  }
  return descriptor;
}

BOOL appvapiVipRightInterestsKey_IsValidValue(int32_t value__) {
  switch (value__) {
    case appvapiVipRightInterestsKey_VipRightInterestsKeyUnspecified:
    case appvapiVipRightInterestsKey_VipRightInterestsKeyEmberVideoComment:
    case appvapiVipRightInterestsKey_VipRightInterestsKeyMemberVideoView:
    case appvapiVipRightInterestsKey_VipRightInterestsKeyMemberVideoDownload:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - appvapiVipProductPrice

@implementation appvapiVipProductPrice

@dynamic hasVipProductPriceId, vipProductPriceId;
@dynamic hasVipProductId, vipProductId;
@dynamic price;
@dynamic hasSalePriceInfo, salePriceInfo;

typedef struct appvapiVipProductPrice__storage_ {
  uint32_t _has_storage_[1];
  uint32_t price;
  appvapiIdEncode *vipProductPriceId;
  appvapiIdEncode *vipProductId;
  appvapiVipSalePrice *salePriceInfo;
} appvapiVipProductPrice__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "vipProductPriceId",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiIdEncode),
        .number = appvapiVipProductPrice_FieldNumber_VipProductPriceId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(appvapiVipProductPrice__storage_, vipProductPriceId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "vipProductId",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiIdEncode),
        .number = appvapiVipProductPrice_FieldNumber_VipProductId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(appvapiVipProductPrice__storage_, vipProductId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "price",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiVipProductPrice_FieldNumber_Price,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(appvapiVipProductPrice__storage_, price),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "salePriceInfo",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiVipSalePrice),
        .number = appvapiVipProductPrice_FieldNumber_SalePriceInfo,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(appvapiVipProductPrice__storage_, salePriceInfo),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiVipProductPrice class]
                                     rootClass:[appvapiAppvVipRoot class]
                                          file:appvapiAppvVipRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiVipProductPrice__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - appvapiVipProduct

@implementation appvapiVipProduct

@dynamic hasId_p, id_p;
@dynamic type;
@dynamic memberValidTimeType;

typedef struct appvapiVipProduct__storage_ {
  uint32_t _has_storage_[1];
  appvapiVipProductType type;
  appvapiVipProductValidTimeType memberValidTimeType;
  appvapiIdEncode *id_p;
} appvapiVipProduct__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiIdEncode),
        .number = appvapiVipProduct_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(appvapiVipProduct__storage_, id_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "type",
        .dataTypeSpecific.enumDescFunc = appvapiVipProductType_EnumDescriptor,
        .number = appvapiVipProduct_FieldNumber_Type,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(appvapiVipProduct__storage_, type),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "memberValidTimeType",
        .dataTypeSpecific.enumDescFunc = appvapiVipProductValidTimeType_EnumDescriptor,
        .number = appvapiVipProduct_FieldNumber_MemberValidTimeType,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(appvapiVipProduct__storage_, memberValidTimeType),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeEnum,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiVipProduct class]
                                     rootClass:[appvapiAppvVipRoot class]
                                          file:appvapiAppvVipRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiVipProduct__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t appvapiVipProduct_Type_RawValue(appvapiVipProduct *message) {
  GPBDescriptor *descriptor = [appvapiVipProduct descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:appvapiVipProduct_FieldNumber_Type];
  return GPBGetMessageRawEnumField(message, field);
}

void SetappvapiVipProduct_Type_RawValue(appvapiVipProduct *message, int32_t value) {
  GPBDescriptor *descriptor = [appvapiVipProduct descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:appvapiVipProduct_FieldNumber_Type];
  GPBSetMessageRawEnumField(message, field, value);
}

int32_t appvapiVipProduct_MemberValidTimeType_RawValue(appvapiVipProduct *message) {
  GPBDescriptor *descriptor = [appvapiVipProduct descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:appvapiVipProduct_FieldNumber_MemberValidTimeType];
  return GPBGetMessageRawEnumField(message, field);
}

void SetappvapiVipProduct_MemberValidTimeType_RawValue(appvapiVipProduct *message, int32_t value) {
  GPBDescriptor *descriptor = [appvapiVipProduct descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:appvapiVipProduct_FieldNumber_MemberValidTimeType];
  GPBSetMessageRawEnumField(message, field, value);
}

#pragma mark - appvapiVipRightInterests

@implementation appvapiVipRightInterests

@dynamic hasId_p, id_p;
@dynamic vipProductType;
@dynamic vipRightInterestsKey;
@dynamic vipRightInterestsValue;

typedef struct appvapiVipRightInterests__storage_ {
  uint32_t _has_storage_[1];
  appvapiVipProductType vipProductType;
  appvapiVipRightInterestsKey vipRightInterestsKey;
  appvapiIdEncode *id_p;
  NSString *vipRightInterestsValue;
} appvapiVipRightInterests__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiIdEncode),
        .number = appvapiVipRightInterests_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(appvapiVipRightInterests__storage_, id_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "vipProductType",
        .dataTypeSpecific.enumDescFunc = appvapiVipProductType_EnumDescriptor,
        .number = appvapiVipRightInterests_FieldNumber_VipProductType,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(appvapiVipRightInterests__storage_, vipProductType),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "vipRightInterestsKey",
        .dataTypeSpecific.enumDescFunc = appvapiVipRightInterestsKey_EnumDescriptor,
        .number = appvapiVipRightInterests_FieldNumber_VipRightInterestsKey,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(appvapiVipRightInterests__storage_, vipRightInterestsKey),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "vipRightInterestsValue",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiVipRightInterests_FieldNumber_VipRightInterestsValue,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(appvapiVipRightInterests__storage_, vipRightInterestsValue),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiVipRightInterests class]
                                     rootClass:[appvapiAppvVipRoot class]
                                          file:appvapiAppvVipRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiVipRightInterests__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t appvapiVipRightInterests_VipProductType_RawValue(appvapiVipRightInterests *message) {
  GPBDescriptor *descriptor = [appvapiVipRightInterests descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:appvapiVipRightInterests_FieldNumber_VipProductType];
  return GPBGetMessageRawEnumField(message, field);
}

void SetappvapiVipRightInterests_VipProductType_RawValue(appvapiVipRightInterests *message, int32_t value) {
  GPBDescriptor *descriptor = [appvapiVipRightInterests descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:appvapiVipRightInterests_FieldNumber_VipProductType];
  GPBSetMessageRawEnumField(message, field, value);
}

int32_t appvapiVipRightInterests_VipRightInterestsKey_RawValue(appvapiVipRightInterests *message) {
  GPBDescriptor *descriptor = [appvapiVipRightInterests descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:appvapiVipRightInterests_FieldNumber_VipRightInterestsKey];
  return GPBGetMessageRawEnumField(message, field);
}

void SetappvapiVipRightInterests_VipRightInterestsKey_RawValue(appvapiVipRightInterests *message, int32_t value) {
  GPBDescriptor *descriptor = [appvapiVipRightInterests descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:appvapiVipRightInterests_FieldNumber_VipRightInterestsKey];
  GPBSetMessageRawEnumField(message, field, value);
}

#pragma mark - appvapiRechargeSalePrice

@implementation appvapiRechargeSalePrice

@dynamic salePrice;
@dynamic activityEndTime;

typedef struct appvapiRechargeSalePrice__storage_ {
  uint32_t _has_storage_[1];
  uint32_t salePrice;
  uint64_t activityEndTime;
} appvapiRechargeSalePrice__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "salePrice",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiRechargeSalePrice_FieldNumber_SalePrice,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(appvapiRechargeSalePrice__storage_, salePrice),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "activityEndTime",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiRechargeSalePrice_FieldNumber_ActivityEndTime,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(appvapiRechargeSalePrice__storage_, activityEndTime),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiRechargeSalePrice class]
                                     rootClass:[appvapiAppvVipRoot class]
                                          file:appvapiAppvVipRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiRechargeSalePrice__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - appvapiVipSalePrice

@implementation appvapiVipSalePrice

@dynamic salePrice;
@dynamic activityEndTime;

typedef struct appvapiVipSalePrice__storage_ {
  uint32_t _has_storage_[1];
  uint32_t salePrice;
  uint64_t activityEndTime;
} appvapiVipSalePrice__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "salePrice",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiVipSalePrice_FieldNumber_SalePrice,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(appvapiVipSalePrice__storage_, salePrice),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "activityEndTime",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiVipSalePrice_FieldNumber_ActivityEndTime,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(appvapiVipSalePrice__storage_, activityEndTime),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiVipSalePrice class]
                                     rootClass:[appvapiAppvVipRoot class]
                                          file:appvapiAppvVipRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiVipSalePrice__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)