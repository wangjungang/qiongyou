//
//  Macros.h
//  QiongTreval
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#define Screen_Width    [[UIScreen mainScreen] bounds].size.width
#define Screen_Height   [[UIScreen mainScreen] bounds].size.height
#define RGB(r,g,b)      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define RGBAlpha(r,g,b,a)      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define QYUserDefaults       [NSUserDefaults standardUserDefaults]

#define iOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0

#define QYSearchHistoryPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"searchhistory.data"]
#endif /* Macros_h */
