//
//  TitleView.h
//  QiongTreval
//
//  Created by mac on 16/7/13.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleView : UIView
@property (nonatomic,strong)UIView * contentView;
@property (nonatomic,strong)UIView * stretchView;//拉伸的View
+ (instancetype)dropTitleViewWithFram:(CGRect)frame contentView:(UIView *)contentView stretchView:(UIView *)stretchView;
@end
