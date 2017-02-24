//
//  rightTableCell.m
//  QiongTreval
//
//  Created by mac on 16/7/8.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "rightTableCell.h"

@implementation rightTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.placeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.placeBtn setTitleColor:RGB(6, 173, 114) forState:UIControlStateSelected];
    self.placeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.placeBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.placeBtn addTarget:self action:@selector(placeBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setPlacedata:(placeData *)placedata{
    
    _placedata = placedata;
    [self.placeBtn setTitle:placedata.place_name forState:UIControlStateNormal];
    if (placedata.isSelect) {
        self.placeBtn.selected = YES;
    }else{
        self.placeBtn.selected = NO;
    }
}

- (void)placeBtn:(UIButton *)btn{
    
    self.placedata.isSelect = btn.selected;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
