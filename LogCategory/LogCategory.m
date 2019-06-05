//
//  NSDictionary+LogCategory.m
//  TestMac
//
//  Created by yuelixing on 16/9/5.
//  Copyright © 2016年 Tutu. All rights reserved.
//

#import "LogCategory.h"
#import <objc/runtime.h>

static NSString * const kLxArrayBegin = @"[";
static NSString * const kLxArrayEnd = @"]";
static NSString * const kLxDictionaryBegin = @"{";
static NSString * const kLxDictionaryEnd = @"}";
static NSString * const kLxSetBegin = @"{(";
static NSString * const kLxSetEnd = @")}";

@implementation LogCategory

+ (void)load {
    
#ifdef UseLogChinese
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self exchangeDescriptionMethodWithClass:[NSArray class]];
        [self exchangeDescriptionMethodWithClass:[NSDictionary class]];
        [self exchangeDescriptionMethodWithClass:[NSSet class]];
    });
#endif
}

+ (void)exchangeDescriptionMethodWithClass:(Class)aClass {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    method_setImplementation(class_getInstanceMethod(aClass, @selector(debugDescription)), method_getImplementation(class_getInstanceMethod(aClass, @selector(log_debugDescription))));
    method_setImplementation(class_getInstanceMethod(aClass, @selector(description)), method_getImplementation(class_getInstanceMethod(aClass, @selector(log_description))));
    method_setImplementation(class_getInstanceMethod(aClass, @selector(descriptionWithLocale:)), method_getImplementation(class_getInstanceMethod(aClass, @selector(log_descriptionWithLocale:))));
    
#pragma clang diagnostic pop
}

@end

@implementation NSArray (Log)

- (NSString *)log_debugDescription {
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}

- (NSString *)log_description {
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}

- (NSString *)log_descriptionWithLocale:(id)locale {
    NSMutableString * string = [NSMutableString string];
    [string appendFormat:@"%@\n", kLxArrayBegin];
    NSUInteger count = self.count;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * temp = nil;
        if ([obj respondsToSelector:@selector(descriptionWithLocale:)]) {
            temp = [obj performSelector:@selector(descriptionWithLocale:) withObject:locale];
            temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
        } else {
            temp = [obj performSelector:@selector(description) withObject:nil];
            if ([obj isKindOfClass:[NSString class]]) {
                temp = [NSString stringWithFormat:@"\"%@\"", temp];
            }
        }
        [string appendFormat:@"\t%@", temp];
        if (idx+1 != count) {
            [string appendString:@","];
        }
        [string appendString:@"\n"];
    }];
    [string appendString:kLxArrayEnd];
    return string;
}


@end

@implementation NSDictionary (Log)


- (NSString *)log_debugDescription {
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}
- (NSString *)log_description {
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}
- (NSString *)log_descriptionWithLocale:(id)locale {
    NSMutableString * string = [NSMutableString string];
    [string appendFormat:@"%@\n", kLxDictionaryBegin];
    NSArray * allKeys = nil;
    if (UseLogChineseSort) {
        BOOL canCom = YES;
        for (id temp in allKeys) {
            if ([temp respondsToSelector:@selector(compare:)] == NO) {
                canCom = NO;
                break;
            }
        }
        if (canCom) {
            allKeys = [self.allKeys sortedArrayUsingSelector:@selector(compare:)];
        } else {
            allKeys = self.allKeys;
        }
    } else {
        allKeys = self.allKeys;
    }
    NSUInteger count = allKeys.count;
    for (id key in allKeys) {
        NSInteger index = [allKeys indexOfObject:key];
        id value = [self objectForKey:key];
        NSString * temp = nil;
        if ([value respondsToSelector:@selector(descriptionWithLocale:)]) {
            temp = [value performSelector:@selector(descriptionWithLocale:) withObject:locale];
            temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
        } else {
            temp = [value performSelector:@selector(description) withObject:nil];
            if ([value isKindOfClass:[NSString class]]) {
                temp = [NSString stringWithFormat:@"\"%@\"", temp];
            }
        }
        [string appendFormat:@"\t%@ = %@", key, temp];
        if (index+1 != count) {
            [string appendString:@";"];
        }
        [string appendString:@"\n"];
    }
    [string appendString:kLxDictionaryEnd];
    return string;
    
}


@end



@implementation NSSet (Log)


- (NSString *)log_debugDescription {
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}
- (NSString *)log_description {
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}
- (NSString *)log_descriptionWithLocale:(id)locale {
    NSMutableString * string = [NSMutableString string];
    [string appendFormat:@"%@\n", kLxSetBegin];
    NSUInteger count = self.count;
    __block NSInteger idx = 0;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString * temp = nil;
        if ([obj respondsToSelector:@selector(descriptionWithLocale:)]) {
            temp = [obj performSelector:@selector(descriptionWithLocale:) withObject:locale];
            temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
        } else {
            temp = [obj performSelector:@selector(description) withObject:nil];
            if ([obj isKindOfClass:[NSString class]]) {
                temp = [NSString stringWithFormat:@"\"%@\"", temp];
            }
        }
        [string appendFormat:@"\t%@", temp];
        if (idx+1 != count) {
            [string appendString:@","];
        }
        [string appendString:@"\n"];
        idx += 1;
    }];
    [string appendString:kLxSetEnd];
    return string;
    
}

@end

