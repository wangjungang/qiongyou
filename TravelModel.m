//
//  TravelModel.m
//  QiongTreval
//
//  Created by mac on 16/7/8.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "TravelModel.h"

@implementation TravelModel

+ (void)load{
    
    [self mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{
                 
                 @"data":@"TravelData"
                 };
    }];
}
@end
