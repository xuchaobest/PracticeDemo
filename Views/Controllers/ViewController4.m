//
//  ViewController4.m
//  practice
//
//  Created by 许超 on 2019/7/27.
//  Copyright © 2019 许超. All rights reserved.
//

#import "ViewController4.h"
#import "VC4TableCell.h"

@interface ViewController4 ()

@end

extern NSString *const cellReuseIdentifer;

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"VC4TableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellReuseIdentifer];
   self.tableView.allowsSelection = NO;
   self.tableView.separatorColor = [UIColor orangeColor];
   self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
   self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   VC4TableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifer forIndexPath:indexPath];
   return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return 70;
}

@end
