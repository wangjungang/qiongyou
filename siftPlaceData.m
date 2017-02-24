//
//  siftPlaceData.m
//  QiongTreval
//
//  Created by mac on 16/7/7.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "siftPlaceData.h"

@implementation siftPlaceData

+ (void)load{
    
    [self mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{
                 @"place":@"placeData"
                 };
    }];
}

@end
