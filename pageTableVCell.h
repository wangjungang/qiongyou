//
//  pageTableVCell.h
//  QiongTreval
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "groupData.h"
@interface pageTableVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *disLb;
@property (weak, nonatomic) IBOutlet UILabel *countLb;

@property (nonatomic,strong)groupData * page;

@end
