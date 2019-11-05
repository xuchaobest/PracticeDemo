//
//  ViewController5.m
//  practice
//
//  Created by WUC on 2019/7/30.
//  Copyright © 2019 许超. All rights reserved.
//

#import "ViewController5.h"
#import <objc/runtime.h>

@interface ViewController5 ()
@property(nonatomic,weak)UIView *view2;
@property(nonatomic,weak)UIView *view3;
@end

@implementation ViewController5

- (void)viewDidLoad {
    [super viewDidLoad];
//   [self convertStringBetweenOCAndC];
//   [self aboutCategoryCreatedBySystem];
}

#pragma mark - oc和c字符转换和urlencode编码

-(void)convertStringBetweenOCAndC{
    //先把oc转c，再转回oc（待研究）
    //oc -> c
    NSString *ocString = @"This is a OC string";
    //静态方法
    if ([ocString canBeConvertedToEncoding:NSUTF8StringEncoding]) {
        const char *cString1 = [ocString cStringUsingEncoding:NSUTF8StringEncoding];
        const char *cString2 = [ocString UTF8String];
        NSLog(@"\n\n1——%s\n\n2——%s",cString1,cString2);
    }
    
    //c -> oc
    const char *cString = "This is a C string";
    //动态方法
    NSString *ocString1 = [[NSString alloc] initWithUTF8String:cString];
    NSString *ocString2 = [[NSString alloc] initWithCString:cString encoding:NSUTF8StringEncoding];
    NSString *ocString3 = [[NSString alloc] initWithFormat:@"%s",cString];
    //静态方法
    NSString *ocString4 = [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
    NSString *ocString5 = [NSString stringWithUTF8String:cString];
    NSString *ocString6 = [NSString stringWithFormat:@"%s",cString];
    NSLog   (@"\n\n1——%@\n\n2——%@\n\n3——%@\n\n4——%@\n\n5——%@\n\n6——%@",ocString1,ocString2,ocString3,ocString4,ocString5,ocString6);
}

-(void)inputOCStringURLEncode{
    NSString *url = @"this is a 中文字符串、有 特殊格式。";
    NSString *urlEncode =  [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    if(@available(iOS 9.0, *)){
        urlEncode = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
        
    }else{
        urlEncode = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)url,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    }
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
    (__bridge CFStringRef)urlEncode,CFSTR(""),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
}

#pragma mark - kvo的点和weak修饰

-(void)aboutCategoryCreatedBySystem{
   //添加观察者 会和weak修饰一样 程序运行时生成一个派生类 在其被观察属性的set方法中增加 - (void)willChangeValueForKey:(NSString *)key;- (void)didChangeValueForKey:(NSString *)key;方法，也可以手动调用方法出发KVO。
   UIView *view = [UIView new];
   [view addObserver:self forKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionInitial context:nil];
   UIView *view1 = [UIView new];
   NSLog(@"1%@",[view class]);
   NSLog(@"1%@",object_getClass(view));
   NSLog(@"2%@",[view1 class]);
   NSLog(@"2%@",object_getClass(view1));
   _view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
   NSLog(@"3%@",[_view2 class]);
   NSLog(@"3%@",object_getClass(_view2));
   [self.view addSubview:_view2];
   UIView *viewtmp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
   [self.view2 addSubview:viewtmp];
   _view3 = viewtmp;
   NSLog(@"4%@",[_view3 class]);
   NSLog(@"4%@",object_getClass(viewtmp));
   viewtmp = nil;
   NSLog(@"4%@",[_view3 class]);
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
   
}



-(void)dealloc{
   
}
@end
