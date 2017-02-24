//
//  dicussModel.m
//  QiongTreval
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "dicussModel.h"

@implementation dicussModel

+ (void)load{
    
    [self mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{
                 @"data":@"discussData"
                 };
        
    }];
}

@end
