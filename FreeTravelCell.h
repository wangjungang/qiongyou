//
//  FreeTravelCell.h
//  QiongTreval
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailSubModel.h"

@interface FreeTravelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *desLb;
@property (weak, nonatomic) IBOutlet UILabel *discountLb;
@property (weak, nonatomic) IBOutlet UILabel *moneyLb;
- (void)assignmentCellWith:(NSArray *)model WithIndexPath:(NSIndexPath *)indexPath;
@end
