//
//  HotCountryCVCell.m
//  QiongTreval
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "HotCountryCVCell.h"

@implementation HotCountryCVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];  // 设置渐变效果
    gradientLayer.bounds = self.baseImageV.bounds;
    gradientLayer.borderWidth = 0;
    gradientLayer.frame = self.baseImageV.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:
                                 (id)[[UIColor clearColor] CGColor],
                                 (id)[[UIColor blackColor] CGColor], nil];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    [self.baseImageV.layer addSublayer:gradientLayer];
    
   
}

@end
