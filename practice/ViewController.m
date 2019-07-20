//
//  ViewController.m
//  practice
//
//  Created by 许超 on 2019/6/4.
//  Copyright © 2019 许超. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

static NSString *const cellReuseIdentifer = @"cell";

@implementation ViewController

-(void)viewDidLoad{
   [super viewDidLoad];
   self.navigationItem.title = @"practice";
   @autoreleasepool {
      UITableView *table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
      table.delegate = self;
      table.dataSource = self;
      [table registerClass:UITableViewCell.class forCellReuseIdentifier:cellReuseIdentifer];
      [self.view addSubview:table];
      
   }
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifer];
   cell.backgroundColor = [UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1];
   return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
   Class newcontrollerclass = NSClassFromString([NSString stringWithFormat:@"ViewController%ld",indexPath.row]);
   UIViewController * controller = [[newcontrollerclass alloc]init];
   [self.navigationController pushViewController:controller animated:YES];
   NSString *tmp = @"hahah";
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
   
   return YES;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
   
}

-(void)megLogOutIntoIMP:(NSString *)imgname{
   NSLog(@"消息转发:%@",imgname);
}

@end
