//
//  FoundNextCell.m
//  QiongTreval
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "FoundNextCell.h"

@implementation FoundNextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 315, Screen_Width, 0.5)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.baseView addSubview:view];
    
    _topImageView.userInteractionEnabled = YES;
    _leftImageView.userInteractionEnabled= YES;
    _rightImageView.userInteractionEnabled = YES;
    _topImageView.tag = 1001;
    _leftImageView.tag = 1002;
    _rightImageView.tag = 1003;
    UITapGestureRecognizer * topTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
    [_topImageView addGestureRecognizer:topTap];
    
    UITapGestureRecognizer * leftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
    [_leftImageView addGestureRecognizer:leftTap];
    
    UITapGestureRecognizer * rightTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
    [_rightImageView addGestureRecognizer:rightTap];
}

- (void)tapImageView:(UITapGestureRecognizer *)tap{

    NSArray * arr = [_dataArray[0] copy];
    subjectData * data = arr[0];
    subjectData * dataL = arr[1];
    subjectData * dataR = arr[2];
   
    switch (tap.view.tag) {
        case 1001:
            if (self.delegate && [self.delegate respondsToSelector:@selector(tapImageViewWith:)]) {
                [self.delegate tapImageViewWith:data];
            }
            
            break;
        case 1002:
            if (self.delegate && [self.delegate respondsToSelector:@selector(tapImageViewWith:)]) {
                [self.delegate tapImageViewWith:dataL];
            }

            break;
        case 1003:
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(tapImageViewWith:)]) {
                [self.delegate tapImageViewWith:dataR];
            }
            break;
        default:
            break;
    }
    
}

- (void)setDataArray:(NSArray *)dataArray{
    
    _dataArray = dataArray;
   
    NSArray * arr = [dataArray[0] copy];
    subjectData * data = arr[0];
    subjectData * dataL = arr[1];
    subjectData * dataR = arr[2];
    [_topImageView sd_setImageWithURL:[NSURL URLWithString:data.photo] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:dataL.photo] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:dataR.photo] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
}

- (IBAction)moreButton:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(seeMoreContentButtonClick)]) {
        
        [self.delegate seeMoreContentButtonClick];
    }
    
}
@end
