//
//  ViewController0+VC0.m
//  practice
//
//  Created by 许超 on 2019/10/20.
//  Copyright © 2019 许超. All rights reserved.
//

#import "ViewController0+VC0.h"
#import <objc/runtime.h>

static NSString * namekey = @"namekey";

@implementation ViewController0 (VC0)

-(void)setName:(NSString *)name{
   objc_setAssociatedObject(self, &namekey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)name{
   return  objc_getAssociatedObject(self, &namekey);
}

@end
