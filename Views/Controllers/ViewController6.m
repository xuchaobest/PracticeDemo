//
//  ViewController6.m
//  practice
//
//  Created by 许超 on 2019/9/24.
//  Copyright © 2019 许超. All rights reserved.
//

#import "ViewController6.h"

@interface ViewController6 ()<UITextFieldDelegate>

@property(nonatomic,strong)NSMutableArray * targetArray;

@property(nonatomic,assign)NSInteger currentTime;

@property(nonatomic,strong)CADisplayLink * timer;

@property(nonatomic,assign)NSInteger totalTime;

@property(nonatomic,assign)NSInteger totalLenth;

@property(nonatomic,assign)NSInteger currentLenth;

@property(nonatomic,assign)NSInteger runningIndex;

@property(nonatomic,strong)CAKeyframeAnimation *ation;
@end

@implementation ViewController6

static CGFloat eachLenth;

- (void)viewDidLoad {
    [super viewDidLoad];
   [self initWorks];
}

-(void)initWorks{
   _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerRunMethod)];
   [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
   [_timer setPaused:YES];
   _timer.preferredFramesPerSecond = 10;
   _intputArray.delegate = self;
   _runningIndex = 0;
   _currentTime = 0;
   _currentLenth = 0;
}

- (IBAction)controlMethod:(id)sender {
   UIButton *btn = (UIButton *)sender;
   _timer.paused = btn.selected;
   btn.selected = !btn.selected;
}

- (IBAction)resetMethod:(id)sender {
   _runningIndex = 0;
   _currentLenth = 0;
   _currentTime = 0;
   _controlBtn.selected = YES;
   _timer.paused = NO;
   CGRect frame = _bluePrograss.frame;
   _bluePrograss.frame = CGRectMake(frame.origin.x, frame.origin.y, 0, frame.size.height);
}

-(void)timerRunMethod{
   if (!_targetArray) {
      return;
   }
   _currentTime++;
   if (_currentTime>_totalTime*10) {
      _currentTime = 0;
      _currentLenth = 0;
      _runningIndex = 0;
      _timer.paused = YES;
      _controlBtn.selected = NO;
      return;
   }
   if (_currentTime%10==0) {
      NSInteger secs = _currentTime/10;
      NSInteger item1 = [_targetArray.firstObject integerValue];
      if (secs<item1) {
         _runningIndex = 0;
         _timeShow.text = [NSString stringWithFormat:@"%ld s",secs];
      }else{
         NSInteger tmp = 0;
         for (int i=0;i< _targetArray.count;i++) {
            NSNumber *num = _targetArray[i];
            tmp += num.integerValue;
            NSInteger itemNum = i==_targetArray.count-1?0:[_targetArray[i+1]integerValue];
            if (secs>tmp&&secs<tmp+itemNum){
               _runningIndex = i+1;
               if (i%2==1) {
                  _timeShow.text = [NSString stringWithFormat:@"%ld s",secs-tmp];
               }else{
                  _timeShow.text = [NSString stringWithFormat:@"%ld s",itemNum-secs+tmp];
               }
               break;
            }else if(secs == tmp){
               _runningIndex = i+1;
               if (i%2==0) {
                  NSInteger itemNum = [_targetArray[i]integerValue];
                  _timeShow.text = [NSString stringWithFormat:@"%ld s",itemNum];
               }else{
                  _timeShow.text = [NSString stringWithFormat:@"0 s"];
               }
               break;
            }
         }
      }
   }
   if (_runningIndex%2==0) {
      //更新进度
      _currentLenth++;
      if (eachLenth==0) {
         eachLenth = 24.0/_totalLenth;
      }
      CGFloat prograss = _currentLenth/1.0/_totalLenth*10;
      _prograssValue.text = [NSString stringWithFormat:@"%.0f %%",ceil(prograss)];
      if (!_ation) {
         _ation = [CAKeyframeAnimation animation];
         _ation.keyPath = @"width";
         _ation.duration = 0.1;
         _ation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
      }
      _ation.values = @[ @(_bluePrograss.frame.size.width),@(_bluePrograss.frame.size.width+eachLenth) ];
      [_bluePrograss.layer addAnimation:_ation forKey:@""];
      CGRect frame = _bluePrograss.frame;
      _bluePrograss.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width+eachLenth, frame.size.height);
   }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
   [textField resignFirstResponder];
   NSString *textstr = textField.text;
   if (textstr.length) {
      _targetArray = [textstr componentsSeparatedByString:@" "].mutableCopy;
      if (_targetArray.count&&_targetArray.count%2==0) {
         [_targetArray removeLastObject];
      }
      if (_targetArray.count) {
         __block NSInteger timeAll = 0;
         __block NSInteger lenthAll = 0;
         [_targetArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            timeAll += [obj integerValue];
            lenthAll += idx%2?0:[obj integerValue];
         }];
         _totalTime = timeAll;
         _totalLenth = lenthAll;
         eachLenth = 0;
      }
   }else
      _targetArray = nil;
   return YES;
}

@end
