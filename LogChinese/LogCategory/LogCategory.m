//
//  NSDictionary+LogCategory.m
//  TestMac
//
//  Created by yuelixing on 16/9/5.
//  Copyright © 2016年 Tutu. All rights reserved.
//

#import "LogCategory.h"
#import <objc/runtime.h>


@implementation NSArray (Log)

#ifdef UseLogChinese

+ (IMP)getSelectorIMP:(SEL)selector {
    return class_getMethodImplementation([self class], selector);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Old <%@ %p> %@", self.className, self, [self descriptionWithLocale:nil]];
}

- (NSString *)newDescription {
    return [NSString stringWithFormat:@"New <%@ %p> %@", self.className, self, [self descriptionWithLocale:nil]];
}


- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString * string = [NSMutableString string];
    [string appendString:@"[\n"];
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
    [string appendString:@"]"];
    return string;
}

#endif

@end

@implementation NSDictionary (Log)

#ifdef UseLogChinese
- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p> %@", self.className, self, [self descriptionWithLocale:nil]];
}
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString * string = [NSMutableString string];
    [string appendString:@"{\n"];
    NSUInteger count = self.allKeys.count;
    for (id key in self.allKeys) {
        NSInteger index = [self.allKeys indexOfObject:key];
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
    [string appendString:@"}"];
    return string;

}

#endif
@end


@interface LogHelper : NSObject

@end

@implementation LogHelper

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSLog(@"Start Hook");
//        @try {
//            Method desMethod = class_getInstanceMethod([NSArray class], @selector(description));
//            IMP newImp = [NSArray getSelectorIMP:@selector(newDescription)];
//            method_setImplementation(desMethod, newImp);
//            NSLog(@"End Hook");
//        } @catch (NSException *exception) {
//            NSLog(@"%@", exception);
//        } @finally {
//            
//        }
//    });
//}

@end
