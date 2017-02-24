//
//  countryCell.m
//  QiongTreval
//
//  Created by mac on 16/7/5.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "countryCell.h"

@implementation countryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    CALayer * layer = [CALayer layer];
    layer.frame = CGRectMake(10, self.baseView.height -0.5, Screen_Width-20, 0.5);
    layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.baseView.layer addSublayer:layer];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(CountryData *)data{
    
    _data =data;
    self.cnname.text = data.cnname;
    self.enname.text = data.enname;
}

@end
