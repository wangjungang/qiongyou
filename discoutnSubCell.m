//
//  discoutnSubCell.m
//  QiongTreval
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "discoutnSubCell.h"
#define btnWith (Screen_Width -60)/4
#define btnHeight (Screen_Width -60)/4
@implementation discoutnSubCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.topView.height = btnHeight;
    self.leftImageV.width = btnHeight;
    self.topView.layer.cornerRadius = 3;
    self.topView.layer.masksToBounds = YES;
    self.topView.layer.borderColor  = [UIColor lightGrayColor].CGColor;
    self.topView.layer.borderWidth = 0.5;
    
    self.leftImageV.clipsToBounds = YES;
    
}

- (void)setAreadata:(hot_areaData *)areadata{
    
    _areadata = areadata;
    
    [self.leftImageV sd_setImageWithURL:[NSURL URLWithString:areadata.photo] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    self.disLb.text = areadata.title;
    self.sellCountLb.text = areadata.sold;
    self.moneyLb.text = areadata.price;
    
}

- (void)setTopicData:(Discount_topicData *)topicData{
    
    _topicData = topicData;
    
    [self.leftImageV sd_setImageWithURL:[NSURL URLWithString:topicData.photo] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    self.disLb.text = topicData.title;
    self.sellCountLb.text = topicData.sold;
    self.moneyLb.text = topicData.price;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
