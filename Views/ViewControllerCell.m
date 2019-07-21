//
//  ViewControllerCell.m
//  practice
//
//  Created by 许超 on 2019/7/20.
//  Copyright © 2019 许超. All rights reserved.
//

#import "ViewControllerCell.h"

NSString *const cellReuseIdentifer = @"cell";

@implementation ViewControllerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
      if(!_topic) {
         _topic = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width_Screen, 60)];
         _topic.textColor = [UIColor darkTextColor];
         _topic.font = [UIFont systemFontOfSize:15];
         _topic.textAlignment = NSTextAlignmentCenter;
         [self.contentView addSubview:_topic];
         _topic.numberOfLines = 0;
      }
   }
   return self;
}

-(void)meserror{
   NSLog(@"viewControllerCell 调用了");
}
@end
