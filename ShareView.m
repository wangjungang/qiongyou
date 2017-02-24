//
//  ShareView.m
//  QiongTreval
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "ShareView.h"

@interface ShareView ()

@property (nonatomic,strong)NSArray * titleArray;

@end


@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
    
        [self setUp];
    }
    return self;
}

- (NSArray *)titleArray{
    
    if (_titleArray == nil) {
        _titleArray = @[@"新浪微博",@"微信",@"朋友圈",@"邮箱",@"短信",@"QQ空间"];
    }
    return _titleArray;
}

- (void)setUp{
    
    self.backgroundColor = RGBAlpha(254, 254, 254, 0.7);
    self.width = Screen_Width;
    self.height = 200;
    
    UILabel * fenxiang = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 40)];
    fenxiang.backgroundColor = [UIColor clearColor];
    fenxiang.text = @"分享";
    fenxiang.textColor = [UIColor blackColor];
    fenxiang.textAlignment = NSTextAlignmentCenter;
    fenxiang.font = [UIFont systemFontOfSize:14];
    [self addSubview:fenxiang];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(fenxiang.frame), Screen_Width-40, 1)];
    line.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:line];
    
    
}

@end
