//
//  KKCodeValidationModel.h
//  KK
//
//  Created by ProgramMa on 2021/9/3.
//

#import <Foundation/Foundation.h>

typedef void(^getCodeValidation)(NSInteger id_p ,NSData * _Nonnull imageSrc);
typedef void (^getSendValidation)(BOOL isScuess ,NSInteger Id_p);
NS_ASSUME_NONNULL_BEGIN

@interface KKCodeValidationModel : NSObject
@property(nonatomic,copy)getCodeValidation codeBlock;
@property(nonatomic,copy)getSendValidation sendCodeBlock;
/** 图片验证码ID */
@property(nonatomic, readwrite) uint64_t captchaId;

/** 图片验证码输入的 内容 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *code;

-(void)requestCodeVAlidation:(getCodeValidation)codeBlock;

-(void)requestSendCodeID:(NSInteger )codeId withCodeText:(NSString *)codeStr WithValidationBlock:(getSendValidation)sendBlock;
@end

NS_ASSUME_NONNULL_END
