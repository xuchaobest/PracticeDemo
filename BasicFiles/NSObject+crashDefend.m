//
//  NSObject+crashDefend.m
//  practice
//
//  Created by 许超 on 2019/11/1.
//  Copyright © 2019 许超. All rights reserved.
//

#import "NSObject+crashDefend.h"
#import <objc/runtime.h>

@implementation NSObject (crashDefend)


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
   
}

- (id)valueForUndefinedKey:(NSString *)key{
   return @"";
}


@end
