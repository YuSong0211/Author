// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: gateway_grpc_wrapper(1).proto

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

#import "GatewayGrpcWrapper1.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdirect-ivar-access"
#pragma clang diagnostic ignored "-Wdollar-in-identifier-extension"

#pragma mark - Objective C Class declarations
// Forward declarations of Objective C classes that we can use as
// static values in struct initializers.
// We don't use [Foo class] because it is not a static value.
GPBObjCClassDeclaration(gatewayGrpcUnaryBody);
GPBObjCClassDeclaration(gatewayGrpcUnaryGatewayCommand);
GPBObjCClassDeclaration(gatewayGrpcUnaryGatewayCommandAuth);
GPBObjCClassDeclaration(gatewayGrpcUnaryGatewayCommandPing);
GPBObjCClassDeclaration(gatewayGrpcUnaryGatewayCommandReconnect);
GPBObjCClassDeclaration(gatewayGrpcUnaryHeader);
GPBObjCClassDeclaration(gatewayGrpcUnaryRequest);
GPBObjCClassDeclaration(gatewayGrpcUnaryResponseContextBody);
GPBObjCClassDeclaration(gatewayGrpcUnaryResponseInitiativeBody);

#pragma mark - gatewayGatewayGrpcWrapper1Root

@implementation gatewayGatewayGrpcWrapper1Root

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - gatewayGatewayGrpcWrapper1Root_FileDescriptor

static GPBFileDescriptor *gatewayGatewayGrpcWrapper1Root_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"gateway"
                                                 objcPrefix:@"gateway"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - Enum gatewayGrpcUnaryProtocolError

GPBEnumDescriptor *gatewayGrpcUnaryProtocolError_EnumDescriptor(void) {
  static _Atomic(GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    static const char *valueNames =
        "Ok\000Canceled\000Unknown\000InvalidArgument\000Dead"
        "lineExceeded\000NotFound\000AlreadyExists\000Perm"
        "issionDenied\000Unauthenticated\000ResourceExh"
        "austed\000FailedPrecondition\000Aborted\000OutOfR"
        "ange\000Unimplemented\000Internal\000Unavailable\000"
        "DataLoss\000";
    static const int32_t values[] = {
        gatewayGrpcUnaryProtocolError_Ok,
        gatewayGrpcUnaryProtocolError_Canceled,
        gatewayGrpcUnaryProtocolError_Unknown,
        gatewayGrpcUnaryProtocolError_InvalidArgument,
        gatewayGrpcUnaryProtocolError_DeadlineExceeded,
        gatewayGrpcUnaryProtocolError_NotFound,
        gatewayGrpcUnaryProtocolError_AlreadyExists,
        gatewayGrpcUnaryProtocolError_PermissionDenied,
        gatewayGrpcUnaryProtocolError_Unauthenticated,
        gatewayGrpcUnaryProtocolError_ResourceExhausted,
        gatewayGrpcUnaryProtocolError_FailedPrecondition,
        gatewayGrpcUnaryProtocolError_Aborted,
        gatewayGrpcUnaryProtocolError_OutOfRange,
        gatewayGrpcUnaryProtocolError_Unimplemented,
        gatewayGrpcUnaryProtocolError_Internal,
        gatewayGrpcUnaryProtocolError_Unavailable,
        gatewayGrpcUnaryProtocolError_DataLoss,
    };
    static const char *extraTextFormatInfo = "\020\001\010\000\002\007\000\003\017\000\004\020\000\005\010\000\006\r\000\007\020\000\010\017\000\t\021\000\n\022\000\013\007\000\014\n\000\r\r\000\016\010\000\017\013\000\020\010\000";
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(gatewayGrpcUnaryProtocolError)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:gatewayGrpcUnaryProtocolError_IsValidValue
                              extraTextFormatInfo:extraTextFormatInfo];
    GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
      
    }
  }
  return descriptor;
}

BOOL gatewayGrpcUnaryProtocolError_IsValidValue(int32_t value__) {
  switch (value__) {
    case gatewayGrpcUnaryProtocolError_Ok:
    case gatewayGrpcUnaryProtocolError_Canceled:
    case gatewayGrpcUnaryProtocolError_Unknown:
    case gatewayGrpcUnaryProtocolError_InvalidArgument:
    case gatewayGrpcUnaryProtocolError_DeadlineExceeded:
    case gatewayGrpcUnaryProtocolError_NotFound:
    case gatewayGrpcUnaryProtocolError_AlreadyExists:
    case gatewayGrpcUnaryProtocolError_PermissionDenied:
    case gatewayGrpcUnaryProtocolError_Unauthenticated:
    case gatewayGrpcUnaryProtocolError_ResourceExhausted:
    case gatewayGrpcUnaryProtocolError_FailedPrecondition:
    case gatewayGrpcUnaryProtocolError_Aborted:
    case gatewayGrpcUnaryProtocolError_OutOfRange:
    case gatewayGrpcUnaryProtocolError_Unimplemented:
    case gatewayGrpcUnaryProtocolError_Internal:
    case gatewayGrpcUnaryProtocolError_Unavailable:
    case gatewayGrpcUnaryProtocolError_DataLoss:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - gatewayGrpcUnaryRequests

@implementation gatewayGrpcUnaryRequests

@dynamic requestBodyOneOfCase;
@dynamic requestId;
@dynamic request;
@dynamic command;

typedef struct gatewayGrpcUnaryRequests__storage_ {
  uint32_t _has_storage_[2];
  gatewayGrpcUnaryRequest *request;
  gatewayGrpcUnaryGatewayCommand *command;
  uint64_t requestId;
} gatewayGrpcUnaryRequests__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "requestId",
        .dataTypeSpecific.clazz = Nil,
        .number = gatewayGrpcUnaryRequests_FieldNumber_RequestId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryRequests__storage_, requestId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "request",
        .dataTypeSpecific.clazz = GPBObjCClass(gatewayGrpcUnaryRequest),
        .number = gatewayGrpcUnaryRequests_FieldNumber_Request,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryRequests__storage_, request),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "command",
        .dataTypeSpecific.clazz = GPBObjCClass(gatewayGrpcUnaryGatewayCommand),
        .number = gatewayGrpcUnaryRequests_FieldNumber_Command,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryRequests__storage_, command),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[gatewayGrpcUnaryRequests class]
                                     rootClass:[gatewayGatewayGrpcWrapper1Root class]
                                          file:gatewayGatewayGrpcWrapper1Root_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(gatewayGrpcUnaryRequests__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    static const char *oneofs[] = {
      "requestBody",
    };
    [localDescriptor setupOneofs:oneofs
                           count:(uint32_t)(sizeof(oneofs) / sizeof(char*))
                   firstHasIndex:-1];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

void gatewayGrpcUnaryRequests_ClearRequestBodyOneOfCase(gatewayGrpcUnaryRequests *message) {
  GPBDescriptor *descriptor = [gatewayGrpcUnaryRequests descriptor];
  GPBOneofDescriptor *oneof = [descriptor.oneofs objectAtIndex:0];
  GPBClearOneof(message, oneof);
}
#pragma mark - gatewayGrpcUnaryRequest

@implementation gatewayGrpcUnaryRequest

@dynamic serviceFullName;
@dynamic hasBody, body;

typedef struct gatewayGrpcUnaryRequest__storage_ {
  uint32_t _has_storage_[1];
  NSString *serviceFullName;
  gatewayGrpcUnaryBody *body;
} gatewayGrpcUnaryRequest__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "serviceFullName",
        .dataTypeSpecific.clazz = Nil,
        .number = gatewayGrpcUnaryRequest_FieldNumber_ServiceFullName,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryRequest__storage_, serviceFullName),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "body",
        .dataTypeSpecific.clazz = GPBObjCClass(gatewayGrpcUnaryBody),
        .number = gatewayGrpcUnaryRequest_FieldNumber_Body,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryRequest__storage_, body),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[gatewayGrpcUnaryRequest class]
                                     rootClass:[gatewayGatewayGrpcWrapper1Root class]
                                          file:gatewayGatewayGrpcWrapper1Root_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(gatewayGrpcUnaryRequest__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - gatewayGrpcUnaryResponse

@implementation gatewayGrpcUnaryResponse

@dynamic serverTime;
@dynamic hasContextBody, contextBody;
@dynamic hasStreamBody, streamBody;

typedef struct gatewayGrpcUnaryResponse__storage_ {
  uint32_t _has_storage_[1];
  gatewayGrpcUnaryResponseContextBody *contextBody;
  gatewayGrpcUnaryResponseInitiativeBody *streamBody;
  uint64_t serverTime;
} gatewayGrpcUnaryResponse__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "serverTime",
        .dataTypeSpecific.clazz = Nil,
        .number = gatewayGrpcUnaryResponse_FieldNumber_ServerTime,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryResponse__storage_, serverTime),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "contextBody",
        .dataTypeSpecific.clazz = GPBObjCClass(gatewayGrpcUnaryResponseContextBody),
        .number = gatewayGrpcUnaryResponse_FieldNumber_ContextBody,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryResponse__storage_, contextBody),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "streamBody",
        .dataTypeSpecific.clazz = GPBObjCClass(gatewayGrpcUnaryResponseInitiativeBody),
        .number = gatewayGrpcUnaryResponse_FieldNumber_StreamBody,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryResponse__storage_, streamBody),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[gatewayGrpcUnaryResponse class]
                                     rootClass:[gatewayGatewayGrpcWrapper1Root class]
                                          file:gatewayGatewayGrpcWrapper1Root_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(gatewayGrpcUnaryResponse__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - gatewayGrpcUnaryResponseContextBody

@implementation gatewayGrpcUnaryResponseContextBody

@dynamic grpcError;
@dynamic requestId;
@dynamic hasBody, body;

typedef struct gatewayGrpcUnaryResponseContextBody__storage_ {
  uint32_t _has_storage_[1];
  gatewayGrpcUnaryProtocolError grpcError;
  gatewayGrpcUnaryBody *body;
  uint64_t requestId;
} gatewayGrpcUnaryResponseContextBody__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "grpcError",
        .dataTypeSpecific.enumDescFunc = gatewayGrpcUnaryProtocolError_EnumDescriptor,
        .number = gatewayGrpcUnaryResponseContextBody_FieldNumber_GrpcError,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryResponseContextBody__storage_, grpcError),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "requestId",
        .dataTypeSpecific.clazz = Nil,
        .number = gatewayGrpcUnaryResponseContextBody_FieldNumber_RequestId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryResponseContextBody__storage_, requestId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "body",
        .dataTypeSpecific.clazz = GPBObjCClass(gatewayGrpcUnaryBody),
        .number = gatewayGrpcUnaryResponseContextBody_FieldNumber_Body,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryResponseContextBody__storage_, body),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[gatewayGrpcUnaryResponseContextBody class]
                                     rootClass:[gatewayGatewayGrpcWrapper1Root class]
                                          file:gatewayGatewayGrpcWrapper1Root_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(gatewayGrpcUnaryResponseContextBody__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t gatewayGrpcUnaryResponseContextBody_GrpcError_RawValue(gatewayGrpcUnaryResponseContextBody *message) {
  GPBDescriptor *descriptor = [gatewayGrpcUnaryResponseContextBody descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:gatewayGrpcUnaryResponseContextBody_FieldNumber_GrpcError];
  return GPBGetMessageRawEnumField(message, field);
}

void SetgatewayGrpcUnaryResponseContextBody_GrpcError_RawValue(gatewayGrpcUnaryResponseContextBody *message, int32_t value) {
  GPBDescriptor *descriptor = [gatewayGrpcUnaryResponseContextBody descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:gatewayGrpcUnaryResponseContextBody_FieldNumber_GrpcError];
  GPBSetMessageRawEnumField(message, field, value);
}

#pragma mark - gatewayGrpcUnaryResponseInitiativeBody

@implementation gatewayGrpcUnaryResponseInitiativeBody

@dynamic eventName;
@dynamic hasBody, body;

typedef struct gatewayGrpcUnaryResponseInitiativeBody__storage_ {
  uint32_t _has_storage_[1];
  NSString *eventName;
  gatewayGrpcUnaryBody *body;
} gatewayGrpcUnaryResponseInitiativeBody__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "eventName",
        .dataTypeSpecific.clazz = Nil,
        .number = gatewayGrpcUnaryResponseInitiativeBody_FieldNumber_EventName,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryResponseInitiativeBody__storage_, eventName),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "body",
        .dataTypeSpecific.clazz = GPBObjCClass(gatewayGrpcUnaryBody),
        .number = gatewayGrpcUnaryResponseInitiativeBody_FieldNumber_Body,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryResponseInitiativeBody__storage_, body),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[gatewayGrpcUnaryResponseInitiativeBody class]
                                     rootClass:[gatewayGatewayGrpcWrapper1Root class]
                                          file:gatewayGatewayGrpcWrapper1Root_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(gatewayGrpcUnaryResponseInitiativeBody__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - gatewayGrpcUnaryGatewayCommand

@implementation gatewayGrpcUnaryGatewayCommand

@dynamic commandOneOfCase;
@dynamic ping;
@dynamic auth;
@dynamic reconnect;

typedef struct gatewayGrpcUnaryGatewayCommand__storage_ {
  uint32_t _has_storage_[2];
  gatewayGrpcUnaryGatewayCommandPing *ping;
  gatewayGrpcUnaryGatewayCommandAuth *auth;
  gatewayGrpcUnaryGatewayCommandReconnect *reconnect;
} gatewayGrpcUnaryGatewayCommand__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "ping",
        .dataTypeSpecific.clazz = GPBObjCClass(gatewayGrpcUnaryGatewayCommandPing),
        .number = gatewayGrpcUnaryGatewayCommand_FieldNumber_Ping,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryGatewayCommand__storage_, ping),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "auth",
        .dataTypeSpecific.clazz = GPBObjCClass(gatewayGrpcUnaryGatewayCommandAuth),
        .number = gatewayGrpcUnaryGatewayCommand_FieldNumber_Auth,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryGatewayCommand__storage_, auth),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "reconnect",
        .dataTypeSpecific.clazz = GPBObjCClass(gatewayGrpcUnaryGatewayCommandReconnect),
        .number = gatewayGrpcUnaryGatewayCommand_FieldNumber_Reconnect,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryGatewayCommand__storage_, reconnect),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[gatewayGrpcUnaryGatewayCommand class]
                                     rootClass:[gatewayGatewayGrpcWrapper1Root class]
                                          file:gatewayGatewayGrpcWrapper1Root_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(gatewayGrpcUnaryGatewayCommand__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    static const char *oneofs[] = {
      "command",
    };
    [localDescriptor setupOneofs:oneofs
                           count:(uint32_t)(sizeof(oneofs) / sizeof(char*))
                   firstHasIndex:-1];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

void gatewayGrpcUnaryGatewayCommand_ClearCommandOneOfCase(gatewayGrpcUnaryGatewayCommand *message) {
  GPBDescriptor *descriptor = [gatewayGrpcUnaryGatewayCommand descriptor];
  GPBOneofDescriptor *oneof = [descriptor.oneofs objectAtIndex:0];
  GPBClearOneof(message, oneof);
}
#pragma mark - gatewayGrpcUnaryGatewayCommandPing

@implementation gatewayGrpcUnaryGatewayCommandPing


typedef struct gatewayGrpcUnaryGatewayCommandPing__storage_ {
  uint32_t _has_storage_[1];
} gatewayGrpcUnaryGatewayCommandPing__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[gatewayGrpcUnaryGatewayCommandPing class]
                                     rootClass:[gatewayGatewayGrpcWrapper1Root class]
                                          file:gatewayGatewayGrpcWrapper1Root_FileDescriptor()
                                        fields:NULL
                                    fieldCount:0
                                   storageSize:sizeof(gatewayGrpcUnaryGatewayCommandPing__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - gatewayGrpcUnaryGatewayCommandPong

@implementation gatewayGrpcUnaryGatewayCommandPong


typedef struct gatewayGrpcUnaryGatewayCommandPong__storage_ {
  uint32_t _has_storage_[1];
} gatewayGrpcUnaryGatewayCommandPong__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[gatewayGrpcUnaryGatewayCommandPong class]
                                     rootClass:[gatewayGatewayGrpcWrapper1Root class]
                                          file:gatewayGatewayGrpcWrapper1Root_FileDescriptor()
                                        fields:NULL
                                    fieldCount:0
                                   storageSize:sizeof(gatewayGrpcUnaryGatewayCommandPong__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - gatewayGrpcUnaryGatewayCommandAuth

@implementation gatewayGrpcUnaryGatewayCommandAuth

@dynamic appkey;
@dynamic token;

typedef struct gatewayGrpcUnaryGatewayCommandAuth__storage_ {
  uint32_t _has_storage_[1];
  NSString *appkey;
  NSString *token;
} gatewayGrpcUnaryGatewayCommandAuth__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "appkey",
        .dataTypeSpecific.clazz = Nil,
        .number = gatewayGrpcUnaryGatewayCommandAuth_FieldNumber_Appkey,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryGatewayCommandAuth__storage_, appkey),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "token",
        .dataTypeSpecific.clazz = Nil,
        .number = gatewayGrpcUnaryGatewayCommandAuth_FieldNumber_Token,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryGatewayCommandAuth__storage_, token),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[gatewayGrpcUnaryGatewayCommandAuth class]
                                     rootClass:[gatewayGatewayGrpcWrapper1Root class]
                                          file:gatewayGatewayGrpcWrapper1Root_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(gatewayGrpcUnaryGatewayCommandAuth__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - gatewayGrpcUnaryGatewayCommandReconnect

@implementation gatewayGrpcUnaryGatewayCommandReconnect

@dynamic appkey;
@dynamic reconnectAuthToken;

typedef struct gatewayGrpcUnaryGatewayCommandReconnect__storage_ {
  uint32_t _has_storage_[1];
  NSString *appkey;
  NSString *reconnectAuthToken;
} gatewayGrpcUnaryGatewayCommandReconnect__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "appkey",
        .dataTypeSpecific.clazz = Nil,
        .number = gatewayGrpcUnaryGatewayCommandReconnect_FieldNumber_Appkey,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryGatewayCommandReconnect__storage_, appkey),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "reconnectAuthToken",
        .dataTypeSpecific.clazz = Nil,
        .number = gatewayGrpcUnaryGatewayCommandReconnect_FieldNumber_ReconnectAuthToken,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryGatewayCommandReconnect__storage_, reconnectAuthToken),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[gatewayGrpcUnaryGatewayCommandReconnect class]
                                     rootClass:[gatewayGatewayGrpcWrapper1Root class]
                                          file:gatewayGatewayGrpcWrapper1Root_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(gatewayGrpcUnaryGatewayCommandReconnect__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - gatewayGrpcUnaryGatewayCommandResponseBodyAuth

@implementation gatewayGrpcUnaryGatewayCommandResponseBodyAuth

@dynamic reconnectAuthToken;

typedef struct gatewayGrpcUnaryGatewayCommandResponseBodyAuth__storage_ {
  uint32_t _has_storage_[1];
  NSString *reconnectAuthToken;
} gatewayGrpcUnaryGatewayCommandResponseBodyAuth__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "reconnectAuthToken",
        .dataTypeSpecific.clazz = Nil,
        .number = gatewayGrpcUnaryGatewayCommandResponseBodyAuth_FieldNumber_ReconnectAuthToken,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryGatewayCommandResponseBodyAuth__storage_, reconnectAuthToken),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[gatewayGrpcUnaryGatewayCommandResponseBodyAuth class]
                                     rootClass:[gatewayGatewayGrpcWrapper1Root class]
                                          file:gatewayGatewayGrpcWrapper1Root_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(gatewayGrpcUnaryGatewayCommandResponseBodyAuth__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - gatewayGrpcUnaryHeader

@implementation gatewayGrpcUnaryHeader

@dynamic key;
@dynamic valueArray, valueArray_Count;

typedef struct gatewayGrpcUnaryHeader__storage_ {
  uint32_t _has_storage_[1];
  NSString *key;
  NSMutableArray *valueArray;
} gatewayGrpcUnaryHeader__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "key",
        .dataTypeSpecific.clazz = Nil,
        .number = gatewayGrpcUnaryHeader_FieldNumber_Key,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryHeader__storage_, key),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "valueArray",
        .dataTypeSpecific.clazz = Nil,
        .number = gatewayGrpcUnaryHeader_FieldNumber_ValueArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryHeader__storage_, valueArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[gatewayGrpcUnaryHeader class]
                                     rootClass:[gatewayGatewayGrpcWrapper1Root class]
                                          file:gatewayGatewayGrpcWrapper1Root_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(gatewayGrpcUnaryHeader__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - gatewayGrpcUnaryBody

@implementation gatewayGrpcUnaryBody

@dynamic headersArray, headersArray_Count;
@dynamic body;

typedef struct gatewayGrpcUnaryBody__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *headersArray;
  NSData *body;
} gatewayGrpcUnaryBody__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "headersArray",
        .dataTypeSpecific.clazz = GPBObjCClass(gatewayGrpcUnaryHeader),
        .number = gatewayGrpcUnaryBody_FieldNumber_HeadersArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryBody__storage_, headersArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "body",
        .dataTypeSpecific.clazz = Nil,
        .number = gatewayGrpcUnaryBody_FieldNumber_Body,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(gatewayGrpcUnaryBody__storage_, body),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeBytes,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[gatewayGrpcUnaryBody class]
                                     rootClass:[gatewayGatewayGrpcWrapper1Root class]
                                          file:gatewayGatewayGrpcWrapper1Root_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(gatewayGrpcUnaryBody__storage_)
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
