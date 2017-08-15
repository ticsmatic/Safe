//
//  NSDictionary+XQAdd.m
//  Safe
//
//  Created by Ticsmatic on 2017/7/29.
//  Copyright © 2016 Ticsmatic. All rights reserved.
//

#import "NSDictionary+XQAdd.h"
#import <objc/runtime.h>
#import "NSObject+XQAdd.h"

@implementation NSDictionary (XQAdd)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(initWithObjects:forKeys:count:) with:@selector(gl_initWithObjects:forKeys:count:)];
        [self swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:count:) with:@selector(gl_dictionaryWithObjects:forKeys:count:)];
    });
}

+ (instancetype)gl_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key) {
            continue;
        }
        if (!obj) {
            NSLog(@"%@", kExceptionMsg);
            // obj = [NSNull null];
            continue;
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self gl_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
}

- (instancetype)gl_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key) {
            continue;
        }
        if (!obj) {
            NSLog(@"%@", kExceptionMsg);
            // obj = [NSNull null];
            continue;
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self gl_initWithObjects:safeObjects forKeys:safeKeys count:j];
}

@end

@implementation NSMutableDictionary (XQAdd)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSDictionaryM");
        [class swizzleInstanceMethod:@selector(setObject:forKey:) with:@selector(gl_setObject:forKey:)];
        [class swizzleInstanceMethod:@selector(setObject:forKeyedSubscript:) with:@selector(gl_setObject:forKeyedSubscript:)];
        [class swizzleInstanceMethod:@selector(removeObjectForKey:) with:@selector(xq_removeObjectForKey:)];
    });
}

- (void)gl_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!aKey) {
        return;
    }
    if (!anObject) {
        NSLog(@"%@", kExceptionMsg);
        // anObject = [NSNull null];
        return;
    }
    [self gl_setObject:anObject forKey:aKey];
}

- (void)gl_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!key) {
        return;
    }
    if (!obj) {
        NSLog(@"%@", kExceptionMsg);
        // obj = [NSNull null];
        return;
    }
    [self gl_setObject:obj forKeyedSubscript:key];
}

- (void)xq_removeObjectForKey:(NSString *)aKey {
    if (!aKey) {
         NSLog(@"%@", kExceptionMsg);
        return;
    }
    [self xq_removeObjectForKey:aKey];
}

@end
