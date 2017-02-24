//
//  hotTableCell.h
//  QiongTreval
//
//  Created by mac on 16/7/5.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDDData.h"
#import "HotCountryData.h"
@protocol hotTabCellDelegate <NSObject>

- (void)collectionViewCellSelectedWith:(HotCountryData*)hotData;

@end

@interface hotTableCell : UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier With:(NSMutableArray *)array;
@property (nonatomic,strong)NSString * zhouname;
@property (nonatomic,weak)id<hotTabCellDelegate>delegate;
@end
