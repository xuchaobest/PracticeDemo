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
   
    [self hanoi];
   NSLog(@"%ld",[self soldierRingWithHuanmCount:10 andKilledIndex:3]);
}


#pragma mark - 汉诺塔

-(void)hanoi{
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

#pragma mark - 约瑟夫环
/*  问题描述：编号为 1-N 的 N 个士兵围坐在一起形成一个圆圈，从编号为 1 的士兵开始依次报数（1，2，3…这样依次报），数到 m 的 士兵会被杀死出列，之后的士兵再从 1 开始报数。直到最后剩下一士兵，求这个士兵的编号。  */

-(NSInteger)soldierRingWithHuanmCount:(NSInteger)soldierNum andKilledIndex:(NSInteger)index{
    return soldierNum==1?soldierNum:([self soldierRingWithHuanmCount:soldierNum-1 andKilledIndex:index]+index-1)%soldierNum+1;
}

@end
