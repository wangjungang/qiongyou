//
//  hotTravelCell.m
//  QiongTreval
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "hotTravelCell.h"

@implementation hotTravelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 40, Screen_Width, 0.5)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.topView addSubview:line1];
    
    UIView * line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 138.5, Screen_Width, 0.5)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.topView addSubview:line2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHotData:(hotTravelData *)hotData{
    _hotData = hotData;
    [self.photoImageV sd_setImageWithURL:[NSURL URLWithString:hotData.photo] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    self.miaoshuLb.text = hotData.title;
    self.zuozheLb.text = hotData.username;
    self.liulanLb.text = hotData.views;
    self.pingLunLb.text = hotData.replys;
}

@end
