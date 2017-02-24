//
//  TravellerCell.m
//  QiongTreval
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "TravellerCell.h"

@implementation TravellerCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.traveller = [[TravellerVC alloc]init];
        self.traveller.view.frame = CGRectMake(0, 0, Screen_Width, Screen_Height - 64 - 49);
        [self.contentView addSubview:self.traveller.view];
    }
    return self;
}

@end
