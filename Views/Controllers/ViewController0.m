
//
//  ViewController0.m
//  practice
//
//  Created by 许超 on 2019/7/20.
//  Copyright © 2019 许超. All rights reserved.
//
#pragma mark - 动画demo
#import "ViewController0.h"

@interface ViewController0 ()
@property(nonatomic,strong)CAAnimationGroup *group;
@property(nonatomic,strong)CAAnimationGroup *group1;
@end

extern NSString *const cellReuseIdentifer;

@implementation ViewController0

- (void)viewDidLoad {
    [super viewDidLoad];
   [self startWithAnimation];
   NSLog(@"%@",cellReuseIdentifer);
}

-(void)startWithAnimation{
   UIImageView *photo1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 300)];
   photo1.backgroundColor = [UIColor yellowColor];
   photo1.tag = 3;
   photo1.center = self.view.center;
   [self.view addSubview:photo1];
   photo1.userInteractionEnabled = YES;
   UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(repeatAnimation:)];
   [photo1 addGestureRecognizer:tap];
   
   UIImageView *photo2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 300)];
   photo2.backgroundColor = [UIColor greenColor];
   photo2.tag = 4;
   photo2.center = self.view.center;
   [self.view addSubview:photo2];
   photo2.userInteractionEnabled = YES;
   UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(repeatAnimation:)];
   [photo2 addGestureRecognizer:tap1];
   self.view.backgroundColor = [UIColor whiteColor];
   
   NSOperationQueue * downloadQue = [[NSOperationQueue alloc]init];
   downloadQue.maxConcurrentOperationCount = 3;
   NSURLSessionConfiguration * config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
   NSURLSession * imgDownloadSession = [NSURLSession sessionWithConfiguration:config delegate:(id)self delegateQueue:downloadQue];
   NSURLSessionDownloadTask *task = [[NSURLSessionDownloadTask alloc]init];
   task = [imgDownloadSession downloadTaskWithURL:[NSURL URLWithString:@"http://a.hiphotos.baidu.com/image/pic/item/e61190ef76c6a7efcefee3c3f3faaf51f2de667e.jpg"] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      NSLog(@"response:%@\n\nerror:%@\n\nlocation:%@",response,error,location);
      dispatch_async(dispatch_get_main_queue(), ^{
         NSData * imgData = [NSData dataWithContentsOfURL:location];
         photo1.image = [UIImage imageWithData:imgData];
      });
   }];
   [task resume];

   NSURLSession * imgDownloadSession1 = [NSURLSession sessionWithConfiguration:config delegate:(id)self delegateQueue:downloadQue];
   NSURLSessionDownloadTask *task1 = [[NSURLSessionDownloadTask alloc]init];
   task1 = [imgDownloadSession1 downloadTaskWithURL:[NSURL URLWithString:@"http://b-ssl.duitang.com/uploads/item/201608/21/20160821230024_MyCYK.thumb.700_0.jpeg"] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      dispatch_async(dispatch_get_main_queue(), ^{
         NSData * imgData = [NSData dataWithContentsOfURL:location];
         photo2.image = [UIImage imageWithData:imgData];
      });
   }];
   [task1 resume];
   
   if(!_group){
      CABasicAnimation *zPosition = [CABasicAnimation animation];
      zPosition.keyPath = @"zPosition";
      zPosition.fromValue = @-1;
      zPosition.toValue = @1;
      zPosition.duration = 1.2;
      
      CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
      rotation.keyPath = @"transform.rotation";
      rotation.values = @[ @0, @0.14, @0 ];
      rotation.duration = 1.2;
      rotation.timingFunctions = @[
                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                   ];
      
      CAKeyframeAnimation *position = [CAKeyframeAnimation animation];
      position.keyPath = @"position";
      position.values = @[
                          [NSValue valueWithCGPoint:CGPointZero],
                          [NSValue valueWithCGPoint:CGPointMake(110, -20)],
                          [NSValue valueWithCGPoint:CGPointZero]
                          ];
      position.timingFunctions = @[
                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                   ];
      position.additive = YES;
      position.duration = 1.2;
      _group = [[CAAnimationGroup alloc] init];
      _group.animations = @[ zPosition, rotation, position ];
      _group.duration = 12;
   }
   if (!_group1) {
      CABasicAnimation *zPosition = [CABasicAnimation animation];
      zPosition.keyPath = @"zPosition";
      zPosition.fromValue = @1;
      zPosition.toValue = @-1;
      zPosition.duration = 1.2;
      
      CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
      rotation.keyPath = @"transform.rotation";
      rotation.values = @[ @0, @-0.14, @0 ];
      rotation.duration = 1.2;
      rotation.timingFunctions = @[
                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                   ];
      
      CAKeyframeAnimation *position = [CAKeyframeAnimation animation];
      position.keyPath = @"position";
      position.values = @[
                          [NSValue valueWithCGPoint:CGPointZero],
                          [NSValue valueWithCGPoint:CGPointMake(-110, -20)],
                          [NSValue valueWithCGPoint:CGPointZero]
                          ];
      position.timingFunctions = @[
                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                   ];
      position.additive = YES;
      position.duration = 1.2;
      _group1 = [[CAAnimationGroup alloc] init];
      _group1.animations = @[ zPosition, rotation, position ];
      _group1.duration = 12;
   }
//   group.fillMode = kCAFillModeForwards;
//   group.removedOnCompletion = NO;
//   group.beginTime = 0.5;
}

-(void)repeatAnimation:(UITapGestureRecognizer *)gesture{
   UIView * view = gesture.view;
   NSInteger tagNum = view.tag;
   [view.layer addAnimation:_group1 forKey:@""];
   if (tagNum==3) {
      UIView * view1 = [self.view viewWithTag:4];
      [view1.layer addAnimation:_group forKey:@""];
   }else{
      UIView * view1 = [self.view viewWithTag:3];
      [view1.layer addAnimation:_group forKey:@""];
   }
//   [self.view sendSubviewToBack:view];
   CGRect boundingRect = CGRectMake(0, 0, 30, 30);
   CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
   orbit.keyPath = @"position";
   orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
   orbit.duration = 4;
   orbit.additive = YES;
   orbit.repeatCount = HUGE_VALF;
   orbit.calculationMode = kCAAnimationPaced;
//   orbit.rotationMode = kCAAnimationRotateAuto;
   [self.view.layer addAnimation:orbit forKey:@"orbit"];

   
//   CAAnimationGroup *group = [view.layer animationForKey:@"shuffle"];
//   [view.layer removeAllAnimations];
}

@end
