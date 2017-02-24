//
//  hot_areaModel.m
//  QiongTreval
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "hot_areaModel.h"

@implementation hot_areaModel

+ (void)load{
    
    [self mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{
                 @"list":@"hot_areaData",
                 @"place":@"hot_areaPlaceData"
                 };
    }];
    
}

@end
