//
//  MDDData.h
//  QiongTreval
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDDData : NSObject
@property (nonatomic,copy)NSString *id;
@property (nonatomic,copy)NSString *cnname;
@property (nonatomic,copy)NSString *enname;
@property (nonatomic,strong)NSArray *hot_country;
@property (nonatomic,strong)NSArray * country;
@end
