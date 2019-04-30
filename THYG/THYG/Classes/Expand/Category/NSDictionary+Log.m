////
////  NSDictionary+Log.m
////  THYG
////
////  Created by Mac on 2018/4/6.
////  Copyright © 2018年 THYG. All rights reserved.
////
//
////*
//#ifndef TARGET_NEED_UNICODE_CONVERSION
//    #ifdef DEBUG
//    #define TARGET_NEED_UNICODE_CONVERSION 1
//    #else
//    #define TARGET_NEED_UNICODE_CONVERSION 0
//    #endif
//#endif
//
//#if TARGET_NEED_UNICODE_CONVERSION
//#import <objc/runtime.h>
//#endif
//
// //*/
//
//#import "NSDictionary+Log.h"
//
////*
//@implementation NSDictionary (Log)
//
//#if TARGET_NEED_UNICODE_CONVERSION
//
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        yy_swizzleSelector([self class], @selector(descriptionWithLocale:indent:), @selector(yy_descriptionWithLocale:indent:));
//    });
//}
//
//static inline void yy_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector)
//{
//    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
//    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
//
//    BOOL didAddMethod =
//    class_addMethod(theClass,
//                    originalSelector,
//                    method_getImplementation(swizzledMethod),
//                    method_getTypeEncoding(swizzledMethod));
//
//    if (didAddMethod) {
//        class_replaceMethod(theClass,
//                            swizzledSelector,
//                            method_getImplementation(originalMethod),
//                            method_getTypeEncoding(originalMethod));
//    } else {
//        method_exchangeImplementations(originalMethod, swizzledMethod);
//    }
//}
//
//- (NSString *)yy_descriptionWithLocale:(id)locale indent:(NSUInteger)level
//{
//    return [self stringByReplaceUnicode:[self yy_descriptionWithLocale:locale indent:level]];
//}
//#endif
//
//- (NSString *)stringByReplaceUnicode:(NSString *)unicodeString
//{
//    NSMutableString *convertedString = [unicodeString mutableCopy];
//    [convertedString replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0, convertedString.length)];
//    CFStringRef transform = CFSTR("Any-Hex/Java");
//    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
//
//    return convertedString;
//}
//
//
//@end
////*/
//
////@implementation NSDictionary (Log)
//
////- (NSString *)descriptionWithLocale:(id)locale {
////
////    NSMutableString *string = [NSMutableString string];
////
////    // 开头有个{
////    [string appendString:@"{\n"];
////
////    // 遍历所有的键值对
////    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
////        [string appendFormat:@"\t%@", key];
////        [string appendString:@" : "];
////        [string appendFormat:@"%@,\n", obj];
////    }];
////
////    // 结尾有个}
////    [string appendString:@"}"];
////
////    // 查找最后一个逗号
////    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
////    if (range.location != NSNotFound)
////        [string deleteCharactersInRange:range];
////
////    return string;
////}
//
////@end
////
////@implementation NSArray (Log)
//
////- (NSString *)descriptionWithLocale:(id)locale {
////    NSMutableString *string = [NSMutableString string];
////
////    // 开头有个[
////    [string appendString:@"[\n"];
////
////    // 遍历所有的元素
////    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
////        [string appendFormat:@"\t%@,\n", obj];
////    }];
////    // 结尾有个]
////    [string appendString:@"]"];
////
////    // 查找最后一个逗号
////    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
////    if (range.location != NSNotFound)
////        [string deleteCharactersInRange:range];
////
////    return string;
////}
//
////@end
//
