//
//  countryCell.h
//  QiongTreval
//
//  Created by mac on 16/7/5.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryData.h"
@interface countryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UILabel *cnname;
@property (weak, nonatomic) IBOutlet UILabel *enname;
@property (nonatomic,strong)CountryData * data;
@end
