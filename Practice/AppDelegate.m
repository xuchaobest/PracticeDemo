//
//  AppDelegate.m
//  practice
//
//  Created by 许超 on 2019/6/4.
//  Copyright © 2019 许超. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FPSObserver.h"
@interface AppDelegate ()

@end
CFAbsoluteTime startTime;
NSString *name;
@implementation AppDelegate


/**
 一、OC异常处理函数

 @param exception exception
 */
static void uncaught_exception_handler (NSException *exception) {
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    // 出现异常的原因
    NSString *reason = [exception reason];
    // 异常名称
    NSString *name = [exception name];
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@ Exception name：%@ Exception stack：%@",
                               name,
                               reason,
                               stackArray];
    NSLog(@"%@", exceptionInfo);
    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:stackArray];
    [tmpArr insertObject:reason atIndex:0];
    //保存到本地  --  当然你可以在下次启动的时候，上传这个log[exceptionInfo writeToFile:[NSString stringWithFormat:@"%@/Documents/error.log",NSHomeDirectory()] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    /**
     *  把异常崩溃信息发送至开发者邮件
     */
    NSString *content = [NSString stringWithFormat:@"==异常错误报告==name:%@reason:%@callStackSymbols:%@",
                         name,
                         reason,
                         [stackArray componentsJoinedByString:@""]];
    NSMutableString *mailUrl = [NSMutableString string];
    [mailUrl appendString:@"mailto:test@qq.com"];
    [mailUrl appendString:@"?subject=程序异常崩溃，请配合发送异常报告，谢谢合作！"];
    [mailUrl appendFormat:@"&body=%@", content];
    // 打开地址
    NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
    NSString *mailPath = [mailUrl stringByAddingPercentEncodingWithAllowedCharacters:set];
    //NSString *mailPath = [mailUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailPath]];
}

/**
 二、Unix标准的signal机制处理函数
 @param sig sig
 */
static void handleSignal( int sig ) {
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   // OC层中未被捕获的异常，通过注册NSUncaughtExceptionHandler捕获异常信息
   NSSetUncaughtExceptionHandler(&uncaught_exception_handler);
   // 内存访问错误，重复释放等错误就无能为力了，因为这种错误它抛出的是Signal，所以必须要专门做Signal处理
   // OC中层不能转换的Mach异常，利用Unix标准的signal机制，注册SIGABRT, SIGBUS,SIGSEGV等信号发生时的处理函数。
   signal(SIGSEGV,handleSignal);

   dispatch_async(dispatch_get_main_queue(), ^{
      NSLog(@"启动时间 %f",CFAbsoluteTimeGetCurrent()-startTime);
      NSLog(@"name = %@",name);
   });
   [UIView initDefineParameters];
   _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
   UINavigationController *navi = [UINavigationController new];
   ViewController *vc = [ViewController new];
   navi.viewControllers = @[vc];
   _window.rootViewController = navi;
   [_window makeKeyAndVisible];
   [FPSObserver showOnView:[[application windows] firstObject].rootViewController.view];
   return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
   // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
   // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
   // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
   // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
