//
//  DisCountVCCell.h
//  QiongTreval
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hot_areaModel.h"
#import "Discount_topicModel.h"

typedef NS_ENUM(NSInteger,SubCellCount){
    
    SubCellCountTwo,
    SubCellCountThree,
};

@interface DisCountVCCell : UITableViewCell
@property (nonatomic,strong)hot_areaModel * model;
@property (nonatomic,strong)Discount_topicModel * topicModel;
@property (nonatomic,assign)BOOL isHiddenTopImageView;
@property (nonatomic,assign)BOOL isHiddenButtonView;
@property (nonatomic,assign)SubCellCount cellcount;
@end
