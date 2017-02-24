//
//  QYMineBlurView.h
//  QiongTreval
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kDKBlurredBackgroundDefaultLevel 0.9f
#define kDKBlurredBackgroundDefaultGlassLevel 0.2f
#define kDKBlurredBackgroundDefaultGlassColor [UIColor whiteColor]
@interface QYMineBlurView : UIImageView
@property (nonatomic, strong) UIImage *originalImage;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) float initialBlurLevel;
@property (nonatomic, assign) float initialGlassLevel;
@property (nonatomic, assign) BOOL isGlassEffectOn;
@property (nonatomic, strong) UIColor *glassColor;

- (void)setBlurLevel:(float)blurLevel;
@end
