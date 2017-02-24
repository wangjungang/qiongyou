//
//  hotTravelCell.h
//  QiongTreval
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hotTravelData.h"
@interface hotTravelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageV;
@property (weak, nonatomic) IBOutlet UILabel *miaoshuLb;
@property (weak, nonatomic) IBOutlet UILabel *zuozheLb;
@property (weak, nonatomic) IBOutlet UILabel *liulanLb;
@property (weak, nonatomic) IBOutlet UILabel *pingLunLb;
@property (weak, nonatomic) IBOutlet UILabel *hotLb;

@property (nonatomic,strong)hotTravelData * hotData;


@end
