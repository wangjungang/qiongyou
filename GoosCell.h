//
//  GoosCell.h
//  QiongTreval
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hot_goodsData.h"
@interface GoosCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIImageView *topImageV;
@property (weak, nonatomic) IBOutlet UILabel *disLb;
@property (weak, nonatomic) IBOutlet UILabel *sellLb;
@property (weak, nonatomic) IBOutlet UILabel *moneyLb;
@property (nonatomic,strong)hot_goodsData * goodData;
@end
