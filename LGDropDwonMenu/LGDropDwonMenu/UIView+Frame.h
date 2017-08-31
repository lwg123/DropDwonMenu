//
//  UIView+Frame.h
//  ZuHuYun
//
//  Created by weiguang on 25/05/2017.
//  Copyright © 2017 weiguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic,assign) CGFloat X;
@property (nonatomic,assign) CGFloat Y;
@property (nonatomic,assign) CGFloat Witdh;
@property (nonatomic,assign) CGFloat Height;
@property (nonatomic,assign) CGFloat CenterX;
@property (nonatomic,assign) CGFloat CenterY;

@property (nonatomic,assign,readonly) CGFloat MaxY;
@property (nonatomic,assign,readonly) CGFloat MinY;
@property (nonatomic,assign,readonly) CGFloat MaxX;
@property (nonatomic,assign,readonly) CGFloat MinX;
@property (nonatomic,assign,readonly) CGFloat MidX;
@property (nonatomic,assign,readonly) CGFloat MidY;

@property (nonatomic,assign) CGPoint Orgin;
@property (nonatomic,assign) CGSize Size;


@end
