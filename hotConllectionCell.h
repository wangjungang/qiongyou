//
//  hotConllectionCell.h
//  QiongTreval
//
//  Created by mac on 16/7/5.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotCountryData.h"
@interface hotConllectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UILabel *cityCount;
@property (weak, nonatomic) IBOutlet UILabel *city;

@property (nonatomic,strong)HotCountryData * data;
@end
