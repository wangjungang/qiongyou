//
//  MineModel.h
//  QiongTreval
//
//  Created by mac on 16/7/15.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineModel : NSObject
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *info;
@property (nonatomic,copy)NSString *times;
@property (nonatomic,copy)NSString *ra_referer;
@property (nonatomic,strong)NSDictionary * data;
@property (nonatomic,strong)NSDictionary * extra;
@end
