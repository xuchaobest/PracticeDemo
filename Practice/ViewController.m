//
//  ViewController.m
//  practice
//
//  Created by 许超 on 2019/6/4.
//  Copyright © 2019 许超. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerCell.h"
#import <objc/runtime.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

-(void)viewDidLoad{
   [super viewDidLoad];
   self.navigationItem.title = @"practice";
   @autoreleasepool {
      UITableView *table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
      table.delegate = self;
      table.dataSource = self;
      table.separatorStyle = UITableViewCellSeparatorStyleNone;
      [table registerClass:ViewControllerCell.class forCellReuseIdentifier:cellReuseIdentifer];
      [self.view addSubview:table];
   }
   [self performSelector:@selector(meserror) withObject:nil afterDelay:0];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   ViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifer];
   cell.topic.backgroundColor = [UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1];
   cell.topic.text = [self topicOfDemo:indexPath.row];
   return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
   Class newcontrollerclass = NSClassFromString([NSString stringWithFormat:@"ViewController%ld",indexPath.row]);
   UIViewController * controller = [[newcontrollerclass alloc]init];
   [self.navigationController pushViewController:controller animated:YES];
   
}

-(NSString *)topicOfDemo:(NSInteger)num{
   switch (num) {
      case 0:
         return @"动画";
         break;
      case 1:
         return @"汉诺塔";
         break;
      case 2:
         return @"关于传值";
         break;
      default:
         return @"";
         break;
   }
}

#pragma mark - 触摸事件代理

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
}

#pragma mark - 消息转发

+ (BOOL)resolveInstanceMethod:(SEL)sel{
   NSLog(@"%p",sel);
   /*if (sel == @selector(meserror)) {
      Method newFunc = class_getInstanceMethod([self class], @selector(msgForwardInvocation));
      const char * desStr = method_getTypeEncoding(newFunc);
      class_addMethod([self class], sel, (IMP)oneMethodIsInvalid, desStr);
      return YES;
   }*/
   return  [super resolveInstanceMethod:sel];
}

-(id)forwardingTargetForSelector:(SEL)aSelector{
   /*if (aSelector == @selector(meserror)) {
      ViewControllerCell *cell = [[ViewControllerCell alloc]init];
      return cell;
   }*/
   return  [super forwardingTargetForSelector:aSelector];
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
   if ([NSStringFromSelector(aSelector)isEqualToString:@"meserror"]) {
      return [NSMethodSignature signatureWithObjCTypes:"v16@0:8"];
   }
   return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
   SEL sel = anInvocation.selector;
   ViewControllerCell *cell = [[ViewControllerCell alloc]init];
   if (![cell respondsToSelector:sel]) {
      [anInvocation invokeWithTarget:cell];
   }else{
      NSLog(@"完蛋了 方法没有实现");
   }
}

-(void)megLogOutIntoIMP:(NSString *)msgname{
   NSLog(@"消息转发:%@",msgname);
}

-(void)msgForwardInvocation{
   
}

void oneMethodIsInvalid(){
   NSLog(@"消息转发成功了");
}

@end
