//
//  ViewController1.m
//  practice
//
//  Created by 许超 on 2019/7/16.
//  Copyright © 2019 许超. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 (){
   NSMutableArray * x;
   NSMutableArray * y;
   NSMutableArray * z;
   int c;
}

@end

@implementation ViewController1

- (void)viewDidLoad {
   [super viewDidLoad];
   self.view.backgroundColor = [UIColor blueColor];
   // Do any additional setup after loading the view.
   y = [NSMutableArray array];
   z = [NSMutableArray array];
   x = [NSMutableArray array];
   for (int a=1;a<11;a++) {
      [x addObject:@(a)];
   }
   c=0;
   NSLog(@"%@\n%@\n%@",x,y,z);
   [self hanoi:11 :x :y :z];
   NSLog(@"%@\n%@\n%@",x,y,z);
   NSLog(@"%d",c);
}

-(void)hanoi:(int)n :(NSMutableArray *)x :(NSMutableArray *)y :(NSMutableArray *)z{
   c++;
   if (n==1) {
      [self move:x :1 :z];
   }else{
      [self hanoi:n-1 :x :z :y];
      [self move:x :n :z];
      [self hanoi:n-1 :y :x :z];
   }
}

-(void)move:(NSMutableArray*)x :(int)n :(NSMutableArray*)z{
   [x removeObject:@(n)];
   [z addObject:@(n)];
}

@end
