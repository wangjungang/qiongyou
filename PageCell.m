//
//  PageCell.m
//  QiongTreval
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "PageCell.h"

@implementation PageCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.page = [[PageVC alloc]init];
        self.page.view.frame = CGRectMake(0, 0, Screen_Width, Screen_Height - 64 - 49);
        [self.contentView addSubview:self.page.view];
    }
    return self;
}

@end
