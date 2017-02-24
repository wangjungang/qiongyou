//
//  ChiBaoZiHeader.m
//  QiongTreval
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "ChiBaoZiHeader.h"

@implementation ChiBaoZiHeader

/**
 *  重写方法
 */
- (void)prepare{
    
    [super prepare];
    
    //设置普通状态的动画图片
    NSMutableArray * idImages = [NSMutableArray array];
    for (int i=1; i<=60; i++) {
        
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%d",i]];
        [idImages addObject:image];
    }
    [self setImages:idImages forState:MJRefreshStateIdle];
    
    //设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray * refreshingImages = [NSMutableArray array];
    for (int i =1; i<=3; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%d",i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    //设置正在刷新的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
