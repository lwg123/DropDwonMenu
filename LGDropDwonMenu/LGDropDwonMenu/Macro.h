//
//  Macro.h
//  LGDropDwonMenu
//
//  Created by weiguang on 2017/8/31.
//  Copyright © 2017年 weiguang. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#pragma mark - 常用frame

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#pragma mark - color
#define RGB(r,g,b) RGBA(r,g,b,1)
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


#endif /* Macro_h */
