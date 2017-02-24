//
//  SiftModel.h
//  QiongTreval
//
//  Created by mac on 16/7/7.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiftModel : UIView
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *info;
@property (nonatomic,copy)NSString *times;
@property (nonatomic,strong)NSDictionary * data;
@property (nonatomic,strong)NSDictionary *extra;
@end
