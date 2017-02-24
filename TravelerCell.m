//
//  TravelerCell.m
//  QiongTreval
//
//  Created by mac on 16/7/8.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "TravelerCell.h"

@implementation TravelerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setData:(TravelData *)data{
    
    _data = data;
    
    CGSize size = [data.username sizeWithFont:self.nameLb.font constrainedToSize:CGSizeMake(MAXFLOAT, self.nameLb.height)];
    self.nameLb.width = size.width;
    
    self.placeLb.text = data.citys_str;
    self.desLb.text = data.title;
    self.nameLb.text = data.username;
    self.seeLb.text = data.views;
    self.taolunLb.text = data.replys;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
