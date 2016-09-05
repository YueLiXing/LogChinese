//
//  main.m
//  LogChinese
//
//  Created by yuelixing on 16/9/5.
//  Copyright © 2016年 Tutu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogCategory.h"
#import "Test.h"

int main(int argc, const char * argv[]) {
    
    NSArray * array= @[@"数组元素0", @"数组元素1   "];
    NSDictionary * dict = @{
                            @"name": @"小红",
                            @"array": array
                            };
    NSMutableDictionary * dictM = [[NSMutableDictionary alloc] initWithDictionary:dict];
    [dictM setObject:[Test new] forKey:@"newkey"];
    NSLog(@"%@", array);
    NSLog(@"%@", dictM);
    NSLog(@"%@", @[dictM, @{
                       @"key": @2
                       }]);
    return 0;
}
