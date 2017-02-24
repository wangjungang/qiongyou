//
//  Discount_topicModel.m
//  QiongTreval
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "Discount_topicModel.h"

@implementation Discount_topicModel

+ (void)load{
    
    [self mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{
                 @"list":@"Discount_topicData"
                 };
    }];
}

@end
