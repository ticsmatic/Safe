//
//  NSObject+XQAdd.h
//  Safe
//
//  Created by Ticsmatic on 2017/7/29.
//  Copyright © 2017年 Ticsmatic. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kExceptionMsg [NSString stringWithFormat:@"异常产生%s exception happened, message:%@", __func__, [NSThread callStackSymbols]]

@interface NSObject (XQAdd)

+ (void)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;
+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;

@end


@interface NSNull (NilSafe)

@end
