//
//  SpecialModel.m
//  QiongTreval
//
//  Created by mac on 16/6/30.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "SpecialModel.h"

@implementation SpecialModel

+ (void)load{
    
    [self mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{
                @"data":@"SpecialData"
                 };
    }];
}

@end
