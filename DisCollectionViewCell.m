//
//  DisCollectionViewCell.m
//  QiongTreval
//
//  Created by mac on 16/6/28.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "DisCollectionViewCell.h"

@implementation DisCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
  
}

- (void)setDisData:(discountData *)disData{
    
    _disData = disData;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:disData.photo] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    self.nameLb.text = disData.title;
    self.discountLb.text = disData.priceoff;
    self.moneyLb.text = [self jiexiPriceWith:disData.price];
    
}

- (NSString *)jiexiPriceWith:(NSString *)price{
    
    NSRange range = [price rangeOfString:@"/"];
    
    NSMutableString * str = [NSMutableString stringWithString:price];
    [str replaceCharactersInRange:range withString:@""];
   NSArray * arr = [str componentsSeparatedByString:@"<em>"];
    NSString * realString= [NSString stringWithFormat:@"%@元起",arr[1]];
    return realString;
}

@end
