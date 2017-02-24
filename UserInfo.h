//
//  UserInfo.h
//  QiongTreval
//
//  Created by mac on 16/7/15.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property (nonatomic,strong)NSDictionary *checkin;
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,copy)NSString *im_user_id;
@property (nonatomic,copy)NSString *username;
@property (nonatomic,copy)NSString *gender;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *avatar;
@property (nonatomic,copy)NSString *cover;
@property (nonatomic,copy)NSString *map;
@property (nonatomic,copy)NSString *follow_status;
@property (nonatomic,copy)NSString *fans;
@property (nonatomic,copy)NSString *follow;
@property (nonatomic,copy)NSString *cities;
@property (nonatomic,copy)NSString *countries;
@property (nonatomic,copy)NSString *pois;
@property (nonatomic,copy)NSString *trips;
@property (nonatomic,copy)NSString *together_city;
@property (nonatomic,copy)NSString *together_city_total;
@property (nonatomic,copy)NSString *together_country_total;
@property (nonatomic,copy)NSString *wants;
@property (nonatomic,copy)NSString *want_counties;
@property (nonatomic,copy)NSString *want_cities;
@property (nonatomic,copy)NSString *plan_url;
@end
