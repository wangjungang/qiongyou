//
//  QYSeachBar.m
//  QiongTreval
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "QYSeachBar.h"

@implementation QYSeachBar

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
       
        self.placeholder = @"搜索目的地、帖子、特价、穷游er";
        for (UIView* subview in [[self.subviews lastObject] subviews]) {
            
            if ([subview isKindOfClass:[UITextField class]]) {
                UITextField *textField = (UITextField*)subview;
            
                //textField.textColor = [UIColor redColor];                         //修改输入字体的颜色
                [textField setBackgroundColor:[UIColor clearColor]];      //修改输入框的颜色
                
                [textField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];   //修改placeholder的颜色
                [textField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
                
            } else if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
            {
                [subview removeFromSuperview];
            }
        }
    }
    return self;
}
/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
@end
