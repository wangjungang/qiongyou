//
//  dataModel.m
//  QiongTreval
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "dataModel.h"

@implementation dataModel

+ (void)load{
    
    [self mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{
                 @"forum_list":@"pageData"
                 };
    }];
}

@end
