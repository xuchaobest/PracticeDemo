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
@property(nonatomic,copy)NSArray *propertyArray;
@property(nonatomic,strong)NSArray *propertyArray1;
@property(nonatomic,copy)NSString *propertyString;
@property(nonatomic,copy)void(^testblock)(void);
@property(nonatomic,strong)NSMutableArray *listForQR;
@end

@implementation ViewController1

-(void)selecterOne{
   
}

- (void)viewDidLoad {
   [super viewDidLoad];
   self.view.backgroundColor = [UIColor blueColor];
   
    [self hanoi];
   NSLog(@"%ld",[self soldierRingWithHuanmCount:10 andKilledIndex:3]);
   @autoreleasepool {
      dispatch_sync(dispatch_queue_create("haha", DISPATCH_QUEUE_SERIAL), ^{
         NSLog(@"operate here %@",[NSThread currentThread]);
      });
   }
   _propertyArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
   _propertyString = @"hahahaha";
   NSArray *arr = _propertyArray;
   _propertyArray1 = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
   NSLog(@"array %d array1 %d",[_propertyArray isKindOfClass:[NSArray class]],[_propertyArray1 isKindOfClass:[NSArray class]]);
   NSLog(@"propertyarray %@ %@",arr,_propertyArray);
   __weak typeof(self)weakself = self;
   self.testblock = ^{
      [weakself.navigationController popViewControllerAnimated:NO];
      NSOperationQueue * downloadQue = [[NSOperationQueue alloc]init];
      downloadQue.maxConcurrentOperationCount = 3;
      NSURLSessionConfiguration * config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
      NSURLSession * imgDownloadSession = [NSURLSession sessionWithConfiguration:config delegate:(id)weakself delegateQueue:downloadQue];
      NSURLSessionDownloadTask *task = [[NSURLSessionDownloadTask alloc]init];
      task = [imgDownloadSession downloadTaskWithURL:[NSURL URLWithString:@"http://i0.hdslb.com/bfs/article/939de33c09c659da1e4f8f991c0428d39e1a5d92.jpg"] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
         NSLog(@"response:%@\n\nerror:%@\n\nlocation:%@",response,error,location);
         dispatch_async(dispatch_get_main_queue(), ^{
            NSData * imgData = [NSData dataWithContentsOfURL:location];
            NSLog(@"看看self被释放了吗%@",weakself);
         });
      }];
      [task resume];
   };
//   _testblock();
   
    typedef struct node{
      NSInteger val;
      struct node * next;
   } linkList;
#pragma mark - 快速排序
   _listForQR = @[@(2),@(5),@(11),@(1),@(7),@(4),@(10)].mutableCopy;
   [self quickSortfrom:0 to:_listForQR.count-1];
   
#pragma mark - leetcode
   NSLog(@"leetcode %d",findMaxXOR());
}
-(void)logout{
   
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
    [self hanoi:10 :x :y :z];
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

#pragma mark - 补充一个daalloc知识点
//-(void)dealloc{
//   __weak typeof(self)weakself = self;
//   NSLog(@"%@",weakself);
//}

#pragma mark - 顺时针打印一个m*n数组
-(void)clockwisePrintArray{
   NSMutableArray *arr = [NSMutableArray array];
   for (int x=1; x<17; x++) {
      NSMutableArray *arr1 = [NSMutableArray array];
      for (int y=1; y<20; y++) {
         [arr1 addObject:[NSNumber numberWithInt:20*x-20+y]];
      }
      [arr addObject:arr1];
   }
   NSLog(@"%@",arr);
   
}

#pragma mark - 异或问题
/*LeetCode421
 问题描述：
 
 给定一个非空数组，数组中元素为 a0, a1, a2, … , an-1，其中 0 ≤ ai < 231 。
 找到 ai 和 aj 最大的异或 (XOR) 运算结果，其中0 ≤ i,  j < n 。
 你能在 O(n) 的时间解决这个问题吗？
 示例:
 输入: [3, 10, 5, 25, 2, 8]
 输出: 28
 解释: 最大的结果是 5 ^ 25 = 28.
 
 解题原理：
 tip1:如果有三个数，满足其中两个数的异或值等于另一个值，那么这三个数的顺序可以任意调换。（异或运算其实就是二进制下不进位的加法）
 tip2:贪心算法的思想
 tip3:使用掩码和一个数做“与”运算可以得到该数的前缀 eg:1111100000(掩码) & 1001110010(数) ->10011（数的前5位前缀）
 */

int findMaxXOR(void){
   int list[] = {3,10,5,25,2,8};
   int res = 0,mask = 0;
   for (int i = 31; i > -1; i--) {
      mask = mask | 1<<i;//mask = mask ^ i;
      int listLength = sizeof(list)/sizeof(list[0]);
      int sets[listLength];
      for (int u = 0; u < listLength; u++) {
         sets[u] = list[u] & mask;
      }
      int temp = res | (1<<i);
      for (int u = 0; u < listLength; u++) {
         int numToFind = sets[u] ^ temp;
         for (int y = 0; y < listLength; y++) {
            if (sets[y]==numToFind) {
               res = temp;
               break;
            }
         }
      }
   }
   return res;
}

#pragma mark - 快速排序

-(void)quickSortfrom:(NSInteger)low to:(NSInteger)high{
   if (low<high) {
      NSInteger index = [self getIndexform:low To:high];
      [self quickSortfrom:0 to:index-1];
      [self quickSortfrom:index+1 to:high];
   }
   NSLog(@"%@",_listForQR);
}

- (NSInteger)getIndexform:(NSInteger)low To:(NSInteger)high{
   NSInteger tmp = [_listForQR[low]integerValue];
   while (low<high) {
      while ([_listForQR[high]integerValue]>=tmp&&low<high) {
         high--;
      }
      _listForQR[low] = _listForQR[high];
      while (low<high&&[_listForQR[low]integerValue]<=tmp) {
         low++;
      }
      _listForQR[high] = _listForQR[low];
   }
   _listForQR[low] = @(tmp);
   return low;
}

@end
