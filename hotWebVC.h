//
//  hotWebVC.h
//  QiongTreval
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hotTravelData.h"
#import "discussData.h"
@interface hotWebVC : UIViewController
@property (nonatomic,strong)hotTravelData * data;
@property (nonatomic,strong)discussData * disData;
@end
