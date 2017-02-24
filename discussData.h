//
//  discussData.h
//  QiongTreval
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface discussData : NSObject
@property (nonatomic,copy)NSString *id;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *author;
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,copy)NSString *avatar;
@property (nonatomic,copy)NSString *forum;
@property (nonatomic,copy)NSString *forum_id;
@property (nonatomic,copy)NSString *reply_num;
@property (nonatomic,copy)NSString *reply_time;
@property (nonatomic,copy)NSString *is_hot;
@property (nonatomic,copy)NSString *is_best;
@property (nonatomic,copy)NSString *appview_url;
@property (nonatomic,strong)NSArray * bigpic_arr;
@end
