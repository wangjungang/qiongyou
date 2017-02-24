//
//  hotCell.m
//  QiongTreval
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "hotCell.h"

@implementation hotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIView * line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 99.5, Screen_Width, 0.5)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.baseV addSubview:line2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHotData:(hotTravelData *)hotData{

    _hotData = hotData;
    [self.ImageV sd_setImageWithURL:[NSURL URLWithString:hotData.photo] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    self.disLb.text = hotData.title;
    self.nameLb.text = hotData.username;
    self.seeLab.text = hotData.views;
    self.sayLab.text = hotData.replys;
}

@end
