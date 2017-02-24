//
//  UIImage+Size.h
//  QiongTreval
//
//  Created by mac on 16/6/24.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Size)
//修改image的大小

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

// 控件截屏
+ (UIImage *)imageWithCaputureView:(UIView *)view;

//截取一张View生成图片
+ (UIImage *)shotWithView:(UIView *)view;
@end
