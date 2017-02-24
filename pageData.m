//
//  pageData.m
//  QiongTreval
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "pageData.h"

@implementation pageData
+ (void)load{
    
    [self mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{
                 @"group":@"groupData"
                 };
        
    }];
}
@end
