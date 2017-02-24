//
//  FreeCell.m
//  QiongTreval
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "FreeCell.h"

@implementation FreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentView.backgroundColor = RGB(231, 231, 231);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
