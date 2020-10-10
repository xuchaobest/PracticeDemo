//
//  ViewController3.m
//  practice
//
//  Created by 许超 on 2019/7/24.
//  Copyright © 2019 许超. All rights reserved.
//

#import "ViewController3.h"
#import <XUC/XUC.h>

@interface ViewController3 ()
@property(nonatomic,strong) id subscriber ;
@end

@implementation ViewController3

- (void)viewDidLoad {
   [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
   XuCView *xuc = [[XuCView alloc]initWithFrame:CGRectMake(0, 44, Width_Screen, 88)];
   [self.view addSubview:xuc];
   
   NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
   [dictionary setObject:@1 forKey:@1];
//   NSMutableArray *arr = [NSMutableArray array];
   //崩溃的方式
//   [dictionary setObject:nil forKey:@1];
//   [dictionary setValue:nil forKey:@1];//kvc方法不会crash
//   [arr addObject:nil];
//   NSString *tmp = arr[0];
//   NSString *tmp = [self valueForKey:@"name"];
   
   int a = 10;
   int *i = &a;
   void(^dd)(void) = ^{
      NSLog(@"整形指针 %d",a);
   };
   dd();
   NSLog(@"整形指针1 %d",*i);
   a = 50;
   NSLog(@"整形指针2 %d",*i);
   dd();
   [self gcdGroupMethod];
}

- (id)valueForUndefinedKey:(NSString *)key{
   return @"name";
}

- (void)gcdGroupMethod1{
   
   dispatch_group_t downloadGroup = dispatch_group_create(); // 2
   for (NSInteger i = 0; i < 3; i++) {
       NSURL *url;
       switch (i) {
           case 0:
               url = [NSURL URLWithString:@""];
               break;
           case 1:
               url = [NSURL URLWithString:@""];
               break;
           case 2:
               url = [NSURL URLWithString:@""];
               break;
           default:
               break;
       }

      dispatch_group_enter(downloadGroup);
      dispatch_queue_t  queue = dispatch_queue_create("label", DISPATCH_QUEUE_CONCURRENT);
      dispatch_async(queue, ^{
         sleep(2);
         NSLog(@"hahahha");
         dispatch_group_leave(downloadGroup);
      });
   }
   
   dispatch_group_notify(downloadGroup, dispatch_get_global_queue(0, 0), ^{
      NSLog(@"heiheihei");
   });
   [self gcdGroupMethod];
}

-(void)gcdGroupMethod{
   dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
   dispatch_group_t group = dispatch_group_create();
   
   dispatch_group_enter(group);
   [self requestA:^{
       NSLog(@"---执行A任务结束---");
       dispatch_group_leave(group);
   }];
   
   dispatch_group_enter(group);
   [self requestB:^{
       NSLog(@"---执行B任务结束---");
       dispatch_group_leave(group);
   }];
   
   dispatch_group_enter(group);
   [self requestC:^{
       NSLog(@"---执行C任务结束---");
       dispatch_group_leave(group);
   }];
   
   dispatch_group_notify(group, globalQueue, ^{
       [self requestD:^{
           NSLog(@"---执行D任务结束---");
       }];
   });
}

- (void)requestA:(void(^)(void))block{
      NSLog(@"---执行A任务开始---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}
- (void)requestB:(void(^)(void))block{
      NSLog(@"---执行B任务开始---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}
- (void)requestC:(void(^)(void))block{
      NSLog(@"---执行C任务开始---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
    
}
- (void)requestD:(void(^)(void))block{
    NSLog(@"---执行D任务开始---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}
@end
