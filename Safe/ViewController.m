//
//  ViewController.m
//  Safe
//
//  Created by Ticsmatic on 2017/7/29.
//  Copyright © 2017年 Ticsmatic. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a
    
     [self test1];
     [self test2];
    [self test3];
}

/// NSArray+XQAdd
- (void)test1 {
    // NSArray
    NSArray *arr1 = [NSArray arrayWithObjects:@"1", @"2", nil];
    [arr1 objectAtIndex:3];
    NSArray *arr2 = [[NSArray alloc] initWithObjects:@"1", nil];
    NSLog(@"%@", arr2[3]);
    
    // NSMutableArray
    NSMutableArray *arrM1 = [NSMutableArray arrayWithArray:@[@"1", @"2", @"3"]];
     NSLog(@"%@", arrM1[10]);
    [arrM1 addObject:nil];
    [arrM1 insertObject:@"5" atIndex:5];
    [arrM1 removeObjectAtIndex:10];
    [arrM1 removeObject:@"1" inRange:NSMakeRange(10, 10)];
    [arrM1 replaceObjectAtIndex:10 withObject:@"a"];
}

/// NSDictionary+XQAdd
- (void)test2 {
     NSDictionary *dict1 = [NSDictionary dictionaryWithObjects:@[@"1", @(0)] forKeys:@[@"a", @"b"]];
    NSMutableDictionary *dictM1 = [NSMutableDictionary dictionaryWithDictionary:dict1];
    [dictM1 setObject:nil forKeyedSubscript:@"c"];
    [dictM1 setObject:nil forKey:@"c"];
    [dictM1 removeObjectForKey:nil];
    NSLog(@"%@", dictM1);
}

/// NSString+XQAdd
- (void)test3 {
    NSNumber *num = @(12);
    // use NSNumber as NSString, to invoke unrecognized exception
    NSString *str = [NSString stringWithString:num];
    NSLog(@"%@", str);
    
    // use NSString as NSNumber, to invoke unrecognized exception
    BOOL ret = [str performSelector:@selector(isEqualToNumber:) withObject:@(12)];
    NSLog(@"......%d", ret);
}

@end
