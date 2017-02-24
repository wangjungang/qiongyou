//
//  DetailSubModel.h
//  QiongTreval
//
//  Created by mac on 16/7/13.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailSubModel : NSObject
@property (nonatomic,copy)NSString *id;
@property (nonatomic,copy)NSString *cnname;
@property (nonatomic,copy)NSString *enname;
@property (nonatomic,copy)NSString *planto;
@property (nonatomic,copy)NSString *beento;
@property (nonatomic,copy)NSString *overview_url;
@property (nonatomic,copy)NSString *has_guide;
@property (nonatomic,copy)NSString *guide_num;
@property (nonatomic,copy)NSString *has_plan;
@property (nonatomic,copy)NSString *has_trip;
@property (nonatomic,copy)NSString *entryCont;
@property (nonatomic,strong)NSArray *photos;
@property (nonatomic,strong)NSArray *hot_city;
@property (nonatomic,strong)NSArray *hot_mguide;
//@property (nonatomic,strong)NSArray *new_discount;

@end
