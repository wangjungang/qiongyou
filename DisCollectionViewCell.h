//
//  DisCollectionViewCell.h
//  QiongTreval
//
//  Created by mac on 16/6/28.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "discountData.h"
@interface DisCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *discountLb;
@property (weak, nonatomic) IBOutlet UILabel *moneyLb;

@property (nonatomic,strong)discountData * disData;
@end
