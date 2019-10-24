//
//  main.m
//  practice
//
//  Created by 许超 on 2019/6/4.
//  Copyright © 2019 许超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
extern CFAbsoluteTime startTime;
extern NSString *name;
int main(int argc, char * argv[]) {
   @autoreleasepool {
      startTime = CFAbsoluteTimeGetCurrent();
      name = @"wangyi";
       return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
   }
}
