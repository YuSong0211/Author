// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: appv-primary-community.proto

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

#import "AppvPrimaryCommunity.pbobjc.h"
#import "AppvBasic.pbobjc.h"
#import "AppvPrimaryTag.pbobjc.h"
#import "AppvUser.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdollar-in-identifier-extension"

#pragma mark - Objective C Class declarations
// Forward declarations of Objective C classes that we can use as
// static values in struct initializers.
// We don't use [Foo class] because it is not a static value.
GPBObjCClassDeclaration(appvapiContentTag);
GPBObjCClassDeclaration(appvapiIdEncode);
GPBObjCClassDeclaration(appvapiMIMEInfo);
GPBObjCClassDeclaration(appvapiUserInfoBasic);

#pragma mark - appvapiAppvPrimaryCommunityRoot

@implementation appvapiAppvPrimaryCommunityRoot

// No extensions in the file and none of the imports (direct or indirect)
// defined extensions, so no need to generate +extensionRegistry.

@end

#pragma mark - appvapiAppvPrimaryCommunityRoot_FileDescriptor

static GPBFileDescriptor *appvapiAppvPrimaryCommunityRoot_FileDescriptor(void) {
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

#pragma mark - Enum appvapiCommunityPostResourceType

GPBEnumDescriptor *appvapiCommunityPostResourceType_EnumDescriptor(void) {
  static _Atomic(GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    static const char *valueNames =
        "CommunityPostResourceTypeUnspecified\000Com"
        "munityPostResourceTypePicture\000CommunityP"
        "ostResourceTypeVideo\000";
    static const int32_t values[] = {
        appvapiCommunityPostResourceType_CommunityPostResourceTypeUnspecified,
        appvapiCommunityPostResourceType_CommunityPostResourceTypePicture,
        appvapiCommunityPostResourceType_CommunityPostResourceTypeVideo,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(appvapiCommunityPostResourceType)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:appvapiCommunityPostResourceType_IsValidValue];
    GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
      
    }
  }
  return descriptor;
}

BOOL appvapiCommunityPostResourceType_IsValidValue(int32_t value__) {
  switch (value__) {
    case appvapiCommunityPostResourceType_CommunityPostResourceTypeUnspecified:
    case appvapiCommunityPostResourceType_CommunityPostResourceTypePicture:
    case appvapiCommunityPostResourceType_CommunityPostResourceTypeVideo:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - Enum appvapiContentCommunityPostStatus

GPBEnumDescriptor *appvapiContentCommunityPostStatus_EnumDescriptor(void) {
  static _Atomic(GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    static const char *valueNames =
        "ContentCommunityPostStatusUnspecified\000Co"
        "ntentCommunityPostStatusAuditing\000Content"
        "CommunityPostStatusAuditDeny\000ContentComm"
        "unityPostStatusAuditPass\000";
    static const int32_t values[] = {
        appvapiContentCommunityPostStatus_ContentCommunityPostStatusUnspecified,
        appvapiContentCommunityPostStatus_ContentCommunityPostStatusAuditing,
        appvapiContentCommunityPostStatus_ContentCommunityPostStatusAuditDeny,
        appvapiContentCommunityPostStatus_ContentCommunityPostStatusAuditPass,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(appvapiContentCommunityPostStatus)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:appvapiContentCommunityPostStatus_IsValidValue];
    GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
      
    }
  }
  return descriptor;
}

BOOL appvapiContentCommunityPostStatus_IsValidValue(int32_t value__) {
  switch (value__) {
    case appvapiContentCommunityPostStatus_ContentCommunityPostStatusUnspecified:
    case appvapiContentCommunityPostStatus_ContentCommunityPostStatusAuditing:
    case appvapiContentCommunityPostStatus_ContentCommunityPostStatusAuditDeny:
    case appvapiContentCommunityPostStatus_ContentCommunityPostStatusAuditPass:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - appvapiCommunityPost

@implementation appvapiCommunityPost

@dynamic hasId_p, id_p;
@dynamic hasUserInfoBasic, userInfoBasic;
@dynamic content;
@dynamic communityPostResourceType;
@dynamic resourcesArray, resourcesArray_Count;
@dynamic starNumber;
@dynamic commentNumber;
@dynamic collectNumber;
@dynamic createAt;
@dynamic contentCommunityPostStatus;
@dynamic tagsArray, tagsArray_Count;
@dynamic isLike;
@dynamic isCollection;
@dynamic hasCoverURL, coverURL;
@dynamic auditReason;
@dynamic isFollow;
@dynamic isTop;
@dynamic pictureThumbnailsArray, pictureThumbnailsArray_Count;

typedef struct appvapiCommunityPost__storage_ {
  uint32_t _has_storage_[1];
  appvapiCommunityPostResourceType communityPostResourceType;
  appvapiContentCommunityPostStatus contentCommunityPostStatus;
  appvapiIdEncode *id_p;
  appvapiUserInfoBasic *userInfoBasic;
  NSString *content;
  NSMutableArray *resourcesArray;
  NSMutableArray *tagsArray;
  appvapiMIMEInfo *coverURL;
  NSString *auditReason;
  NSMutableArray *pictureThumbnailsArray;
  uint64_t starNumber;
  uint64_t commentNumber;
  uint64_t collectNumber;
  uint64_t createAt;
} appvapiCommunityPost__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiIdEncode),
        .number = appvapiCommunityPost_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(appvapiCommunityPost__storage_, id_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "userInfoBasic",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiUserInfoBasic),
        .number = appvapiCommunityPost_FieldNumber_UserInfoBasic,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(appvapiCommunityPost__storage_, userInfoBasic),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "content",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiCommunityPost_FieldNumber_Content,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(appvapiCommunityPost__storage_, content),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "communityPostResourceType",
        .dataTypeSpecific.enumDescFunc = appvapiCommunityPostResourceType_EnumDescriptor,
        .number = appvapiCommunityPost_FieldNumber_CommunityPostResourceType,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(appvapiCommunityPost__storage_, communityPostResourceType),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "resourcesArray",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiMIMEInfo),
        .number = appvapiCommunityPost_FieldNumber_ResourcesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(appvapiCommunityPost__storage_, resourcesArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "starNumber",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiCommunityPost_FieldNumber_StarNumber,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(appvapiCommunityPost__storage_, starNumber),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "commentNumber",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiCommunityPost_FieldNumber_CommentNumber,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(appvapiCommunityPost__storage_, commentNumber),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "collectNumber",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiCommunityPost_FieldNumber_CollectNumber,
        .hasIndex = 6,
        .offset = (uint32_t)offsetof(appvapiCommunityPost__storage_, collectNumber),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "createAt",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiCommunityPost_FieldNumber_CreateAt,
        .hasIndex = 7,
        .offset = (uint32_t)offsetof(appvapiCommunityPost__storage_, createAt),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "contentCommunityPostStatus",
        .dataTypeSpecific.enumDescFunc = appvapiContentCommunityPostStatus_EnumDescriptor,
        .number = appvapiCommunityPost_FieldNumber_ContentCommunityPostStatus,
        .hasIndex = 8,
        .offset = (uint32_t)offsetof(appvapiCommunityPost__storage_, contentCommunityPostStatus),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "tagsArray",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiContentTag),
        .number = appvapiCommunityPost_FieldNumber_TagsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(appvapiCommunityPost__storage_, tagsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "isLike",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiCommunityPost_FieldNumber_IsLike,
        .hasIndex = 9,
        .offset = 10,  // Stored in _has_storage_ to save space.
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "isCollection",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiCommunityPost_FieldNumber_IsCollection,
        .hasIndex = 11,
        .offset = 12,  // Stored in _has_storage_ to save space.
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "coverURL",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiMIMEInfo),
        .number = appvapiCommunityPost_FieldNumber_CoverURL,
        .hasIndex = 13,
        .offset = (uint32_t)offsetof(appvapiCommunityPost__storage_, coverURL),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "auditReason",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiCommunityPost_FieldNumber_AuditReason,
        .hasIndex = 14,
        .offset = (uint32_t)offsetof(appvapiCommunityPost__storage_, auditReason),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "isFollow",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiCommunityPost_FieldNumber_IsFollow,
        .hasIndex = 15,
        .offset = 16,  // Stored in _has_storage_ to save space.
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "isTop",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiCommunityPost_FieldNumber_IsTop,
        .hasIndex = 17,
        .offset = 18,  // Stored in _has_storage_ to save space.
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "pictureThumbnailsArray",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiMIMEInfo),
        .number = appvapiCommunityPost_FieldNumber_PictureThumbnailsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(appvapiCommunityPost__storage_, pictureThumbnailsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiCommunityPost class]
                                     rootClass:[appvapiAppvPrimaryCommunityRoot class]
                                          file:appvapiAppvPrimaryCommunityRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiCommunityPost__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\001\016\005\241!!\000";
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

int32_t appvapiCommunityPost_CommunityPostResourceType_RawValue(appvapiCommunityPost *message) {
  GPBDescriptor *descriptor = [appvapiCommunityPost descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:appvapiCommunityPost_FieldNumber_CommunityPostResourceType];
  return GPBGetMessageRawEnumField(message, field);
}

void SetappvapiCommunityPost_CommunityPostResourceType_RawValue(appvapiCommunityPost *message, int32_t value) {
  GPBDescriptor *descriptor = [appvapiCommunityPost descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:appvapiCommunityPost_FieldNumber_CommunityPostResourceType];
  GPBSetMessageRawEnumField(message, field, value);
}

int32_t appvapiCommunityPost_ContentCommunityPostStatus_RawValue(appvapiCommunityPost *message) {
  GPBDescriptor *descriptor = [appvapiCommunityPost descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:appvapiCommunityPost_FieldNumber_ContentCommunityPostStatus];
  return GPBGetMessageRawEnumField(message, field);
}

void SetappvapiCommunityPost_ContentCommunityPostStatus_RawValue(appvapiCommunityPost *message, int32_t value) {
  GPBDescriptor *descriptor = [appvapiCommunityPost descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:appvapiCommunityPost_FieldNumber_ContentCommunityPostStatus];
  GPBSetMessageRawEnumField(message, field, value);
}


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)