//
//  NSString+avoidCrash.h
//  Safe
//
//  Created by Ticsmatic on 2017/7/29.
//  Copyright © 2016年 Ticsmatic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (avoidCrash)

@end

@interface NSString (avoidCrash)
@property (nonatomic, strong) NSNumber *num;
@end
