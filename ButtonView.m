//
//  ButtonView.m
//  QiongTreval
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "ButtonView.h"
#import "Hotbutton.h"
#import "hot_areaPlaceData.h"
#define btnWith (Screen_Width -60)/4
#define btnHeight (Screen_Width -60)/4
@implementation ButtonView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
    
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

- (void)setDataArray:(NSArray *)DataArray{
    
    _DataArray = DataArray;
    
        for (int i =0; i<DataArray.count; i++) {
            
            hot_areaPlaceData * data = (hot_areaPlaceData*)DataArray[i];
            Hotbutton * button = [[Hotbutton alloc]initWithFrame:CGRectMake(12*(i+1)+(i%4)*btnWith, 0, btnWith, btnHeight)];
            button.tag = 2008+i;
            button.layer.cornerRadius = 3;
            button.layer.masksToBounds = YES;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.backImgUrl = data.photo;
            button.CenterText = data.name;
            [self addSubview:button];
        }

}

- (void)buttonClick:(UIButton *)btn{
    
    
    
}

@end
