//
//  VC4TableCell.h
//  practice
//
//  Created by 许超 on 2019/7/27.
//  Copyright © 2019 许超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VC4TableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *funName;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UITextField *outField;

@end

NS_ASSUME_NONNULL_END
