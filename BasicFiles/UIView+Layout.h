//
//  UIView+Layout.h
//  practice
//
//  Created by 许超 on 2019/7/21.
//  Copyright © 2019 许超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static CGFloat WS;
static CGFloat HS;
static CGFloat HSB;
static CGFloat HN;
static CGFloat HBR;
static CGFloat HBB;

#define Width_Screen  [UIView getSW]
#define Height_Screen [UIView getSH]
#define Height_StateBar [UIView getHSB]
#define Height_Nav [UIView getHN]
#define Height_BotCorR [UIView getHBR]
#define Height_BotBar [UIView getHBB]
@interface UIView (Layout)

@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat left;
@property(nonatomic,assign)CGFloat right;
@property(nonatomic,assign)CGFloat top;
@property(nonatomic)CGFloat bottom;
@property(nonatomic)CGFloat centerx;
@property(nonatomic)CGFloat centery;
@property(nonatomic)CGSize  size;
@property(nonatomic,copy)NSString * name;

+(void)initDefineParameters;
+(CGFloat)getSW;
+(CGFloat)getSH;
+(CGFloat)getHSB;
+(CGFloat)getHN;
+(CGFloat)getHBR;
+(CGFloat)getHBB;
@end

NS_ASSUME_NONNULL_END
