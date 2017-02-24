//
//  ScroLabel.m
//  QiongTreval
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "ScroLabel.h"

@implementation ScroLabel

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.textColor = RGB(146, 217, 196);
        self.userInteractionEnabled = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.scale = 0.0;
    }
    return self;
}

- (void)setScale:(CGFloat)scale{
    
    _scale = scale;
    
    if (scale == 1) {
        self.textColor = [UIColor whiteColor];
    }else{
        self.textColor = RGB(146, 217, 196);
    }
}

@end
