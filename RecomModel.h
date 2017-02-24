//
//  RecomModel.h
//  QiongTreval
//
//  Created by mac on 16/6/24.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecomModel : NSObject
@property (nonatomic,strong)NSDictionary * data;
@property (nonatomic,strong)NSDictionary * extra;
@property (nonatomic,copy)NSString *info;
@property (nonatomic,strong)NSString *ra_referer;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *times;
@end
