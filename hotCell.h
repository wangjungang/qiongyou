//
//  hotCell.h
//  QiongTreval
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hotTravelData.h"
@interface hotCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *baseV;
@property (weak, nonatomic) IBOutlet UIImageView *ImageV;
@property (weak, nonatomic) IBOutlet UILabel *disLb;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *seeLab;
@property (weak, nonatomic) IBOutlet UILabel *sayLab;
@property (nonatomic,strong)hotTravelData * hotData;
@end
