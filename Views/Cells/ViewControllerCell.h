//
//  ViewControllerCell.h
//  practice
//
//  Created by 许超 on 2019/7/20.
//  Copyright © 2019 许超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const cellReuseIdentifer;

@interface ViewControllerCell : UITableViewCell
@property(nonatomic,strong) UILabel *topic;
-(void)meserror;
@end


NS_ASSUME_NONNULL_END
