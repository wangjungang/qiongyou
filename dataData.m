//
//  dataData.m
//  QiongTreval
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "dataData.h"

@implementation dataData

+ (void)load{
    
    [self mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{
                 @"discount_topic":@"Discount_topicModel",
                 @"hot_area":@"hot_areaModel",
                 @"hot_goods":@"hot_goodsData"
                 };
    }];
    
}

@end
