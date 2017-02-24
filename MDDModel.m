//
//  MDDModel.m
//  QiongTreval
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "MDDModel.h"

@implementation MDDModel

+(void)load{
    
    [self mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{
                 @"data":@"MDDData"
                 };
        
    }];
}

@end
