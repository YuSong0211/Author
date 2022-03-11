//
//  NSData+KKDataGatory.m
//  mt
//
//  Created by 小鱼 on 2021/9/17.
//

#import "NSData+KKDataGatory.h"

@implementation NSData (KKDataGatory)
+(NSData*)encode:(NSData*)src{
    Byte* role =  (Byte*)([src bytes]);
    uint8_t*bytes =malloc(sizeof(*bytes)* src.length);
    for(int i=0;i<[src length];i++)
    {
        bytes[i] = role[i]^123;
    }
    NSData*result = [[NSData alloc]initWithBytes:bytes length:src.length];
    return  result;
}




@end
