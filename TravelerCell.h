//
//  TravelerCell.h
//  QiongTreval
//
//  Created by mac on 16/7/8.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelData.h"
@interface TravelerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *placeLb;
@property (weak, nonatomic) IBOutlet UILabel *desLb;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *secondLb;
@property (weak, nonatomic) IBOutlet UILabel *seeLb;
@property (weak, nonatomic) IBOutlet UILabel *taolunLb;
@property (nonatomic,strong)TravelData * data;
@end
