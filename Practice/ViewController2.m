//
//  ViewController2.m
//  practice
//
//  Created by 许超 on 2019/7/20.
//  Copyright © 2019 许超. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
   UILabel * someIntroduct = [[UILabel alloc]initWithFrame:CGRectMake(Width_Screen/2-100, 30+Height_Nav, 200, 50)];
   someIntroduct.textAlignment = NSTextAlignmentCenter;
   someIntroduct.font = [UIFont systemFontOfSize:13];
   someIntroduct.numberOfLines = 0;
   someIntroduct.adjustsFontSizeToFitWidth = YES;
   someIntroduct.textColor = [UIColor darkTextColor];
   someIntroduct.text = @"";
   [self.view addSubview:someIntroduct];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
