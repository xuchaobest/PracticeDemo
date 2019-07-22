//
//  ViewController2.m
//  practice
//
//  Created by 许超 on 2019/7/20.
//  Copyright © 2019 许超. All rights reserved.
//

#import "ViewController2.h"
#import <objc/runtime.h>

@interface ViewController2 ()
@property(nonatomic,copy)NSString *valueDelivered;
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
   UILabel * someIntroduct = [[UILabel alloc]initWithFrame:CGRectMake(Width_Screen/2-100, 30+Height_Nav, 200, 50)];
   someIntroduct.textAlignment = NSTextAlignmentCenter;
   someIntroduct.font = [UIFont systemFontOfSize:19];
   someIntroduct.numberOfLines = 0;
   someIntroduct.adjustsFontSizeToFitWidth = YES;
   someIntroduct.textColor = [UIColor darkTextColor];
   someIntroduct.text = @"关于传值\n";
   [self.view addSubview:someIntroduct];
   UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(Width_Screen/2-100, 60+Height_Nav, 200, 30)];
   textfield.font = [UIFont systemFontOfSize:15];
   textfield.placeholder = @"输入要传的内容";
   textfield.borderStyle = UITextBorderStyleBezel;
   [self.view addSubview:textfield];
   UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(Width_Screen/2-100, 110+Height_Nav, 70, 30)];
   btn1.backgroundColor = [UIColor redColor];
   [btn1 setTitle:@"方法一" forState:UIControlStateNormal];
   [self.view addSubview:btn1];
   objc_setAssociatedObject(btn1, @"textfield", textfield, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
   [btn1 addTarget:self action:@selector(method1:) forControlEvents:UIControlEventTouchUpInside];
   
   UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(Width_Screen/2+30, 110+Height_Nav, 70, 30)];
   btn2.backgroundColor = [UIColor redColor];
   [btn2 setTitle:@"方法二" forState:UIControlStateNormal];
   [self.view addSubview:btn2];
   [btn2 addTarget:self action:@selector(method2:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)method1:(UIButton *)sender{
   UITextField * field = objc_getAssociatedObject(sender, @"textfield");
   NSLog(@"\n\n当前输入框内的内容是：%@\n\n",field.text);
}

-(void)method2:(UIButton *)sender{
   
}

@end
