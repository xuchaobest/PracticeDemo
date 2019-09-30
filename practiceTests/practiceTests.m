//
//  practiceTests.m
//  practiceTests
//
//  Created by 许超 on 2019/7/27.
//  Copyright © 2019 许超. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface practiceTests : XCTestCase

@end

@implementation practiceTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
       NSInteger num = [self soldierRingWithHuanmCount:10000 andKilledIndex:30];
       NSLog(@"%ld",num);
       dispatch_semaphore_t sem = dispatch_semaphore_create(0);
       NSOperationQueue * downloadQue = [[NSOperationQueue alloc]init];
       downloadQue.maxConcurrentOperationCount = 3;
       NSURLSessionConfiguration * config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
       NSURLSession * imgDownloadSession = [NSURLSession sessionWithConfiguration:config delegate:(id)self delegateQueue:downloadQue];
       NSURLSessionDownloadTask *task = [[NSURLSessionDownloadTask alloc]init];
       task = [imgDownloadSession downloadTaskWithURL:[NSURL URLWithString:@"http://a.hiphotos.baidu.com/image/pic/item/e61190ef76c6a7efcefee3c3f3faaf51f2de667e.jpg"] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
          NSLog(@"response:%@\n\nerror:%@\n\nlocation:%@",response,error,location);
          dispatch_semaphore_signal(sem);
       }];
       [task resume];
       dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
       NSLog(@"%d",12);
    }];
   
   
}

-(NSInteger)soldierRingWithHuanmCount:(NSInteger)soldierNum andKilledIndex:(NSInteger)index{
   return soldierNum==1?soldierNum:([self soldierRingWithHuanmCount:soldierNum-1 andKilledIndex:index]+index-1)%soldierNum+1;
}

@end
