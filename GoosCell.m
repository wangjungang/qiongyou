//
//  GoosCell.m
//  QiongTreval
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "GoosCell.h"

@implementation GoosCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.baseView.layer.cornerRadius = 3;
    self.baseView.layer.masksToBounds = YES;
    self.baseView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.baseView.layer.borderWidth = 0.5;
    
    self.topImageV.clipsToBounds = YES;
}

- (void)setGoodData:(hot_goodsData *)goodData{
    
    _goodData= goodData;
    [self.topImageV sd_setImageWithURL:[NSURL URLWithString:goodData.photo] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    self.disLb.text = goodData.title;
    self.sellLb.text = goodData.status;
    self.moneyLb.text = goodData.price;
}

@end
