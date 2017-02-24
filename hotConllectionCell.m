//
//  hotConllectionCell.m
//  QiongTreval
//
//  Created by mac on 16/7/5.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "hotConllectionCell.h"

@interface hotConllectionCell ()

@property (nonatomic,strong)UIView * buttomView;
@property (nonatomic,strong)CAGradientLayer * gradientLayer;
@property (nonatomic,strong)UILabel * cnNameLb;
@property (nonatomic,strong)UILabel * enNameLb;


@end

@implementation hotConllectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.rightView.alpha = 0.6;
    self.rightView.layer.cornerRadius = 2;
    self.rightView.layer.masksToBounds = YES;
    
    self.cnNameLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, self.bigImageView.width, 20)];
    self.cnNameLb.font = [UIFont systemFontOfSize:18];
    self.cnNameLb.textColor = [UIColor whiteColor];
    self.cnNameLb.textAlignment = NSTextAlignmentLeft;
    
    self.enNameLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.cnNameLb.frame)+1, self.bigImageView.width, 15)];
    self.enNameLb.font = [UIFont systemFontOfSize:13];
    self.enNameLb.textColor = [UIColor whiteColor];
    self.enNameLb.textAlignment = NSTextAlignmentLeft;
    
    
    _buttomView = [[UIView alloc]initWithFrame:CGRectMake(0, _bigImageView.height-100, 200, 100)];

    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.bounds = _buttomView.bounds;
    _gradientLayer.borderWidth = 0;
    _gradientLayer.frame = _buttomView.bounds;
    
    _gradientLayer.colors = [NSArray arrayWithObjects:
                             (id)[[UIColor clearColor] CGColor],
                             (id)[[UIColor blackColor] CGColor], nil];
    _gradientLayer.startPoint = CGPointMake(0.1, 0.1);
    _gradientLayer.endPoint = CGPointMake(0.1, 1.0);
    
    [_buttomView.layer insertSublayer:_gradientLayer atIndex:0];
    [_bigImageView addSubview:_buttomView];
    [_buttomView addSubview:self.cnNameLb];
    [_buttomView addSubview:self.enNameLb];
}

- (void)setData:(HotCountryData *)data{
    
    _data = data;
    
    CGSize size = [data.label sizeWithFont:self.city.font constrainedToSize:CGSizeMake(MAXFLOAT, self.city.height)];
    
    self.rightView.width = size.width + 15;
    
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:data.photo] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    self.cityCount.text = data.count;
    self.city.text = data.label;
    self.cnNameLb.text = data.cnname;
    self.enNameLb.text = data.enname;
}

@end
