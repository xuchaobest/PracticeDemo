//
//  ViewController.m
//  practice
//
//  Created by 许超 on 2019/6/4.
//  Copyright © 2019 许超. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerCell.h"
#import "practice-Swift.h"
#import <objc/runtime.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *strArr;
@property(nonatomic,copy)NSArray *copArr;
@property(nonatomic,strong)NSMutableArray *strMutArr;
@property(nonatomic,copy)NSMutableArray *copMutArr;

@end

static NSInteger tmp = 1;

@implementation ViewController

#pragma mark - viewcontroller生命周期函数调用

- (void)loadView{
   NSLog(@"方法名\n\n%s",__func__);
   UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, Height_Nav+20, Width_Screen, Height_Screen-Height_Nav-20)];
   view.backgroundColor = [UIColor redColor];
   view.tag = 99;
   self.view = view;
}

- (void)viewWillAppear:(BOOL)animated{
   [super viewWillAppear:animated];
   NSLog(@"方法名\n\n%s",__func__);
}

- (void)viewDidAppear:(BOOL)animated{
   [super viewDidAppear:animated];
   NSLog(@"方法名\n\n%s",__func__);
}

- (void)viewWillLayoutSubviews{
   NSLog(@"方法名\n\n%s",__func__);
}

- (void)viewDidLayoutSubviews{
   NSLog(@"方法名\n\n%s",__func__);
}

+ (void)load{
   NSLog(@"方法名\n\n%s",__func__);
}

-(void)viewWillDisappear:(BOOL)animated{
   [super viewWillDisappear:animated];
   NSLog(@"方法名\n\n%s",__func__);
}

-(void)viewDidDisappear:(BOOL)animated{
   [super viewDidDisappear:animated];
   NSLog(@"方法名\n\n%s",__func__);
}

-(void)dealloc{
   NSLog(@"方法名\n\n%s",__func__);
}

-(void)viewDidLoad{
   [super viewDidLoad];
   self.navigationItem.title = @"practice";
   //打印方法名
   NSLog(@"方法名\n\n%s",__func__);
   tmp ++;
   NSLog(@"tmp %ld\n viewtag = %ld",tmp,self.view.tag);
#if 1

//   @autoreleasepool {
      UITableView *table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
      table.delegate = self;
      table.dataSource = self;
      table.separatorStyle = UITableViewCellSeparatorStyleNone;
      [table registerClass:ViewControllerCell.class forCellReuseIdentifier:cellReuseIdentifer];
      [self.view addSubview:table];
//   }
   [self performSelector:@selector(meserror) withObject:nil afterDelay:0];
   
   //
   NSArray * arr = @[@(1)];
   NSLog(@"arr %p - %@\n",arr,arr.class);
   NSMutableArray *arr1 = @[@(2)].mutableCopy;
   _strArr = arr1;
   _copArr = arr1;
   arr1 = @[@(3)].mutableCopy;
   NSArray *arr3 = arr.copy;
   arr = @[@"5"];
   
//   NSLog(@"arr %p - %@\n arr1 %p - %@\n _strarr %p - %@\n _coparr %p - %@\n",arr,arr.class,arr1,arr1.class,_strArr,_strArr.class,_copArr,_copArr.class);
   NSLog(@"arr %p - %@\n arr1 %p - %@\n ",arr,arr.class,arr3,arr3.class);
   NSArray *tmp = @[@"6"];
   arr = tmp;
   NSLog(@"arr %p - %p\n",arr,tmp);
   
   int a = 1;
   int * b;
   b = &a;
   NSLog(@"a %d b %p %d ",a,b,*b);
   
   table.width = 320;
   table.left = Width_Screen/2-160;
   NSLog(@"tablewidth = %f",table.width);
   table.backgroundColor = [UIColor orangeColor];
#endif
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   ViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifer];
//   cell.topic.backgroundColor = [UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1];
//   cell.topic.text = [self topicOfDemo:indexPath.row];
   NSShadow *shadow = [NSShadow new];
   shadow.shadowBlurRadius = 6;
   shadow.shadowOffset = CGSizeMake(0.5, 0.5);
   shadow.shadowColor = [UIColor whiteColor];
   NSAttributedString *attstr = [[NSAttributedString alloc]initWithString:[self topicOfDemo:indexPath.row] attributes:@{NSShadowAttributeName:shadow}];
   cell.topic.attributedText = attstr;
   return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
   if(indexPath.row==7){
      ViewController7 *vc = [ViewController7 new];
      [self.navigationController pushViewController:vc animated:YES];
      return;
   }
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
      case 3:
         return @"使用动态库";
         break;
      case 4:
         return @"数学模型/算法&消息转发";
         break;
       case 5:
           return @"笔记";
           break;
      case 6:
         return @"一个计时方法的demo  &&  viewcontroller生命周期的函数调用";
         break;
      case 7:
         return @"swift创建的控制器";
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
   if (sel == @selector(meserror)) {
      Method newFunc = class_getInstanceMethod([self class], @selector(msgForwardInvocation));
      const char * desStr = method_getTypeEncoding(newFunc);
      class_addMethod([self class], sel, (IMP)oneMethodIsInvalid, desStr);
      return YES;
   }
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
