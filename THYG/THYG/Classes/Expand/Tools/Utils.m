//
//  Utils.m
//  THYG
//
//  Created by Victory on 2018/3/21.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "Utils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Utils

+ (NSString *)md5:(NSString *)inputString
{
	const char *cStr = [inputString UTF8String];
	unsigned char result[16];
	CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
	return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];
}

+(BOOL)CheckPhoneNum:(NSString *)inputString{
    NSString *Regex =@"^[1][3-8]+\\d{9}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [mobileTest evaluateWithObject:inputString];
}

+ (BOOL)checkPassword:(NSString *)inputString
{
    NSString *pattern = @"^[a-zA-Z0-9]{6,12}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:inputString];
    return isMatch;
}

@end
