//
//  rightTableCell.h
//  QiongTreval
//
//  Created by mac on 16/7/8.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "placeData.h"
@interface rightTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *placeBtn;
@property (nonatomic,strong)placeData * placedata;
@end
