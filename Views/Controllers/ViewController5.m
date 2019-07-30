//
//  ViewController5.m
//  practice
//
//  Created by WUC on 2019/7/30.
//  Copyright © 2019 许超. All rights reserved.
//

#import "ViewController5.h"

@interface ViewController5 ()

@end

@implementation ViewController5

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)convertStringBetweenOCAndC{
    //oc -> c
    NSString *ocString = @"This is a OC string";
    //静态方法
    if (ocst) {
        <#statements#>
    }
    const char *cString1 = [ocString cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cString2 = [ocString UTF8String];
    NSLog(@"\n\n1——%s\n\n2——%s",cString1,cString2);
    
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
    [NSLog   (@"\n\n1——%@\n\n2——%@\n\n3——%@\n\n4——%@\n\n5——%@\n\n6——%@",ocString1,ocString2,ocString3,ocString4,ocString5,ocString6)];
    [ocString1 release]; [ocString2 release];
}

@end