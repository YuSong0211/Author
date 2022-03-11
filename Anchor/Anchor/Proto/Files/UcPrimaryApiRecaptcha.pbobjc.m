// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: uc-primary-api-recaptcha.proto

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

#import "UcPrimaryApiRecaptcha.pbobjc.h"
#import "UcBasic.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - serviceucUcPrimaryApiRecaptchaRoot

@implementation serviceucUcPrimaryApiRecaptchaRoot

// No extensions in the file and none of the imports (direct or indirect)
// defined extensions, so no need to generate +extensionRegistry.

@end

#pragma mark - serviceucUcPrimaryApiRecaptchaRoot_FileDescriptor

static GPBFileDescriptor *serviceucUcPrimaryApiRecaptchaRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"uc"
                                                 objcPrefix:@"serviceuc"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - serviceucCaptchaValid

@implementation serviceucCaptchaValid

@dynamic captchaId;
@dynamic code;

typedef struct serviceucCaptchaValid__storage_ {
  uint32_t _has_storage_[1];
  NSString *code;
  uint64_t captchaId;
} serviceucCaptchaValid__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "captchaId",
        .dataTypeSpecific.clazz = Nil,
        .number = serviceucCaptchaValid_FieldNumber_CaptchaId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(serviceucCaptchaValid__storage_, captchaId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "code",
        .dataTypeSpecific.clazz = Nil,
        .number = serviceucCaptchaValid_FieldNumber_Code,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(serviceucCaptchaValid__storage_, code),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[serviceucCaptchaValid class]
                                     rootClass:[serviceucUcPrimaryApiRecaptchaRoot class]
                                          file:serviceucUcPrimaryApiRecaptchaRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(serviceucCaptchaValid__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - serviceucReCaptchaValidAliyunRequest

@implementation serviceucReCaptchaValidAliyunRequest


typedef struct serviceucReCaptchaValidAliyunRequest__storage_ {
  uint32_t _has_storage_[1];
} serviceucReCaptchaValidAliyunRequest__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[serviceucReCaptchaValidAliyunRequest class]
                                     rootClass:[serviceucUcPrimaryApiRecaptchaRoot class]
                                          file:serviceucUcPrimaryApiRecaptchaRoot_FileDescriptor()
                                        fields:NULL
                                    fieldCount:0
                                   storageSize:sizeof(serviceucReCaptchaValidAliyunRequest__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - serviceucReCaptchaValidResponse

@implementation serviceucReCaptchaValidResponse

@dynamic reCaptchaId;

typedef struct serviceucReCaptchaValidResponse__storage_ {
  uint32_t _has_storage_[1];
  uint64_t reCaptchaId;
} serviceucReCaptchaValidResponse__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "reCaptchaId",
        .dataTypeSpecific.clazz = Nil,
        .number = serviceucReCaptchaValidResponse_FieldNumber_ReCaptchaId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(serviceucReCaptchaValidResponse__storage_, reCaptchaId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[serviceucReCaptchaValidResponse class]
                                     rootClass:[serviceucUcPrimaryApiRecaptchaRoot class]
                                          file:serviceucUcPrimaryApiRecaptchaRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(serviceucReCaptchaValidResponse__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - serviceucCaptchaResponse

@implementation serviceucCaptchaResponse

@dynamic captchaId;
@dynamic imageSrc;

typedef struct serviceucCaptchaResponse__storage_ {
  uint32_t _has_storage_[1];
  NSData *imageSrc;
  uint64_t captchaId;
} serviceucCaptchaResponse__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "captchaId",
        .dataTypeSpecific.clazz = Nil,
        .number = serviceucCaptchaResponse_FieldNumber_CaptchaId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(serviceucCaptchaResponse__storage_, captchaId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "imageSrc",
        .dataTypeSpecific.clazz = Nil,
        .number = serviceucCaptchaResponse_FieldNumber_ImageSrc,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(serviceucCaptchaResponse__storage_, imageSrc),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeBytes,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[serviceucCaptchaResponse class]
                                     rootClass:[serviceucUcPrimaryApiRecaptchaRoot class]
                                          file:serviceucUcPrimaryApiRecaptchaRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(serviceucCaptchaResponse__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\001\002\010\000";
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
