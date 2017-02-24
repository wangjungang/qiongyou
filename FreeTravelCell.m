//
//  FreeTravelCell.m
//  QiongTreval
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "FreeTravelCell.h"

@implementation FreeTravelCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(15, 0, Screen_Width-30, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
}


- (void)assignmentCellWith:(NSArray *)array WithIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * data = array[indexPath.row - 2];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:data[@"photo"]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.desLb.text = data[@"title"];
    self.discountLb.text = data[@"priceoff"];
    self.moneyLb.text = [self jiexiPriceWith:data[@"price"]];
}

- (NSString *)jiexiPriceWith:(NSString *)price{
    
    NSRange range = [price rangeOfString:@"/"];
    
    NSMutableString * str = [NSMutableString stringWithString:price];
    [str replaceCharactersInRange:range withString:@""];
    NSArray * arr = [str componentsSeparatedByString:@"<em>"];
    NSString * realString= [NSString stringWithFormat:@"%@",arr[1]];
    return realString;
}

@end
