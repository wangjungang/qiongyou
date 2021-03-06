//
//  PageModel.h
//  QiongTreval
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageModel : NSObject
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *info;
@property (nonatomic,copy)NSString *times;
@property (nonatomic,strong)NSDictionary * data;
@property (nonatomic,strong)NSDictionary * extra;
@property (nonatomic,copy)NSString * ra_referer;
@end
