//
//  SiftDataModel.m
//  QiongTreval
//
//  Created by mac on 16/7/7.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "SiftDataModel.h"

@implementation SiftDataModel

+ (void)load{
    
    [self mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{
                 @"times_range":@"siftTimeData",
                 @"destination":@"siftPlaceData"
                 };
    }];
}

@end
