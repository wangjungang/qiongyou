//
//  HotCountryCell.h
//  QiongTreval
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailSubModel.h"
@interface HotCountryCell : UITableViewCell

- (void)cellLoadData:(DetailSubModel *)model andWithIndex:(NSIndexPath *)indexPath;

@end
