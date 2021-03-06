// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: appv-primary-api-oss.proto

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

#import "AppvPrimaryApiOss.pbobjc.h"
#import "AppvBasic.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdollar-in-identifier-extension"

#pragma mark - Objective C Class declarations
// Forward declarations of Objective C classes that we can use as
// static values in struct initializers.
// We don't use [Foo class] because it is not a static value.
GPBObjCClassDeclaration(appvapiCallbackEvent);
GPBObjCClassDeclaration(appvapiIdEncode);

#pragma mark - appvapiAppvPrimaryApiOssRoot

@implementation appvapiAppvPrimaryApiOssRoot

// No extensions in the file and none of the imports (direct or indirect)
// defined extensions, so no need to generate +extensionRegistry.

@end

#pragma mark - appvapiAppvPrimaryApiOssRoot_FileDescriptor

static GPBFileDescriptor *appvapiAppvPrimaryApiOssRoot_FileDescriptor(void) {
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

#pragma mark - appvapiCallbackMessageReq

@implementation appvapiCallbackMessageReq

@dynamic hasBatchId, batchId;
@dynamic hasEvent, event;

typedef struct appvapiCallbackMessageReq__storage_ {
  uint32_t _has_storage_[1];
  appvapiIdEncode *batchId;
  appvapiCallbackEvent *event;
} appvapiCallbackMessageReq__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "batchId",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiIdEncode),
        .number = appvapiCallbackMessageReq_FieldNumber_BatchId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(appvapiCallbackMessageReq__storage_, batchId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "event",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiCallbackEvent),
        .number = appvapiCallbackMessageReq_FieldNumber_Event,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(appvapiCallbackMessageReq__storage_, event),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiCallbackMessageReq class]
                                     rootClass:[appvapiAppvPrimaryApiOssRoot class]
                                          file:appvapiAppvPrimaryApiOssRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiCallbackMessageReq__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - appvapiCallbackEvent

@implementation appvapiCallbackEvent

@dynamic hasEventId, eventId;
@dynamic status;
@dynamic deviceInfo;

typedef struct appvapiCallbackEvent__storage_ {
  uint32_t _has_storage_[1];
  appvapiCallbackEvent_Status status;
  appvapiIdEncode *eventId;
  NSString *deviceInfo;
} appvapiCallbackEvent__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "eventId",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiIdEncode),
        .number = appvapiCallbackEvent_FieldNumber_EventId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(appvapiCallbackEvent__storage_, eventId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "status",
        .dataTypeSpecific.enumDescFunc = appvapiCallbackEvent_Status_EnumDescriptor,
        .number = appvapiCallbackEvent_FieldNumber_Status,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(appvapiCallbackEvent__storage_, status),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "deviceInfo",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiCallbackEvent_FieldNumber_DeviceInfo,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(appvapiCallbackEvent__storage_, deviceInfo),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiCallbackEvent class]
                                     rootClass:[appvapiAppvPrimaryApiOssRoot class]
                                          file:appvapiAppvPrimaryApiOssRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiCallbackEvent__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t appvapiCallbackEvent_Status_RawValue(appvapiCallbackEvent *message) {
  GPBDescriptor *descriptor = [appvapiCallbackEvent descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:appvapiCallbackEvent_FieldNumber_Status];
  return GPBGetMessageRawEnumField(message, field);
}

void SetappvapiCallbackEvent_Status_RawValue(appvapiCallbackEvent *message, int32_t value) {
  GPBDescriptor *descriptor = [appvapiCallbackEvent descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:appvapiCallbackEvent_FieldNumber_Status];
  GPBSetMessageRawEnumField(message, field, value);
}

#pragma mark - Enum appvapiCallbackEvent_Status

GPBEnumDescriptor *appvapiCallbackEvent_Status_EnumDescriptor(void) {
  static _Atomic(GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    static const char *valueNames =
        "StatusUnspecified\000StatusSuccess\000StatusCa"
        "ncel\000StatusNetworkError\000StatusCrcError\000";
    static const int32_t values[] = {
        appvapiCallbackEvent_Status_StatusUnspecified,
        appvapiCallbackEvent_Status_StatusSuccess,
        appvapiCallbackEvent_Status_StatusCancel,
        appvapiCallbackEvent_Status_StatusNetworkError,
        appvapiCallbackEvent_Status_StatusCrcError,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(appvapiCallbackEvent_Status)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:appvapiCallbackEvent_Status_IsValidValue];
    GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
      
    }
  }
  return descriptor;
}

BOOL appvapiCallbackEvent_Status_IsValidValue(int32_t value__) {
  switch (value__) {
    case appvapiCallbackEvent_Status_StatusUnspecified:
    case appvapiCallbackEvent_Status_StatusSuccess:
    case appvapiCallbackEvent_Status_StatusCancel:
    case appvapiCallbackEvent_Status_StatusNetworkError:
    case appvapiCallbackEvent_Status_StatusCrcError:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - appvapiUploadCallbackResp

@implementation appvapiUploadCallbackResp

@dynamic success;

typedef struct appvapiUploadCallbackResp__storage_ {
  uint32_t _has_storage_[1];
} appvapiUploadCallbackResp__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "success",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiUploadCallbackResp_FieldNumber_Success,
        .hasIndex = 0,
        .offset = 1,  // Stored in _has_storage_ to save space.
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeBool,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiUploadCallbackResp class]
                                     rootClass:[appvapiAppvPrimaryApiOssRoot class]
                                          file:appvapiAppvPrimaryApiOssRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiUploadCallbackResp__storage_)
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
