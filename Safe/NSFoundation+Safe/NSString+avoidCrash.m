//
//  NSString+avoidCrash.m
//  Safe
//
//  Created by Ticsmatic on 2017/7/29.
//  Copyright © 2016年 Ticsmatic. All rights reserved.
//

#import "NSString+avoidCrash.h"
#import "NSObject+XQAdd.h"
#import <objc/runtime.h>

static NSString *__checkString = @"1";

@implementation NSNumber (avoidCrash)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(respondsToSelector:) with:@selector(swizzle_respondsToSelector:)];
        [self swizzleInstanceMethod:@selector(forwardingTargetForSelector:) with:@selector(swizzle_forwardingTargetForSelector:)];
    });
}

- (BOOL)swizzle_respondsToSelector:(SEL)aSelector {
    if ([self swizzle_respondsToSelector:aSelector]) {
        return YES;
    }
    if ([__checkString respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

- (id)swizzle_forwardingTargetForSelector:(SEL)aSelector {
    // whether NSString respondsToSelector
    if ([__checkString respondsToSelector:aSelector]) {
        return [NSString stringWithFormat:@"%@", self];
    }
    // Returns the object to which unrecognized messages should first be directed
    return [super forwardingTargetForSelector:aSelector];
}

@end


static char nameKey = 'n';

@implementation NSString (avoidCrash)

- (NSNumber *)num {
    return objc_getAssociatedObject(self, &nameKey);
}

- (void)setNum:(NSNumber *)num {
    objc_setAssociatedObject(self, &nameKey,num,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(respondsToSelector:) with:@selector(swizzle_respondsToSelector:)];
        [self swizzleInstanceMethod:@selector(forwardingTargetForSelector:) with:@selector(swizzle_forwardingTargetForSelector:)];
    });
}

- (BOOL)swizzle_respondsToSelector:(SEL)aSelector {
    if ([self swizzle_respondsToSelector:aSelector]) {
        return YES;
    }
    if ([self.num respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

- (id)swizzle_forwardingTargetForSelector:(SEL)aSelector {
    self.num = @(1);
    if ([self.num respondsToSelector:aSelector]) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        return [numberFormatter numberFromString:self];
    }
    return [super forwardingTargetForSelector:aSelector];
}
@end
