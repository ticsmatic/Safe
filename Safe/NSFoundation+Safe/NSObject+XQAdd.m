//
//  NSObject+XQAdd.m
//  Safe
//
//  Created by Ticsmatic on 2017/7/29.
//  Copyright © 2017年 Ticsmatic. All rights reserved.
//

#import "NSObject+XQAdd.h"
#import <objc/objc.h>
#import <objc/runtime.h>

@implementation NSObject (XQAdd)

+ (void)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSel);
    Method newMethod = class_getInstanceMethod(class, newSel);
    
    BOOL didAddMethod = class_addMethod(class,
                                        originalSel,
                                        method_getImplementation(newMethod),
                                        method_getTypeEncoding(newMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            newSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel {
    Class class = object_getClass(self);
    Method originalMethod = class_getInstanceMethod(class, originalSel);
    Method newMethod = class_getInstanceMethod(class, newSel);
    if (!originalMethod || !newMethod) return NO;
    method_exchangeImplementations(originalMethod, newMethod);
    return YES;
}


@end


@implementation NSNull (NilSafe)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(methodSignatureForSelector:) with:@selector(gl_methodSignatureForSelector:)];
        [self swizzleInstanceMethod:@selector(forwardInvocation:) with:@selector(gl_forwardInvocation:)];
    });
}

- (NSMethodSignature *)gl_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig = [self gl_methodSignatureForSelector:aSelector];
    if (sig) {
        return sig;
    }
    return [NSMethodSignature signatureWithObjCTypes:@encode(void)];
}

- (void)gl_forwardInvocation:(NSInvocation *)anInvocation {
    NSUInteger returnLength = [[anInvocation methodSignature] methodReturnLength];
    if (!returnLength) {
        // nothing to do
        return;
    }
    
    // set return value to all zero bits
    char buffer[returnLength];
    memset(buffer, 0, returnLength);
    
    [anInvocation setReturnValue:buffer];
}

@end
