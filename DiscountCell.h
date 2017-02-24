//
//  DiscountCell.h
//  QiongTreval
//
//  Created by mac on 16/6/28.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol discountCellDelegate <NSObject>

- (void)seemoreDiscount;

@end

@interface DiscountCell : UITableViewCell
- (void)cellWithdiscountArray:(NSMutableArray *)discountArray anddisSubArray:(NSMutableArray *)disSubArray andIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic,weak)id<discountCellDelegate>delegate;
@end
