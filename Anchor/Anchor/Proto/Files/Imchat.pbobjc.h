// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: imchat.proto

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

@class imIMNewMessage;
@class imMessageCountItem;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - imImchatRoot

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
GPB_FINAL @interface imImchatRoot : GPBRootObject
@end

#pragma mark - imIMMessage

typedef GPB_ENUM(imIMMessage_FieldNumber) {
  imIMMessage_FieldNumber_ChatId = 1,
  imIMMessage_FieldNumber_MsgType = 2,
  imIMMessage_FieldNumber_Content = 3,
  imIMMessage_FieldNumber_MsgId = 4,
  imIMMessage_FieldNumber_MsgParam = 5,
};

GPB_FINAL @interface imIMMessage : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *chatId;

@property(nonatomic, readwrite) int32_t msgType;

@property(nonatomic, readwrite, copy, null_resettable) NSString *content;

@property(nonatomic, readwrite, copy, null_resettable) NSString *msgId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *msgParam;

@end

#pragma mark - imIMNewMessage

typedef GPB_ENUM(imIMNewMessage_FieldNumber) {
  imIMNewMessage_FieldNumber_Uid = 1,
  imIMNewMessage_FieldNumber_MsgType = 2,
  imIMNewMessage_FieldNumber_Content = 3,
  imIMNewMessage_FieldNumber_MsgId = 4,
  imIMNewMessage_FieldNumber_ChatId = 5,
  imIMNewMessage_FieldNumber_NickName = 6,
  imIMNewMessage_FieldNumber_Avatar = 7,
  imIMNewMessage_FieldNumber_ReceiveTime = 8,
};

GPB_FINAL @interface imIMNewMessage : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *uid;

@property(nonatomic, readwrite) int32_t msgType;

@property(nonatomic, readwrite, copy, null_resettable) NSString *content;

@property(nonatomic, readwrite, copy, null_resettable) NSString *msgId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *chatId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *nickName;

@property(nonatomic, readwrite, copy, null_resettable) NSString *avatar;

@property(nonatomic, readwrite) int64_t receiveTime;

@end

#pragma mark - imImInfo

GPB_FINAL @interface imImInfo : GPBMessage

@end

#pragma mark - imIMMessageList

typedef GPB_ENUM(imIMMessageList_FieldNumber) {
  imIMMessageList_FieldNumber_ItemListArray = 1,
  imIMMessageList_FieldNumber_Count = 2,
};

GPB_FINAL @interface imIMMessageList : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<imMessageCountItem*> *itemListArray;
/** The number of items in @c itemListArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger itemListArray_Count;

@property(nonatomic, readwrite) int32_t count;

@end

#pragma mark - imMessageCountItem

typedef GPB_ENUM(imMessageCountItem_FieldNumber) {
  imMessageCountItem_FieldNumber_Count = 1,
  imMessageCountItem_FieldNumber_ChatId = 2,
  imMessageCountItem_FieldNumber_Content = 3,
  imMessageCountItem_FieldNumber_ReceiveTime = 4,
  imMessageCountItem_FieldNumber_NickName = 5,
  imMessageCountItem_FieldNumber_Avatar = 6,
};

GPB_FINAL @interface imMessageCountItem : GPBMessage

@property(nonatomic, readwrite) int32_t count;

@property(nonatomic, readwrite, copy, null_resettable) NSString *chatId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *content;

@property(nonatomic, readwrite) int64_t receiveTime;

@property(nonatomic, readwrite, copy, null_resettable) NSString *nickName;

@property(nonatomic, readwrite, copy, null_resettable) NSString *avatar;

@end

#pragma mark - imImReadMessage

typedef GPB_ENUM(imImReadMessage_FieldNumber) {
  imImReadMessage_FieldNumber_ChatId = 1,
  imImReadMessage_FieldNumber_LastId = 2,
};

GPB_FINAL @interface imImReadMessage : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *chatId;

@property(nonatomic, readwrite) int64_t lastId;

@end

#pragma mark - imIMNewMessageList

typedef GPB_ENUM(imIMNewMessageList_FieldNumber) {
  imIMNewMessageList_FieldNumber_MsgListArray = 1,
};

GPB_FINAL @interface imIMNewMessageList : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<imIMNewMessage*> *msgListArray;
/** The number of items in @c msgListArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger msgListArray_Count;

@end

#pragma mark - imImDeleteLate

typedef GPB_ENUM(imImDeleteLate_FieldNumber) {
  imImDeleteLate_FieldNumber_ChatId = 1,
};

GPB_FINAL @interface imImDeleteLate : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *chatId;

@end

#pragma mark - imMsg_Receive_Ok

typedef GPB_ENUM(imMsg_Receive_Ok_FieldNumber) {
  imMsg_Receive_Ok_FieldNumber_MsgId = 1,
  imMsg_Receive_Ok_FieldNumber_ChatId = 2,
};

/**
 * ack 读消息
 **/
GPB_FINAL @interface imMsg_Receive_Ok : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *msgId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *chatId;

@end

#pragma mark - imIMSendMessageSuccess

typedef GPB_ENUM(imIMSendMessageSuccess_FieldNumber) {
  imIMSendMessageSuccess_FieldNumber_MsgId = 1,
  imIMSendMessageSuccess_FieldNumber_ChatId = 2,
};

GPB_FINAL @interface imIMSendMessageSuccess : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *msgId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *chatId;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
