//
//  ViewController.m
//  LogChinese_iOS
//
//  Created by yuelixing on 16/9/9.
//  Copyright © 2016年 Tutu. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"
#import "Logger.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * array= @[@"数组元素0", @"数组元素1   ", @28, @{
                           @"key0": @"value",
                           @"key1": @"valuevalue",
                           @"key2": @"valuevaluevalue"
                           }];
    NSDictionary * dict = @{
                            @"name": @"asdh\n红",
                            @"array": array
                            };
    NSMutableDictionary * dictM = [[NSMutableDictionary alloc] initWithDictionary:dict];
    [dictM setObject:[ViewController new] forKey:@"newkey"];
    [dictM setObject:[NSException exceptionWithName:@"异常" reason:@"reason" userInfo:@{
                                                                                      @"name": @"小红"
                                                                                      }] forKey:@"NSException"];
    //    NSLog(@"%@", array);
    NSLog(@"%@", dict);
    NSLog(@"%@", dictM);
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        if (i == 0) {
            [temp addObject:[TestView new]];
        } else {
            [temp addObject:[UIButton buttonWithType:UIButtonTypeCustom]];
        }
    }
    NSLog(@"%@", temp);
}

@end
