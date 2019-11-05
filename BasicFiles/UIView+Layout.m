//
//  UIView+Layout.m
//  practice
//
//  Created by 许超 on 2019/7/21.
//  Copyright © 2019 许超. All rights reserved.
//

#import "UIView+Layout.h"
#import <objc/runtime.h>

@implementation UIView (Layout)

#pragma mark - implement set and get function of global parameters

- (void)setWidth:(CGFloat)width{
   CGRect frame = self.frame;
   frame.size.width = width;
   self.frame = frame;
}

- (void)setHeight:(CGFloat)height{
   CGRect frame = self.frame;
   frame.size.height = height;
   self.frame = frame;
}

- (void)setTop:(CGFloat)top{
   CGRect frame = self.frame;
   frame.origin.y = top;
   self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom{
   CGRect frame = self.frame;
   frame.origin.y = bottom - frame.size.height;
   self.frame = frame;
}

- (void)setLeft:(CGFloat)left{
   CGRect frame = self.frame;
   frame.origin.x = left;
   self.frame = frame;
}

- (void)setRight:(CGFloat)right{
   CGRect frame = self.frame;
   frame.origin.x = right - frame.size.width;
   self.frame = frame;
}

- (void)setCenterx:(CGFloat)centerx{
   CGRect frame = self.frame;
   frame.origin.x = centerx - frame.size.width/2;
   self.frame = frame;
}

- (void)setCentery:(CGFloat)centery{
   CGRect frame = self.frame;
   frame.origin.y = centery - frame.size.height/2;
   self.frame = frame;
}

- (void)setSize:(CGSize)size{
   CGRect frame = self.frame;
   frame.size = size;
   self.frame = frame;
}

- (void)setName:(NSString *)name{
   objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)width{
   return self.frame.size.width;
}

- (CGFloat)height{
   return self.frame.size.height;
}

- (CGFloat)left{
   return self.frame.origin.x;
}

- (CGFloat)right{
   return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)top{
   return self.frame.origin.y;
}

- (CGFloat)bottom{
   return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)centerx{
   return self.center.x;
}

- (CGFloat)centery{
   return self.center.y;
}

- (CGSize)size{
   return self.frame.size;
}

- (NSString *)name{
   return objc_getAssociatedObject(self, @selector(name));
}

+(void)initDefineParameters{
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      CGSize ss = [UIScreen mainScreen].bounds.size;
      WS = ss.width;
      HS = ss.height;
      HSB = [[UIApplication sharedApplication]statusBarFrame].size.height;
      HN = HSB + 44;
      BOOL anomalySrc = HSB>20;
      if (anomalySrc) {
         HBR = 34;
      } else {
         HBB = 0;
      }
      HBB = HBR + 49;
   });
}

+(CGFloat)getSW{
   return WS;
}

+(CGFloat)getSH{
   return HS;
}

+(CGFloat)getHSB{
   return HSB;
}

+(CGFloat)getHN{
   return HN;
}

+(CGFloat)getHBR{
   return HBR;
}

+(CGFloat)getHBB{
   return HBB;
}
@end
