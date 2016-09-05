//
//  main.m
//  LogChinese
//
//  Created by yuelixing on 16/9/5.
//  Copyright © 2016年 Tutu. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "LogCategory.h"
#import "Test.h"

int main(int argc, const char * argv[]) {
    
    NSArray * array= @[@"数组元素0", @"数组元素1   ", @28];
    NSDictionary * dict = @{
                            @"name": @"小红",
                            @"array": array
                            };
    NSMutableDictionary * dictM = [[NSMutableDictionary alloc] initWithDictionary:dict];
    [dictM setObject:[Test new] forKey:@"newkey"];
    NSLog(@"%@", array);
    NSLog(@"%@", [array description]);
//    NSLog(@"%@", dictM);
//    NSLog(@"%@", @[dictM, @{
//                       @"key": @2
//                       }]);
//    NSLog(@"%@", @[array, array]);
//    NSLog(@"%@", @[
//  @[
//  @[
//  @[
//      @"你好"
//      ]
//  ],@1,@"asd"
//  ],@{
//      @"namge":@"星星老师",
//      @"image":[Test new]
//      }
//  ]);
    return 0;
}
