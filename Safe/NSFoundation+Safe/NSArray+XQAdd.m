//
//  NSArray+XQAdd.m
//  Safe
//
//  Created by Ticsmatic on 2017/7/29.
//  Copyright © 2017年 Ticsmatic. All rights reserved.
//

#import "NSArray+XQAdd.h"
#import "NSObject+XQAdd.h"
#import <objc/runtime.h>

@implementation NSArray (XQAdd)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("__NSArray0") swizzleInstanceMethod:@selector(objectAtIndex:) with:@selector(xq_empty:)];
        // alloc init, [..., nil]
        [objc_getClass("__NSArrayI") swizzleInstanceMethod:@selector(objectAtIndex:) with:@selector(xq_objectAtIndex:)];
        // [@"1"]
        [objc_getClass("__NSSingleObjectArrayI") swizzleInstanceMethod:@selector(objectAtIndex:) with:@selector(xq_sg_objectAtIndex:)];
    });
}

- (id)xq_empty:(NSInteger)index {
    NSLog(@"%@", kExceptionMsg);
    return nil;
}

- (id)xq_objectAtIndex:(NSInteger)index {
    if (index >= self.count || index < 0 || !self.count) {
        NSLog(@"%@", kExceptionMsg);
        return nil;
    }
    return [self xq_objectAtIndex:index];
}

- (id)xq_sg_objectAtIndex:(NSInteger)index {
    if (index >= self.count || index < 0 || !self.count) {
        if (self.count) {
            NSLog(@"%@", kExceptionMsg);
        }
        return nil;
    }
    return [self xq_sg_objectAtIndex:index];
}

@end


@implementation NSMutableArray (XQAdd)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSArrayM");
        [class swizzleInstanceMethod:@selector(objectAtIndex:) with:@selector(xq_m_objectAtIndex:)];
        [class swizzleInstanceMethod:@selector(insertObject:atIndex:) with:@selector(xq_insertObject:atIndex:)];
        [class swizzleInstanceMethod:@selector(addObject:) with:@selector(xq_addObject:)];
        [class swizzleInstanceMethod:@selector(removeObjectsInRange:) with:@selector(xq_removeObjectsInRange:)];
        [class swizzleInstanceMethod:@selector(removeObject:inRange:) with:@selector(xq_removeObject:inRange:)];
        [class swizzleInstanceMethod:@selector(replaceObjectAtIndex:withObject:) with:@selector(xq_replaceObjectAtIndex:withObject:)];
    });
}

- (id)xq_m_objectAtIndex:(NSInteger)index {
    if (index >= self.count || index < 0) {
        if (self.count) {
            NSLog(@"%@", kExceptionMsg);
        }
        return nil;
    }
    return [self xq_m_objectAtIndex:index];
}

- (void)xq_insertObject:(id)obj atIndex:(NSInteger)index {
    if (obj && index <= self.count && ![obj isKindOfClass:[NSNull class]]) {
        [self xq_insertObject:obj atIndex:index];
    } else {
        // here be invoke frequenty by system, usually because the obj is nil, so i add the filter
        if (self.count) {
            NSLog(@"%@", kExceptionMsg);
        }
    }
}

- (void)xq_addObject:(id)obj {
    if (obj) {
        [self xq_addObject:obj];
    } else {
        NSLog(@"%@", kExceptionMsg);
    }
}

- (void)xq_removeObjectsInRange:(NSRange)range {
    if (range.location > self.count || range.length > self.count || (range.location + range.length) > self.count) {
        NSLog(@"%@", kExceptionMsg);
        return;
    }
    return [self xq_removeObjectsInRange:range];
}

- (void)xq_removeObject:(id)obj inRange:(NSRange)range {
    if (range.location > self.count || range.length > self.count || (range.location + range.length) > self.count || !obj) {
        NSLog(@"%@", kExceptionMsg);
        return;
    }
    return [self xq_removeObject:obj inRange:range];
}

- (void)xq_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (anObject && index < self.count) {
        [self xq_replaceObjectAtIndex:index withObject:anObject];
    } else {
       NSLog(@"%@", kExceptionMsg);
    }
}
@end
