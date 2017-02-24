//
//  MDDModel.h
//  QiongTreval
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDDModel : NSObject
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *info;
@property (nonatomic,copy)NSString *times;
@property (nonatomic,strong)NSArray * data;
@property (nonatomic,strong)NSDictionary * extra;
@property (nonatomic,strong)NSString *ra_referer;
@end
