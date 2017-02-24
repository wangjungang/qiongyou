//
//  DiscussCell.m
//  QiongTreval
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "DiscussCell.h"

@implementation DiscussCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.discuss = [[DiscussVC alloc]init];
        self.discuss.view.frame = CGRectMake(0, 0, Screen_Width, Screen_Height - 64 - 49);
        [self.contentView addSubview:self.discuss.view];
    }
    return self;
}


@end
