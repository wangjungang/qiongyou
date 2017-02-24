//
//  discoutnSubCell.h
//  QiongTreval
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hot_areaData.h"
#import "Discount_topicData.h"
@interface discoutnSubCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImageV;
@property (weak, nonatomic) IBOutlet UILabel *disLb;
@property (weak, nonatomic) IBOutlet UILabel *sellCountLb;
@property (weak, nonatomic) IBOutlet UILabel *moneyLb;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (nonatomic,strong)hot_areaData * areadata;
@property (nonatomic,strong)Discount_topicData * topicData;
@end
