//
//  NSDictionary+LogCategory.m
//  TestMac
//
//  Created by yuelixing on 16/9/5.
//  Copyright © 2016年 Tutu. All rights reserved.
//

#import "LogCategory.h"
//#import <objc/runtime.h>

static NSString * const kLxArrayBegin = @"[";
static NSString * const kLxArrayEnd = @"]";
static NSString * const kLxDictionaryBegin = @"{";
static NSString * const kLxDictionaryEnd = @"}";
static NSString * const kLxSetBegin = @"{(";
static NSString * const kLxSetEnd = @")}";

@implementation NSArray (Log)

#ifdef UseLogChinese

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}

- (NSString *)descriptionWithLocale:(id)locale {
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

#endif

@end

@implementation NSDictionary (Log)

#ifdef UseLogChinese

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}
- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}
- (NSString *)descriptionWithLocale:(id)locale {
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

#endif
@end



@implementation NSSet (Log)

#ifdef UseLogChinese

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}
- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}
- (NSString *)descriptionWithLocale:(id)locale {
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

#endif
@end

