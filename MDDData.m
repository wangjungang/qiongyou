//
//  MDDData.m
//  QiongTreval
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "MDDData.h"

@implementation MDDData

+ (void)load{
    
    [self mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{
                 @"hot_country":@"HotCountryData",
                 @"country":@"CountryData"
                 };
        
    }];
}

@end
