// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: appv-primary-content.proto

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

#import "AppvPrimaryContent.pbobjc.h"
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
GPBObjCClassDeclaration(appvapiShareCode);
GPBObjCClassDeclaration(appvapiUserInfoBasic);

#pragma mark - appvapiAppvPrimaryContentRoot

@implementation appvapiAppvPrimaryContentRoot

// No extensions in the file and none of the imports (direct or indirect)
// defined extensions, so no need to generate +extensionRegistry.

@end

#pragma mark - appvapiAppvPrimaryContentRoot_FileDescriptor

static GPBFileDescriptor *appvapiAppvPrimaryContentRoot_FileDescriptor(void) {
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

#pragma mark - appvapiContentSvideo

@implementation appvapiContentSvideo

@dynamic hasSvideoId, svideoId;
@dynamic title;
@dynamic hasCoverURL, coverURL;
@dynamic hasVideoURL, videoURL;
@dynamic tagsArray, tagsArray_Count;
@dynamic likes;
@dynamic isLike;
@dynamic isCollection;
@dynamic hasUserInfo, userInfo;
@dynamic comments;
@dynamic shares;
@dynamic createAt;
@dynamic hasShareCode, shareCode;
@dynamic hasFirstFrameFile, firstFrameFile;

typedef struct appvapiContentSvideo__storage_ {
  uint32_t _has_storage_[1];
  appvapiIdEncode *svideoId;
  NSString *title;
  appvapiMIMEInfo *coverURL;
  appvapiMIMEInfo *videoURL;
  NSMutableArray *tagsArray;
  appvapiUserInfoBasic *userInfo;
  appvapiShareCode *shareCode;
  appvapiMIMEInfo *firstFrameFile;
  uint64_t likes;
  uint64_t comments;
  uint64_t shares;
  uint64_t createAt;
} appvapiContentSvideo__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "svideoId",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiIdEncode),
        .number = appvapiContentSvideo_FieldNumber_SvideoId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(appvapiContentSvideo__storage_, svideoId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "title",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiContentSvideo_FieldNumber_Title,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(appvapiContentSvideo__storage_, title),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "coverURL",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiMIMEInfo),
        .number = appvapiContentSvideo_FieldNumber_CoverURL,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(appvapiContentSvideo__storage_, coverURL),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "videoURL",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiMIMEInfo),
        .number = appvapiContentSvideo_FieldNumber_VideoURL,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(appvapiContentSvideo__storage_, videoURL),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "tagsArray",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiContentTag),
        .number = appvapiContentSvideo_FieldNumber_TagsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(appvapiContentSvideo__storage_, tagsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "likes",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiContentSvideo_FieldNumber_Likes,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(appvapiContentSvideo__storage_, likes),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "isLike",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiContentSvideo_FieldNumber_IsLike,
        .hasIndex = 5,
        .offset = 6,  // Stored in _has_storage_ to save space.
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "isCollection",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiContentSvideo_FieldNumber_IsCollection,
        .hasIndex = 7,
        .offset = 8,  // Stored in _has_storage_ to save space.
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "userInfo",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiUserInfoBasic),
        .number = appvapiContentSvideo_FieldNumber_UserInfo,
        .hasIndex = 9,
        .offset = (uint32_t)offsetof(appvapiContentSvideo__storage_, userInfo),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "comments",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiContentSvideo_FieldNumber_Comments,
        .hasIndex = 10,
        .offset = (uint32_t)offsetof(appvapiContentSvideo__storage_, comments),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "shares",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiContentSvideo_FieldNumber_Shares,
        .hasIndex = 11,
        .offset = (uint32_t)offsetof(appvapiContentSvideo__storage_, shares),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "createAt",
        .dataTypeSpecific.clazz = Nil,
        .number = appvapiContentSvideo_FieldNumber_CreateAt,
        .hasIndex = 12,
        .offset = (uint32_t)offsetof(appvapiContentSvideo__storage_, createAt),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "shareCode",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiShareCode),
        .number = appvapiContentSvideo_FieldNumber_ShareCode,
        .hasIndex = 13,
        .offset = (uint32_t)offsetof(appvapiContentSvideo__storage_, shareCode),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "firstFrameFile",
        .dataTypeSpecific.clazz = GPBObjCClass(appvapiMIMEInfo),
        .number = appvapiContentSvideo_FieldNumber_FirstFrameFile,
        .hasIndex = 14,
        .offset = (uint32_t)offsetof(appvapiContentSvideo__storage_, firstFrameFile),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[appvapiContentSvideo class]
                                     rootClass:[appvapiAppvPrimaryContentRoot class]
                                          file:appvapiAppvPrimaryContentRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(appvapiContentSvideo__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\002\003\005\241!!\000\004\005\241!!\000";
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
