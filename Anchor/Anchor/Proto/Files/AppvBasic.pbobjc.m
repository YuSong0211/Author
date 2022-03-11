// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: appv-basic.proto

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

#import "AppvBasic.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdollar-in-identifier-extension"

#pragma mark - Objective C Class declarations
// Forward declarations of Objective C classes that we can use as
// static values in struct initializers.
// We don't use [Foo class] because it is not a static value.
GPBObjCClassDeclaration(appvapiCommunityPostPicture);
GPBObjCClassDeclaration(appvapiMIMEInfo);
GPBObjCClassDeclaration(appvapiPublishingCommunityPostPicture);
GPBObjCClassDeclaration(appvapiPublishingCommunityPostVideo);

#pragma mark - appvapiAppvBasicRoot

@implementation appvapiAppvBasicRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - appvapiAppvBasicRoot_FileDescriptor

static GPBFileDescriptor *appvapiAppvBasicRoot_FileDescriptor(void) {
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

#pragma mark - Enum appvapiGenders

GPBEnumDescriptor *appvapiGenders_EnumDescriptor(void) {
  static _Atomic(GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    static const char *valueNames =
        "None\000Nosex\000Male\000Female\000";
    static const int32_t values[] = {
        appvapiGenders_None,
        appvapiGenders_Nosex,
        appvapiGenders_Male,
        appvapiGenders_Female,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(appvapiGenders)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:appvapiGenders_IsValidValue];
    GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
      
    }
  }
  return descriptor;
}

BOOL appvapiGenders_IsValidValue(int32_t value__) {
  switch (value__) {
    case appvapiGenders_None:
    case appvapiGenders_Nosex:
    case appvapiGenders_Male:
    case appvapiGenders_Female:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - appvapiEmptyRequest

@implementation appvapiEmptyRequest


typedef struct appvapiEmptyRequest__storage_ {
  uint32_t _has_storage_[1];
} appvapiEmptyRequest__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiEmptyRequest class]
                                     rootClass:[appvapiAppvBasicRoot class]
                                          file:appvapiAppvBasicRoot_FileDescriptor()
                                        fields:NULL
                                    fieldCount:0
                                   storageSize:sizeof(appvapiEmptyRequest__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - appvapiEmptyResponse

@implementation appvapiEmptyResponse


typedef struct appvapiEmptyResponse__storage_ {
  uint32_t _has_storage_[1];
} appvapiEmptyResponse__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiEmptyResponse class]
                                     rootClass:[appvapiAppvBasicRoot class]
                                          file:appvapiAppvBasicRoot_FileDescriptor()
                                        fields:NULL
                                    fieldCount:0
                                   storageSize:sizeof(appvapiEmptyResponse__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - appvapiGender

@implementation appvapiGender

@dynamic gender;

typedef struct appvapiGender__storage_ {
  uint32_t _has_storage_[1];
  appvapiGenders gender;
} appvapiGender__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "gender",
        .dataTypeSpecific.enumDescFunc = appvapiGenders_EnumDescriptor,
        .number = appvapiGender_FieldNumber_Gender,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(appvapiGender__storage_, gender),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeEnum,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiGender class]
                                     rootClass:[appvapiAppvBasicRoot class]
                                          file:appvapiAppvBasicRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiGender__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t appvapiGender_Gender_RawValue(appvapiGender *message) {
  GPBDescriptor *descriptor = [appvapiGender descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:appvapiGender_FieldNumber_Gender];
  return GPBGetMessageRawEnumField(message, field);
}

void SetappvapiGender_Gender_RawValue(appvapiGender *message, int32_t value) {
  GPBDescriptor *descriptor = [appvapiGender descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:appvapiGender_FieldNumber_Gender];
  GPBSetMessageRawEnumField(message, field, value);
}

#pragma mark - appvapiIdEncode

@implementation appvapiIdEncode

@dynamic id_p;

typedef struct appvapiIdEncode__storage_ {
  uint32_t _has_storage_[1];
  NSString *id_p;
} appvapiIdEncode__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiIdEncode_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(appvapiIdEncode__storage_, id_p),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiIdEncode class]
                                     rootClass:[appvapiAppvBasicRoot class]
                                          file:appvapiAppvBasicRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiIdEncode__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - appvapiAppendIdEncode

@implementation appvapiAppendIdEncode

@dynamic lastId;

typedef struct appvapiAppendIdEncode__storage_ {
  uint32_t _has_storage_[1];
  NSString *lastId;
} appvapiAppendIdEncode__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "lastId",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiAppendIdEncode_FieldNumber_LastId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(appvapiAppendIdEncode__storage_, lastId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiAppendIdEncode class]
                                     rootClass:[appvapiAppvBasicRoot class]
                                          file:appvapiAppvBasicRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiAppendIdEncode__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - appvapiMIMEInfo

@implementation appvapiMIMEInfo

@dynamic URL;
@dynamic fileByteSize;
@dynamic aspectRatio;
@dynamic extra;

typedef struct appvapiMIMEInfo__storage_ {
  uint32_t _has_storage_[1];
  NSString *URL;
  NSString *aspectRatio;
  NSString *extra;
  uint64_t fileByteSize;
} appvapiMIMEInfo__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "URL",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiMIMEInfo_FieldNumber_URL,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(appvapiMIMEInfo__storage_, URL),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "fileByteSize",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiMIMEInfo_FieldNumber_FileByteSize,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(appvapiMIMEInfo__storage_, fileByteSize),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "aspectRatio",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiMIMEInfo_FieldNumber_AspectRatio,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(appvapiMIMEInfo__storage_, aspectRatio),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "extra",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiMIMEInfo_FieldNumber_Extra,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(appvapiMIMEInfo__storage_, extra),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiMIMEInfo class]
                                     rootClass:[appvapiAppvBasicRoot class]
                                          file:appvapiAppvBasicRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiMIMEInfo__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\001\001!!!\000";
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

#pragma mark - appvapiShareCode

@implementation appvapiShareCode

@dynamic shareCode;
@dynamic args;

typedef struct appvapiShareCode__storage_ {
  uint32_t _has_storage_[1];
  NSString *shareCode;
  NSString *args;
} appvapiShareCode__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "shareCode",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiShareCode_FieldNumber_ShareCode,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(appvapiShareCode__storage_, shareCode),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "args",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiShareCode_FieldNumber_Args,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(appvapiShareCode__storage_, args),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiShareCode class]
                                     rootClass:[appvapiAppvBasicRoot class]
                                          file:appvapiAppvBasicRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiShareCode__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - appvapiPublishingCommunityPostMedia

@implementation appvapiPublishingCommunityPostMedia

@dynamic hasPublishingCommunityPostVideo, publishingCommunityPostVideo;
@dynamic hasPublishingCommunityPostPicture, publishingCommunityPostPicture;

typedef struct appvapiPublishingCommunityPostMedia__storage_ {
  uint32_t _has_storage_[1];
  appvapiPublishingCommunityPostVideo *publishingCommunityPostVideo;
  appvapiPublishingCommunityPostPicture *publishingCommunityPostPicture;
} appvapiPublishingCommunityPostMedia__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "publishingCommunityPostVideo",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiPublishingCommunityPostVideo),
        .number = appvapiPublishingCommunityPostMedia_FieldNumber_PublishingCommunityPostVideo,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(appvapiPublishingCommunityPostMedia__storage_, publishingCommunityPostVideo),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "publishingCommunityPostPicture",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiPublishingCommunityPostPicture),
        .number = appvapiPublishingCommunityPostMedia_FieldNumber_PublishingCommunityPostPicture,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(appvapiPublishingCommunityPostMedia__storage_, publishingCommunityPostPicture),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiPublishingCommunityPostMedia class]
                                     rootClass:[appvapiAppvBasicRoot class]
                                          file:appvapiAppvBasicRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiPublishingCommunityPostMedia__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - appvapiPublishingCommunityPostVideo

@implementation appvapiPublishingCommunityPostVideo

@dynamic hasResources, resources;
@dynamic hasCoverFile, coverFile;

typedef struct appvapiPublishingCommunityPostVideo__storage_ {
  uint32_t _has_storage_[1];
  appvapiMIMEInfo *resources;
  appvapiMIMEInfo *coverFile;
} appvapiPublishingCommunityPostVideo__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "resources",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiMIMEInfo),
        .number = appvapiPublishingCommunityPostVideo_FieldNumber_Resources,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(appvapiPublishingCommunityPostVideo__storage_, resources),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "coverFile",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiMIMEInfo),
        .number = appvapiPublishingCommunityPostVideo_FieldNumber_CoverFile,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(appvapiPublishingCommunityPostVideo__storage_, coverFile),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiPublishingCommunityPostVideo class]
                                     rootClass:[appvapiAppvBasicRoot class]
                                          file:appvapiAppvBasicRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiPublishingCommunityPostVideo__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - appvapiPublishingCommunityPostPicture

@implementation appvapiPublishingCommunityPostPicture

@dynamic resourcesArray, resourcesArray_Count;

typedef struct appvapiPublishingCommunityPostPicture__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *resourcesArray;
} appvapiPublishingCommunityPostPicture__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "resourcesArray",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiCommunityPostPicture),
        .number = appvapiPublishingCommunityPostPicture_FieldNumber_ResourcesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(appvapiPublishingCommunityPostPicture__storage_, resourcesArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiPublishingCommunityPostPicture class]
                                     rootClass:[appvapiAppvBasicRoot class]
                                          file:appvapiAppvBasicRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiPublishingCommunityPostPicture__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - appvapiCommunityPostPicture

@implementation appvapiCommunityPostPicture

@dynamic hasPicture, picture;
@dynamic hasPictureThumbnail, pictureThumbnail;

typedef struct appvapiCommunityPostPicture__storage_ {
  uint32_t _has_storage_[1];
  appvapiMIMEInfo *picture;
  appvapiMIMEInfo *pictureThumbnail;
} appvapiCommunityPostPicture__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "picture",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiMIMEInfo),
        .number = appvapiCommunityPostPicture_FieldNumber_Picture,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(appvapiCommunityPostPicture__storage_, picture),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "pictureThumbnail",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiMIMEInfo),
        .number = appvapiCommunityPostPicture_FieldNumber_PictureThumbnail,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(appvapiCommunityPostPicture__storage_, pictureThumbnail),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiCommunityPostPicture class]
                                     rootClass:[appvapiAppvBasicRoot class]
                                          file:appvapiAppvBasicRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiCommunityPostPicture__storage_)
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
