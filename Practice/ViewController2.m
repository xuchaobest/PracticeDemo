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
@property(nonatomic,strong)NSInvocation *invocat;
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
   NSString * text = @"msghere";
   objc_setAssociatedObject(btn1, @"string", text, OBJC_ASSOCIATION_RETAIN);
   [btn1 addTarget:self action:@selector(method1:) forControlEvents:UIControlEventTouchUpInside];
   
   UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(Width_Screen/2+30, 110+Height_Nav, 70, 30)];
   btn2.backgroundColor = [UIColor redColor];
   [btn2 setTitle:@"方法二" forState:UIControlStateNormal];
   [self.view addSubview:btn2];
   [btn2 addTarget:self action:@selector(method2) forControlEvents:UIControlEventTouchUpInside];
   
   NSMethodSignature *signature = [[self class]instanceMethodSignatureForSelector:@selector(multParameterMethod:andText:)];// sign method
   _invocat = [NSInvocation invocationWithMethodSignature:signature];
   [_invocat setTarget:self];//set invocat target
   [_invocat setSelector:@selector(multParameterMethod:andText:)];//set method will respond,it must be same with signature's sel
   [_invocat setArgument:&textfield atIndex:2];//0 target 1 _cmd
   NSString *string = [btn1 titleForState:UIControlStateNormal];
   [_invocat setArgument:&string atIndex:3];
}

-(void)method1:(UIButton *)sender{
   UITextField * field = objc_getAssociatedObject(sender, @"textfield");
   NSLog(@"\n\n当前输入框内的内容是：%@\n\n",field.text);
   NSString *text = objc_getAssociatedObject(sender, @"string");
   NSLog(@"\n\n%@\n",text);
   text = @"";
}

-(void)method2{
   NSString *text;
   [_invocat invoke];
//   [_invocat getReturnValue:&text];
//   NSLog(@"方法二调用了 返回结果是：%@",text);
}

-(NSString *)multParameterMethod:(UITextField *)field andText:(NSString *)text{
   return [field.text stringByAppendingString:text];
}

@end
