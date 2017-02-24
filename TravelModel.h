//
//  TravelModel.h
//  QiongTreval
//
//  Created by mac on 16/7/8.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelModel : NSObject
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *info;
@property (nonatomic,copy)NSString *times;
@property (nonatomic,strong)NSDictionary *extra;
@property (nonatomic,strong)NSArray *data;
@end
