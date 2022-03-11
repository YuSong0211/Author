// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: exchange-primary-msg.proto

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

#import "ExchangePrimaryMsg.pbobjc.h"
#import "ExchangeBasic.pbobjc.h"
#import "UtilBasicIdentity.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdirect-ivar-access"
#pragma clang diagnostic ignored "-Wdollar-in-identifier-extension"

#pragma mark - Objective C Class declarations
// Forward declarations of Objective C classes that we can use as
// static values in struct initializers.
// We don't use [Foo class] because it is not a static value.
GPBObjCClassDeclaration(serviceexchangeChatMsg);
GPBObjCClassDeclaration(serviceexchangeChatUser);
GPBObjCClassDeclaration(serviceexchangeChatUserInfo);
GPBObjCClassDeclaration(serviceexchangeLiveRoomUser);
GPBObjCClassDeclaration(serviceexchangeMessageContentBody);
GPBObjCClassDeclaration(serviceexchangeMsgBodySystemTemplate);
GPBObjCClassDeclaration(serviceexchangeMsgBodyUserMime);
GPBObjCClassDeclaration(serviceexchangeMsgBodyUserText);
GPBObjCClassDeclaration(serviceexchangeVersionId);
GPBObjCClassDeclaration(utilidentitysdkIdEncode);

#pragma mark - serviceexchangeExchangePrimaryMsgRoot

@implementation serviceexchangeExchangePrimaryMsgRoot

// No extensions in the file and none of the imports (direct or indirect)
// defined extensions, so no need to generate +extensionRegistry.

@end

#pragma mark - serviceexchangeExchangePrimaryMsgRoot_FileDescriptor

static GPBFileDescriptor *serviceexchangeExchangePrimaryMsgRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"exchange"
                                                 objcPrefix:@"serviceexchange"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - Enum serviceexchangeMimeType

GPBEnumDescriptor *serviceexchangeMimeType_EnumDescriptor(void) {
  static _Atomic(GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    static const char *valueNames =
        "MimeTypeUnspecified\000MimeTypeImage\000MimeTy"
        "peFile\000MimeTypeVideo\000";
    static const int32_t values[] = {
        serviceexchangeMimeType_MimeTypeUnspecified,
        serviceexchangeMimeType_MimeTypeImage,
        serviceexchangeMimeType_MimeTypeFile,
        serviceexchangeMimeType_MimeTypeVideo,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(serviceexchangeMimeType)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:serviceexchangeMimeType_IsValidValue];
    GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
      
    }
  }
  return descriptor;
}

BOOL serviceexchangeMimeType_IsValidValue(int32_t value__) {
  switch (value__) {
    case serviceexchangeMimeType_MimeTypeUnspecified:
    case serviceexchangeMimeType_MimeTypeImage:
    case serviceexchangeMimeType_MimeTypeFile:
    case serviceexchangeMimeType_MimeTypeVideo:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - serviceexchangeVersionId

@implementation serviceexchangeVersionId

@dynamic id_p;

typedef struct serviceexchangeVersionId__storage_ {
  uint32_t _has_storage_[1];
  uint64_t id_p;
} serviceexchangeVersionId__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.clazz = Nil,
        .number = serviceexchangeVersionId_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(serviceexchangeVersionId__storage_, id_p),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[serviceexchangeVersionId class]
                                     rootClass:[serviceexchangeExchangePrimaryMsgRoot class]
                                          file:serviceexchangeExchangePrimaryMsgRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(serviceexchangeVersionId__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - serviceexchangeMessageContent

@implementation serviceexchangeMessageContent

@dynamic hasSend, send;
@dynamic hasRef, ref;

typedef struct serviceexchangeMessageContent__storage_ {
  uint32_t _has_storage_[1];
  serviceexchangeChatMsg *send;
  serviceexchangeChatMsg *ref;
} serviceexchangeMessageContent__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "send",
        .dataTypeSpecific.clazz = GPBObjCClass(serviceexchangeChatMsg),
        .number = serviceexchangeMessageContent_FieldNumber_Send,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(serviceexchangeMessageContent__storage_, send),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "ref",
        .dataTypeSpecific.clazz = GPBObjCClass(serviceexchangeChatMsg),
        .number = serviceexchangeMessageContent_FieldNumber_Ref,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(serviceexchangeMessageContent__storage_, ref),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[serviceexchangeMessageContent class]
                                     rootClass:[serviceexchangeExchangePrimaryMsgRoot class]
                                          file:serviceexchangeExchangePrimaryMsgRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(serviceexchangeMessageContent__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - serviceexchangeChatMsg

@implementation serviceexchangeChatMsg

@dynamic hasBody, body;
@dynamic hasUser, user;

typedef struct serviceexchangeChatMsg__storage_ {
  uint32_t _has_storage_[1];
  serviceexchangeMessageContentBody *body;
  serviceexchangeChatUser *user;
} serviceexchangeChatMsg__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "body",
        .dataTypeSpecific.clazz = GPBObjCClass(serviceexchangeMessageContentBody),
        .number = serviceexchangeChatMsg_FieldNumber_Body,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(serviceexchangeChatMsg__storage_, body),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "user",
        .dataTypeSpecific.clazz = GPBObjCClass(serviceexchangeChatUser),
        .number = serviceexchangeChatMsg_FieldNumber_User,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(serviceexchangeChatMsg__storage_, user),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[serviceexchangeChatMsg class]
                                     rootClass:[serviceexchangeExchangePrimaryMsgRoot class]
                                          file:serviceexchangeExchangePrimaryMsgRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(serviceexchangeChatMsg__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - serviceexchangeMessageContentBody

@implementation serviceexchangeMessageContentBody

@dynamic msgBodyOneOfCase;
@dynamic hasVersionId, versionId;
@dynamic sendTime;
@dynamic clientSendTime;
@dynamic msgBodySystemTemplate;
@dynamic msgBodyUserText;
@dynamic msgBodyUserMime;

typedef struct serviceexchangeMessageContentBody__storage_ {
  uint32_t _has_storage_[2];
  serviceexchangeVersionId *versionId;
  serviceexchangeMsgBodySystemTemplate *msgBodySystemTemplate;
  serviceexchangeMsgBodyUserText *msgBodyUserText;
  serviceexchangeMsgBodyUserMime *msgBodyUserMime;
  uint64_t sendTime;
  uint64_t clientSendTime;
} serviceexchangeMessageContentBody__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "versionId",
        .dataTypeSpecific.clazz = GPBObjCClass(serviceexchangeVersionId),
        .number = serviceexchangeMessageContentBody_FieldNumber_VersionId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(serviceexchangeMessageContentBody__storage_, versionId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "sendTime",
        .dataTypeSpecific.clazz = Nil,
        .number = serviceexchangeMessageContentBody_FieldNumber_SendTime,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(serviceexchangeMessageContentBody__storage_, sendTime),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "clientSendTime",
        .dataTypeSpecific.clazz = Nil,
        .number = serviceexchangeMessageContentBody_FieldNumber_ClientSendTime,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(serviceexchangeMessageContentBody__storage_, clientSendTime),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "msgBodySystemTemplate",
        .dataTypeSpecific.clazz = GPBObjCClass(serviceexchangeMsgBodySystemTemplate),
        .number = serviceexchangeMessageContentBody_FieldNumber_MsgBodySystemTemplate,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(serviceexchangeMessageContentBody__storage_, msgBodySystemTemplate),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "msgBodyUserText",
        .dataTypeSpecific.clazz = GPBObjCClass(serviceexchangeMsgBodyUserText),
        .number = serviceexchangeMessageContentBody_FieldNumber_MsgBodyUserText,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(serviceexchangeMessageContentBody__storage_, msgBodyUserText),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "msgBodyUserMime",
        .dataTypeSpecific.clazz = GPBObjCClass(serviceexchangeMsgBodyUserMime),
        .number = serviceexchangeMessageContentBody_FieldNumber_MsgBodyUserMime,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(serviceexchangeMessageContentBody__storage_, msgBodyUserMime),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[serviceexchangeMessageContentBody class]
                                     rootClass:[serviceexchangeExchangePrimaryMsgRoot class]
                                          file:serviceexchangeExchangePrimaryMsgRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(serviceexchangeMessageContentBody__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    static const char *oneofs[] = {
      "msgBody",
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

void serviceexchangeMessageContentBody_ClearMsgBodyOneOfCase(serviceexchangeMessageContentBody *message) {
  GPBDescriptor *descriptor = [serviceexchangeMessageContentBody descriptor];
  GPBOneofDescriptor *oneof = [descriptor.oneofs objectAtIndex:0];
  GPBClearOneof(message, oneof);
}
#pragma mark - serviceexchangeMsgBodySystemTemplate

@implementation serviceexchangeMsgBodySystemTemplate

@dynamic content;

typedef struct serviceexchangeMsgBodySystemTemplate__storage_ {
  uint32_t _has_storage_[1];
  NSString *content;
} serviceexchangeMsgBodySystemTemplate__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "content",
        .dataTypeSpecific.clazz = Nil,
        .number = serviceexchangeMsgBodySystemTemplate_FieldNumber_Content,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(serviceexchangeMsgBodySystemTemplate__storage_, content),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[serviceexchangeMsgBodySystemTemplate class]
                                     rootClass:[serviceexchangeExchangePrimaryMsgRoot class]
                                          file:serviceexchangeExchangePrimaryMsgRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(serviceexchangeMsgBodySystemTemplate__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - serviceexchangeMsgBodyUserText

@implementation serviceexchangeMsgBodyUserText

@dynamic content;
@dynamic refArgsArray, refArgsArray_Count;

typedef struct serviceexchangeMsgBodyUserText__storage_ {
  uint32_t _has_storage_[1];
  NSString *content;
  NSMutableArray *refArgsArray;
} serviceexchangeMsgBodyUserText__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "content",
        .dataTypeSpecific.clazz = Nil,
        .number = serviceexchangeMsgBodyUserText_FieldNumber_Content,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(serviceexchangeMsgBodyUserText__storage_, content),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "refArgsArray",
        .dataTypeSpecific.clazz = GPBObjCClass(serviceexchangeChatUser),
        .number = serviceexchangeMsgBodyUserText_FieldNumber_RefArgsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(serviceexchangeMsgBodyUserText__storage_, refArgsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[serviceexchangeMsgBodyUserText class]
                                     rootClass:[serviceexchangeExchangePrimaryMsgRoot class]
                                          file:serviceexchangeExchangePrimaryMsgRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(serviceexchangeMsgBodyUserText__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - serviceexchangeMsgBodyUserMime

@implementation serviceexchangeMsgBodyUserMime

@dynamic URL;
@dynamic mimeType;

typedef struct serviceexchangeMsgBodyUserMime__storage_ {
  uint32_t _has_storage_[1];
  serviceexchangeMimeType mimeType;
  NSString *URL;
} serviceexchangeMsgBodyUserMime__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "URL",
        .dataTypeSpecific.clazz = Nil,
        .number = serviceexchangeMsgBodyUserMime_FieldNumber_URL,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(serviceexchangeMsgBodyUserMime__storage_, URL),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "mimeType",
        .dataTypeSpecific.enumDescFunc = serviceexchangeMimeType_EnumDescriptor,
        .number = serviceexchangeMsgBodyUserMime_FieldNumber_MimeType,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(serviceexchangeMsgBodyUserMime__storage_, mimeType),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeEnum,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[serviceexchangeMsgBodyUserMime class]
                                     rootClass:[serviceexchangeExchangePrimaryMsgRoot class]
                                          file:serviceexchangeExchangePrimaryMsgRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(serviceexchangeMsgBodyUserMime__storage_)
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

int32_t serviceexchangeMsgBodyUserMime_MimeType_RawValue(serviceexchangeMsgBodyUserMime *message) {
  GPBDescriptor *descriptor = [serviceexchangeMsgBodyUserMime descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:serviceexchangeMsgBodyUserMime_FieldNumber_MimeType];
  return GPBGetMessageRawEnumField(message, field);
}

void SetserviceexchangeMsgBodyUserMime_MimeType_RawValue(serviceexchangeMsgBodyUserMime *message, int32_t value) {
  GPBDescriptor *descriptor = [serviceexchangeMsgBodyUserMime descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:serviceexchangeMsgBodyUserMime_FieldNumber_MimeType];
  GPBSetMessageRawEnumField(message, field, value);
}

#pragma mark - serviceexchangeChatUser

@implementation serviceexchangeChatUser

@dynamic hasUid, uid;
@dynamic userInfosArray, userInfosArray_Count;

typedef struct serviceexchangeChatUser__storage_ {
  uint32_t _has_storage_[1];
  utilidentitysdkIdEncode *uid;
  NSMutableArray *userInfosArray;
} serviceexchangeChatUser__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "uid",
        .dataTypeSpecific.clazz = GPBObjCClass(utilidentitysdkIdEncode),
        .number = serviceexchangeChatUser_FieldNumber_Uid,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(serviceexchangeChatUser__storage_, uid),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "userInfosArray",
        .dataTypeSpecific.clazz = GPBObjCClass(serviceexchangeChatUserInfo),
        .number = serviceexchangeChatUser_FieldNumber_UserInfosArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(serviceexchangeChatUser__storage_, userInfosArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[serviceexchangeChatUser class]
                                     rootClass:[serviceexchangeExchangePrimaryMsgRoot class]
                                          file:serviceexchangeExchangePrimaryMsgRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(serviceexchangeChatUser__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - serviceexchangeChatUserInfo

@implementation serviceexchangeChatUserInfo

@dynamic valueOneOfCase;
@dynamic key;
@dynamic textValue;
@dynamic mediaValue;

typedef struct serviceexchangeChatUserInfo__storage_ {
  uint32_t _has_storage_[2];
  NSString *key;
  NSString *textValue;
  NSString *mediaValue;
} serviceexchangeChatUserInfo__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "key",
        .dataTypeSpecific.clazz = Nil,
        .number = serviceexchangeChatUserInfo_FieldNumber_Key,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(serviceexchangeChatUserInfo__storage_, key),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "textValue",
        .dataTypeSpecific.clazz = Nil,
        .number = serviceexchangeChatUserInfo_FieldNumber_TextValue,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(serviceexchangeChatUserInfo__storage_, textValue),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "mediaValue",
        .dataTypeSpecific.clazz = Nil,
        .number = serviceexchangeChatUserInfo_FieldNumber_MediaValue,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(serviceexchangeChatUserInfo__storage_, mediaValue),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[serviceexchangeChatUserInfo class]
                                     rootClass:[serviceexchangeExchangePrimaryMsgRoot class]
                                          file:serviceexchangeExchangePrimaryMsgRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(serviceexchangeChatUserInfo__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    static const char *oneofs[] = {
      "value",
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

void serviceexchangeChatUserInfo_ClearValueOneOfCase(serviceexchangeChatUserInfo *message) {
  GPBDescriptor *descriptor = [serviceexchangeChatUserInfo descriptor];
  GPBOneofDescriptor *oneof = [descriptor.oneofs objectAtIndex:0];
  GPBClearOneof(message, oneof);
}
#pragma mark - serviceexchangeLiveUserListResponse

@implementation serviceexchangeLiveUserListResponse

@dynamic audienceCount;
@dynamic liveRoomUsersArray, liveRoomUsersArray_Count;

typedef struct serviceexchangeLiveUserListResponse__storage_ {
  uint32_t _has_storage_[1];
  uint32_t audienceCount;
  NSMutableArray *liveRoomUsersArray;
} serviceexchangeLiveUserListResponse__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "audienceCount",
        .dataTypeSpecific.clazz = Nil,
        .number = serviceexchangeLiveUserListResponse_FieldNumber_AudienceCount,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(serviceexchangeLiveUserListResponse__storage_, audienceCount),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "liveRoomUsersArray",
        .dataTypeSpecific.clazz = GPBObjCClass(serviceexchangeLiveRoomUser),
        .number = serviceexchangeLiveUserListResponse_FieldNumber_LiveRoomUsersArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(serviceexchangeLiveUserListResponse__storage_, liveRoomUsersArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[serviceexchangeLiveUserListResponse class]
                                     rootClass:[serviceexchangeExchangePrimaryMsgRoot class]
                                          file:serviceexchangeExchangePrimaryMsgRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(serviceexchangeLiveUserListResponse__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - serviceexchangeLiveRoomUser

@implementation serviceexchangeLiveRoomUser

@dynamic hasChatUser, chatUser;
@dynamic audienceRewardLevel;
@dynamic currentLivingRewardAmount;
@dynamic lastEnterLivingRoomAt;

typedef struct serviceexchangeLiveRoomUser__storage_ {
  uint32_t _has_storage_[1];
  uint32_t audienceRewardLevel;
  uint32_t currentLivingRewardAmount;
  serviceexchangeChatUser *chatUser;
  uint64_t lastEnterLivingRoomAt;
} serviceexchangeLiveRoomUser__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "chatUser",
        .dataTypeSpecific.clazz = GPBObjCClass(serviceexchangeChatUser),
        .number = serviceexchangeLiveRoomUser_FieldNumber_ChatUser,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(serviceexchangeLiveRoomUser__storage_, chatUser),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "audienceRewardLevel",
        .dataTypeSpecific.clazz = Nil,
        .number = serviceexchangeLiveRoomUser_FieldNumber_AudienceRewardLevel,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(serviceexchangeLiveRoomUser__storage_, audienceRewardLevel),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "currentLivingRewardAmount",
        .dataTypeSpecific.clazz = Nil,
        .number = serviceexchangeLiveRoomUser_FieldNumber_CurrentLivingRewardAmount,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(serviceexchangeLiveRoomUser__storage_, currentLivingRewardAmount),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "lastEnterLivingRoomAt",
        .dataTypeSpecific.clazz = Nil,
        .number = serviceexchangeLiveRoomUser_FieldNumber_LastEnterLivingRoomAt,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(serviceexchangeLiveRoomUser__storage_, lastEnterLivingRoomAt),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[serviceexchangeLiveRoomUser class]
                                     rootClass:[serviceexchangeExchangePrimaryMsgRoot class]
                                          file:serviceexchangeExchangePrimaryMsgRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(serviceexchangeLiveRoomUser__storage_)
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
