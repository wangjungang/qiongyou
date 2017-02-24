//
//  TitleView.m
//  QiongTreval
//
//  Created by mac on 16/7/13.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "TitleView.h"

@interface TitleView ()<UIScrollViewDelegate>
@property (nonatomic, assign) CGFloat initOffsetY;
@property (nonatomic, assign) CGRect initStretchViewFrame;
@property (nonatomic, assign) CGFloat initSelfHeight;
@property (nonatomic, assign) CGFloat initContentHeight;
@end

@implementation TitleView

+ (instancetype)dropTitleViewWithFram:(CGRect)frame contentView:(UIView *)contentView stretchView:(UIView *)stretchView{
    
    TitleView * titleView = [[TitleView alloc]init];
    titleView.frame = frame;
    titleView.contentView = contentView;
    titleView.stretchView = stretchView;
    
    stretchView.contentMode = UIViewContentModeScaleAspectFill;
    stretchView.clipsToBounds = YES;
    return titleView;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    
    if (newSuperview != nil) {
        
        [newSuperview addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        UIScrollView * scrollView = (UIScrollView *)newSuperview;
        self.initOffsetY = scrollView.contentOffset.y;
        self.initStretchViewFrame = self.stretchView.frame;
        self.initSelfHeight = self.height;
        self.initContentHeight = self.contentView.height;
    }
}

- (void)setContentView:(UIView *)contentView{
    
    _contentView = contentView;
    [self addSubview:contentView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    CGFloat offsetY = [change[@"new"] CGPointValue].y-self.initOffsetY;
    
    if (offsetY > 0) {
        
        self.stretchView.y = self.initStretchViewFrame.origin.y + offsetY;
        self.stretchView.height = self.initStretchViewFrame.size.height - offsetY;
        
    }else{
        
        
        self.stretchView.y = self.initStretchViewFrame.origin.y + offsetY;
        self.stretchView.height = self.initStretchViewFrame.size.height - offsetY;
        
    }

}

@end
