//
//  RecomData.m
//  QiongTreval
//
//  Created by mac on 16/6/24.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "RecomData.h"

@implementation RecomData

+ (void)load{
    
    [self mj_setupObjectClassInArray:^NSDictionary *{
       
        return @{
                 
                 @"subject":@"subjectData",
                 @"discount":@"discountData",
                 @"discount_subject":@"dissubData"
                 };

    }];
}



@end
