//
//  SelectPageView.h
//  QiongTreval
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hotTravelData.h"
#import "discussData.h"
@interface SelectPageView : UIView
@property (nonatomic,strong)NSMutableArray * pageList;
@property (nonatomic,strong)hotTravelData * hotData;
@property (nonatomic,strong)discussData * disData;
- (void)show;
- (void)dissmiss;

@end
