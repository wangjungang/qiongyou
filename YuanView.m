//
//  YuanView.m
//  QiongTreval
//
//  Created by mac on 16/7/5.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "YuanView.h"

@implementation YuanView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
    
        [self setup];
        
    }
    return self;
}

- (void)setup{
    
    self.backgroundColor = RGB(6, 173, 114);
    
}

@end
