//
//  FPSObserver.m
//  practice
//
//  Created by 许超 on 2019/7/24.
//  Copyright © 2019 许超. All rights reserved.
//

#import "FPSObserver.h"

@implementation FPSObserver
{
   CADisplayLink *_link;
   NSInteger count;
   NSTimeInterval _lastTime;
}
+(void)showOnView:(UIView *)view{
   FPSObserver *observer = [[FPSObserver alloc]initWithFrame:CGRectMake(20, Height_Nav+20, 50, 20)];
   [view addSubview:observer];
}

- (instancetype)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self)
   {
      self.font=[UIFont boldSystemFontOfSize:12];
      self.textColor=[UIColor colorWithRed:0.33 green:0.84 blue:0.43 alpha:1.00];
      self.backgroundColor=[UIColor clearColor];
      self.textAlignment = NSTextAlignmentCenter;
      
      _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
      [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
      _link.paused = YES;
      
      [[NSNotificationCenter defaultCenter] addObserver: self
                                               selector: @selector(applicationDidBecomeActiveNotification)
                                                   name: UIApplicationDidBecomeActiveNotification
                                                 object: nil];
      
      [[NSNotificationCenter defaultCenter] addObserver: self
                                               selector: @selector(applicationWillResignActiveNotification)
                                                   name: UIApplicationWillResignActiveNotification
                                                 object: nil];
   }
   return self;
}

- (void)dealloc
{
   [_link invalidate];
   [_link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)applicationDidBecomeActiveNotification
{
   [_link setPaused:NO];
}

- (void)applicationWillResignActiveNotification
{
   [_link setPaused:YES];
}

- (void)start
{
   [_link setPaused:NO];
}

- (void)tick:(CADisplayLink *)link
{
   if (_lastTime == 0) {
      _lastTime = link.timestamp;
      return;
   }
   
   count++;
   NSTimeInterval delta = link.timestamp - _lastTime;
   if (delta < 1) return;
   _lastTime = link.timestamp;
   float fps = count / delta;
   count = 0;
   
   NSString *fpsString = [NSString stringWithFormat:@"%d fps",(int)round(fps)];
   self.text = fpsString;
}

@end
