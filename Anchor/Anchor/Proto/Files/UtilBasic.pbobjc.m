// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: util-basic.proto

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

#import "UtilBasic.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdollar-in-identifier-extension"

#pragma mark - Objective C Class declarations
// Forward declarations of Objective C classes that we can use as
// static values in struct initializers.
// We don't use [Foo class] because it is not a static value.
GPBObjCClassDeclaration(utilpbdatametadataDataIdvFiled);
GPBObjCClassDeclaration(utilpbdatametadataDataKvFiled);

#pragma mark - utilpbdatametadataUtilBasicRoot

@implementation utilpbdatametadataUtilBasicRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - utilpbdatametadataUtilBasicRoot_FileDescriptor

static GPBFileDescriptor *utilpbdatametadataUtilBasicRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"v.basic"
                                                 objcPrefix:@"utilpbdatametadata"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - utilpbdatametadataIdUint64

@implementation utilpbdatametadataIdUint64

@dynamic id_p;

typedef struct utilpbdatametadataIdUint64__storage_ {
  uint32_t _has_storage_[1];
  uint64_t id_p;
} utilpbdatametadataIdUint64__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.clazz = Nil,
        .number = utilpbdatametadataIdUint64_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(utilpbdatametadataIdUint64__storage_, id_p),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[utilpbdatametadataIdUint64 class]
                                     rootClass:[utilpbdatametadataUtilBasicRoot class]
                                          file:utilpbdatametadataUtilBasicRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(utilpbdatametadataIdUint64__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - utilpbdatametadataAppendIdUint64

@implementation utilpbdatametadataAppendIdUint64

@dynamic lastId;

typedef struct utilpbdatametadataAppendIdUint64__storage_ {
  uint32_t _has_storage_[1];
  uint64_t lastId;
} utilpbdatametadataAppendIdUint64__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "lastId",
        .dataTypeSpecific.clazz = Nil,
        .number = utilpbdatametadataAppendIdUint64_FieldNumber_LastId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(utilpbdatametadataAppendIdUint64__storage_, lastId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[utilpbdatametadataAppendIdUint64 class]
                                     rootClass:[utilpbdatametadataUtilBasicRoot class]
                                          file:utilpbdatametadataUtilBasicRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(utilpbdatametadataAppendIdUint64__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\001\001\006\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - utilpbdatametadataStrWithClean

@implementation utilpbdatametadataStrWithClean

@dynamic raw;
@dynamic isClean;

typedef struct utilpbdatametadataStrWithClean__storage_ {
  uint32_t _has_storage_[1];
  NSString *raw;
} utilpbdatametadataStrWithClean__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "raw",
        .dataTypeSpecific.clazz = Nil,
        .number = utilpbdatametadataStrWithClean_FieldNumber_Raw,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(utilpbdatametadataStrWithClean__storage_, raw),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "isClean",
        .dataTypeSpecific.clazz = Nil,
        .number = utilpbdatametadataStrWithClean_FieldNumber_IsClean,
        .hasIndex = 1,
        .offset = 2,  // Stored in _has_storage_ to save space.
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeBool,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[utilpbdatametadataStrWithClean class]
                                     rootClass:[utilpbdatametadataUtilBasicRoot class]
                                          file:utilpbdatametadataUtilBasicRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(utilpbdatametadataStrWithClean__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\001\002\007\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - utilpbdatametadataDataKvs

@implementation utilpbdatametadataDataKvs

@dynamic kvsArray, kvsArray_Count;

typedef struct utilpbdatametadataDataKvs__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *kvsArray;
} utilpbdatametadataDataKvs__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "kvsArray",
        .dataTypeSpecific.clazz = GPBObjCClass(utilpbdatametadataDataKvFiled),
        .number = utilpbdatametadataDataKvs_FieldNumber_KvsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(utilpbdatametadataDataKvs__storage_, kvsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[utilpbdatametadataDataKvs class]
                                     rootClass:[utilpbdatametadataUtilBasicRoot class]
                                          file:utilpbdatametadataUtilBasicRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(utilpbdatametadataDataKvs__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - utilpbdatametadataDataIdVs

@implementation utilpbdatametadataDataIdVs

@dynamic idVsArray, idVsArray_Count;

typedef struct utilpbdatametadataDataIdVs__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *idVsArray;
} utilpbdatametadataDataIdVs__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "idVsArray",
        .dataTypeSpecific.clazz = GPBObjCClass(utilpbdatametadataDataIdvFiled),
        .number = utilpbdatametadataDataIdVs_FieldNumber_IdVsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(utilpbdatametadataDataIdVs__storage_, idVsArray),
        .flags = (GPBFieldFlags)(GPBFieldRepeated | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[utilpbdatametadataDataIdVs class]
                                     rootClass:[utilpbdatametadataUtilBasicRoot class]
                                          file:utilpbdatametadataUtilBasicRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(utilpbdatametadataDataIdVs__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\001\001\000idVs\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - utilpbdatametadataDataIdvFiled

@implementation utilpbdatametadataDataIdvFiled

@dynamic id_p;
@dynamic idValue;

typedef struct utilpbdatametadataDataIdvFiled__storage_ {
  uint32_t _has_storage_[1];
  NSString *idValue;
  uint64_t id_p;
} utilpbdatametadataDataIdvFiled__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.clazz = Nil,
        .number = utilpbdatametadataDataIdvFiled_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(utilpbdatametadataDataIdvFiled__storage_, id_p),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "idValue",
        .dataTypeSpecific.clazz = Nil,
        .number = utilpbdatametadataDataIdvFiled_FieldNumber_IdValue,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(utilpbdatametadataDataIdvFiled__storage_, idValue),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[utilpbdatametadataDataIdvFiled class]
                                     rootClass:[utilpbdatametadataUtilBasicRoot class]
                                          file:utilpbdatametadataUtilBasicRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(utilpbdatametadataDataIdvFiled__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\001\002\007\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - utilpbdatametadataDataKvFiled

@implementation utilpbdatametadataDataKvFiled

@dynamic kvKey;
@dynamic kvValue;

typedef struct utilpbdatametadataDataKvFiled__storage_ {
  uint32_t _has_storage_[1];
  NSString *kvKey;
  NSString *kvValue;
} utilpbdatametadataDataKvFiled__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "kvKey",
        .dataTypeSpecific.clazz = Nil,
        .number = utilpbdatametadataDataKvFiled_FieldNumber_KvKey,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(utilpbdatametadataDataKvFiled__storage_, kvKey),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "kvValue",
        .dataTypeSpecific.clazz = Nil,
        .number = utilpbdatametadataDataKvFiled_FieldNumber_KvValue,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(utilpbdatametadataDataKvFiled__storage_, kvValue),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[utilpbdatametadataDataKvFiled class]
                                     rootClass:[utilpbdatametadataUtilBasicRoot class]
                                          file:utilpbdatametadataUtilBasicRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(utilpbdatametadataDataKvFiled__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\002\001\005\000\002\007\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
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
