//
//  hotTravelModel.m
//  QiongTreval
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "hotTravelModel.h"

@implementation hotTravelModel

+ (void)load{
    
    [self mj_setupObjectClassInArray:^NSDictionary *{
       
        return @{
                 @"data":@"hotTravelData"
                 };
    }];
}

@end
