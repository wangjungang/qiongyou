//
//  Hotbutton.m
//  QiongTreval
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "Hotbutton.h"

@interface Hotbutton ()

@property (nonatomic,strong)UILabel * titleLb;

@end

@implementation Hotbutton

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
    
        [self setUP];
        
    }
    return self;
}
- (void)setUP{
    
    UILabel * label = [[UILabel alloc]initWithFrame:self.bounds];
    label.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    self.titleLb = label;
}

- (void)setCenterText:(NSString *)CenterText{
    
    _CenterText = CenterText;
    self.titleLb.text = CenterText;
}

- (void)setBackImgUrl:(NSString *)backImgUrl{
    
    _backImgUrl = backImgUrl;
    
    [self sd_setImageWithURL:[NSURL URLWithString:backImgUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
}

@end


