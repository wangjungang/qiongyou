//
//  groupData.h
//  QiongTreval
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface groupData : NSObject
@property (nonatomic,copy)NSString *id;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *des;
@property (nonatomic,copy)NSString *total_threads;
@property (nonatomic,copy)NSString *photo;
@property (nonatomic,strong)NSArray * types;
@end
