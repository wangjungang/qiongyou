//
//  SearchCell.m
//  QiongTreval
//
//  Created by mac on 16/7/11.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "SearchCell.h"

@interface SearchCell ()

@property (nonatomic,strong)UILabel * leftLb;
@property (nonatomic,strong)UIButton * cleanBtn;

@end

@implementation SearchCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andArray:(NSMutableArray * )array{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.btnArr = [NSMutableArray arrayWithArray:array];
        [self setup];
        
    }
    return self;
}

- (void)setup{
    
    self.userInteractionEnabled = YES;
    self.contentView.userInteractionEnabled = YES;
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 60, 15)];
    label.text = @"历史记录";
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:label];
    self.leftLb = label;
    
    UIButton * qingchu = [UIButton buttonWithType:UIButtonTypeCustom];
    qingchu.frame = CGRectMake(Screen_Width-45, 15, 30, 15);
    [qingchu setTitle:@"清除" forState:UIControlStateNormal];
    [qingchu setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [qingchu addTarget:self action:@selector(qingchuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    qingchu.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:qingchu];
    self.cleanBtn = qingchu;
    
    UIView * lineV = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.leftLb.frame)+15, Screen_Width-30, 1)];
    lineV.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineV];
    
    UIView * btnView= [[UIView alloc]initWithFrame:CGRectMake(0, 45, Screen_Width, self.contentView.height-45)];
    btnView.userInteractionEnabled = YES;
    [self.contentView addSubview:btnView];
    
    for (int i =0; i<self.btnArr.count; i++) {
        
//        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15+(Screen_Width-60)/3 *(i%3)+15*(i%3), 15+(i/3)*30+(i/3)*15, (Screen_Width-60)/3, 30)];
//        label.userInteractionEnabled = YES;
//        label.enabled = YES;
//        label.textColor = [UIColor lightGrayColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [UIFont systemFontOfSize:14];
//        label.text = self.btnArr[i];
//        label.layer.cornerRadius = 15;
//        label.layer.masksToBounds = YES;
//        label.layer.borderColor = RGB(6, 173, 114).CGColor;
//        label.layer.borderWidth = 1.5;
//        label.tag = i+10;
//        [btnView addSubview:label];
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLabelClick:)];
//        [label addGestureRecognizer:tap];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15+(Screen_Width-60)/3 *(i%3)+15*(i%3), 15+(i/3)*30+(i/3)*15, (Screen_Width-60)/3, 30);
        [btn setTitle:self.btnArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 15;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = RGB(6, 173, 114).CGColor;
        btn.layer.borderWidth = 1.5;
        btn.tag = i+200;
        [btn addTarget:self action:@selector(tapBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:btn];
    }
}

- (void)tapBtnClick:(UIButton *)btn{
    
    NSLog(@"%@",self.btnArr[btn.tag-200]);
}

- (void)tapLabelClick:(UITapGestureRecognizer *)tap{
    
   NSLog(@"%@",self.btnArr[tap.view.tag]);
}

- (void)qingchuBtnClick:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(qingchuClick)]) {
        
        [self.delegate qingchuClick];
    }
}

- (void)setLeftLbStr:(NSString *)leftLbStr{
    
    _leftLbStr = leftLbStr;
    self.leftLb.text = leftLbStr;
}
- (void)setHideQcBtn:(BOOL)hideQcBtn{
    
    _hideQcBtn = hideQcBtn;
    self.cleanBtn.hidden = hideQcBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
