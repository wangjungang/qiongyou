//
//  SelectPageView.m
//  QiongTreval
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "SelectPageView.h"

@interface SelectPageView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong)UILabel * midLb;
@property (nonatomic,strong)UIPickerView * picker;
@end

@implementation SelectPageView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = RGB(242, 242, 242);
    
    CALayer * layer=  [CALayer layer];
    layer.frame = CGRectMake(0, 0, self.width, 1);
    layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:layer];
    
    CALayer * layer2= [CALayer layer];
    layer2.frame = CGRectMake(0, 50, self.width, 0.5);
    layer2.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:layer2];
    
    UIButton * guanbi = [UIButton buttonWithType:UIButtonTypeCustom];
    guanbi.frame = CGRectMake(15, 15, 35, 20);
    [guanbi setTitle:@"关闭" forState:UIControlStateNormal];
    [guanbi setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    guanbi.titleLabel.font = [UIFont systemFontOfSize:13];
    [guanbi addTarget:self action:@selector(guanbiClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:guanbi];
    
    UIButton * queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(self.width-35-15, 15, 35, 20);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding setTitleColor:RGB(6, 173, 114) forState:UIControlStateNormal];
    queding.titleLabel.font = [UIFont systemFontOfSize:13];
    [queding addTarget:self action:@selector(quedingClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:queding];
    
    UIView * midView =[[UIView alloc]initWithFrame:CGRectMake(65, 10, self.width-130, 30)];
    midView.backgroundColor = [UIColor whiteColor];
    midView.userInteractionEnabled = YES;
    midView.layer.borderColor = RGB(6, 173, 114).CGColor;
    midView.layer.borderWidth = 1;
    midView.layer.cornerRadius = 4;
    midView.layer.masksToBounds = YES;
    [self addSubview:midView];
    
    UIButton * shouYe = [UIButton buttonWithType:UIButtonTypeCustom];
    shouYe.frame = CGRectMake(0, 0, midView.width/3, midView.height);
    [shouYe setTitle:@"首页" forState:UIControlStateNormal];
    [shouYe setTitleColor:RGB(6, 173, 114) forState:UIControlStateNormal];
    shouYe.titleLabel.font = [UIFont systemFontOfSize:13];
    [shouYe addTarget:self action:@selector(shouYeClick:) forControlEvents:UIControlEventTouchUpInside];
    [midView addSubview:shouYe];
    
    UILabel * midLb = [[UILabel alloc]initWithFrame:CGRectMake(midView.width/3, 0, midView.width/3, midView.height)];
    midLb.textColor = [UIColor lightGrayColor];
    midLb.textAlignment = NSTextAlignmentCenter;
    midLb.font = [UIFont systemFontOfSize:12];
    [midView addSubview:midLb];
    self.midLb = midLb;
    
    UIButton * moYe = [UIButton buttonWithType:UIButtonTypeCustom];
    moYe.frame = CGRectMake(midView.width/3*2, 0,midView.width/3 , midView.height);
    [moYe setTitle:@"末页" forState:UIControlStateNormal];
    [moYe setTitleColor:RGB(6, 173, 114) forState:UIControlStateNormal];
    moYe.titleLabel.font = [UIFont systemFontOfSize:13];
    [moYe addTarget:self action:@selector(moYeClick:) forControlEvents:UIControlEventTouchUpInside];
    [midView addSubview:moYe];
    
    UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(midView.width/3, 0, 1, midView.height)];
    line1.backgroundColor = RGB(4, 173, 114);
    [midView addSubview:line1];
    
    UIView * line2 = [[UIView alloc]initWithFrame:CGRectMake(midView.width/3*2, 0, 1, midView.height)];
    line2.backgroundColor = RGB(4, 173, 114);
    [midView addSubview:line2];
    
    UIPickerView * picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 50, self.width, 150)];
    picker.showsSelectionIndicator = YES;//显示选中框
    picker.delegate = self;
    picker.dataSource = self;
    [self addSubview:picker];
    self.picker = picker;
    
    
}

- (NSMutableArray *)pageList{
    
    if (!_pageList) {
        _pageList=[NSMutableArray array];
    }
    return _pageList;
}

- (void)setHotData:(hotTravelData *)hotData{
    
    _hotData = hotData;
    
    NSInteger P = [hotData.replys integerValue]>9?[hotData.replys integerValue]%9==0?[hotData.replys integerValue]/9:[hotData.replys integerValue]/9+1:1;
    
    for (int i =1 ; i<=P; i++) {
        [self.pageList addObject:[NSString stringWithFormat:@"%d",i]];
    }

    if ([QYUserDefaults objectForKey:hotData.id]) {
        
        NSString * ye = [QYUserDefaults objectForKey:hotData.id];
        self.midLb.text = [NSString stringWithFormat:@"%@/%ld",ye,self.pageList.count];
        [self.picker selectRow:[ye integerValue]-1 inComponent:0 animated:YES];
        
    }else{
        
        self.midLb.text = [NSString stringWithFormat:@"1/%ld",self.pageList.count];
    }
    [self.picker reloadAllComponents];
    
}

- (void)setDisData:(discussData *)disData{
    
    _disData = disData;
    
    NSInteger P = [disData.reply_num integerValue]>9?[disData.reply_num integerValue]%9==0?[disData.reply_num integerValue]/9:[disData.reply_num integerValue]/9+1:1;
    
    for (int i =1 ; i<=P; i++) {
        [self.pageList addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    if ([QYUserDefaults objectForKey:disData.id]) {
        
        NSString * ye = [QYUserDefaults objectForKey:disData.id];
        self.midLb.text = [NSString stringWithFormat:@"%@/%ld",ye,self.pageList.count];
        [self.picker selectRow:[ye integerValue]-1 inComponent:0 animated:YES];
        
    }else{
        
        self.midLb.text = [NSString stringWithFormat:@"1/%ld",self.pageList.count];
    }
    [self.picker reloadAllComponents];
}

- (void)moYeClick:(UIButton *)btn{
    
    [self dissmiss];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshWebView" object:@(self.pageList.count)];
}

- (void)shouYeClick:(UIButton *)btn{
    
    [self dissmiss];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshWebView" object:@"1"];
}

- (void)guanbiClick:(UIButton *)btn{
    
    [self dissmiss];
    
}

- (void)quedingClick:(UIButton *)btn{
    
    [self dissmiss];
    
   NSArray * arr = [self.midLb.text componentsSeparatedByString:@"/"];
    NSString * str= arr[0];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshWebView" object:str];
}

- (void)show{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.y = Screen_Height-200;
        
    } completion:^(BOOL finished) {
        
        
    }];
    
}

- (void)dissmiss{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.y = Screen_Height;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];

}
//返回列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}
//返回每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.pageList.count;
}

//每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return self.width;
}

//返回当前行的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [NSString stringWithFormat:@"第%@页",[self.pageList objectAtIndex:row]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.midLb.text = [NSString stringWithFormat:@"%@/%ld",[self.pageList objectAtIndex:row],self.pageList.count];
}



- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel * pickLb = (UILabel *)view;
    if (!pickLb) {
        pickLb = [[UILabel alloc]init];
        pickLb.adjustsFontSizeToFitWidth =YES;
        pickLb.backgroundColor = [UIColor clearColor];
        pickLb.textAlignment = NSTextAlignmentCenter;
        pickLb.font = [UIFont systemFontOfSize:14];
        pickLb.textColor = [UIColor blackColor];
        pickLb.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    }
    return pickLb;
}

@end
