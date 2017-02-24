//
//  SearchModel.h
//  QiongTreval
//
//  Created by mac on 16/8/18.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject
@property (nonatomic,strong)NSArray *data;
@property (nonatomic,strong)NSDictionary *extra;
@property (nonatomic,copy)NSString * info;
@property (nonatomic,copy)NSString * ra_referer;
@property (nonatomic,copy)NSString * status;
@property (nonatomic,copy)NSString * times;
@end
