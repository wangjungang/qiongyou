//
//  pageTableVCell.m
//  QiongTreval
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "pageTableVCell.h"

@implementation pageTableVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.leftImageV.layer.cornerRadius = 2;
    self.leftImageV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPage:(groupData *)page{
    
    _page = page;
    
    [self.leftImageV sd_setImageWithURL:[NSURL URLWithString:page.photo] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    self.titleLb.text = page.name;
    self.disLb.text = page.des;
    self.countLb.text = page.total_threads;
}

@end
