//
//  UIView+Frame.m
//  ZuHuYun
//
//  Created by weiguang on 25/05/2017.
//  Copyright © 2017 weiguang. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

#pragma mark - OrginX
- (void)setX:(CGFloat)X {
    self.frame = CGRectMake(X, self.Y,self.Witdh, self.Height);
}

- (CGFloat)X {
    return self.frame.origin.x;
}

#pragma mark - OrginY

- (void)setY:(CGFloat)Y {
    self.frame = CGRectMake(self.X, Y,self.Witdh, self.Height);
}

- (CGFloat)Y {
    return self.frame.origin.y;
}

#pragma mark - Width
- (void)setWitdh:(CGFloat)Witdh {
    self.frame = CGRectMake(self.X, self.Y,Witdh, self.Height);
}

- (CGFloat)Witdh {
    return self.frame.size.width;
}
#pragma mark - Height
- (void)setHeight:(CGFloat)Height {
    self.frame = CGRectMake(self.X, self.Y,self.Witdh, Height);
}

- (CGFloat)Height {
    return self.frame.size.height;
}

#pragma mark - CenterX
- (void)setCenterX:(CGFloat)CenterX {
    self.center = CGPointMake(CenterX, self.CenterY);
}

- (CGFloat)CenterX {
    return self.center.x;
}

#pragma mark - CenterY
- (void)setCenterY:(CGFloat)CenterY {
    self.center = CGPointMake(self.CenterX, CenterY);
}

- (CGFloat)CenterY {
    return self.center.y;
}

#pragma mark - MaxY and MinY
- (CGFloat)MaxY {
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)MinY {
    return CGRectGetMinY(self.frame);
}

- (CGFloat)MidX {
    return CGRectGetMidX(self.frame);
}

- (CGFloat)MidY {
    return CGRectGetMidY(self.frame);
}

#pragma mark - MaxX and MinX

- (CGFloat)MaxX {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)MinX {
    return CGRectGetMinX(self.frame);
}


#pragma mark - Orgin

- (void)setOrgin:(CGPoint)Orgin {
    self.frame = CGRectMake(Orgin.x, Orgin.y, self.Witdh, self.Height);
}

- (CGPoint)Orgin {
    return self.frame.origin;
}

#pragma mark - Size

- (CGSize)Size {
    return self.frame.size;
}

- (void)setSize:(CGSize)Size {
    self.frame = CGRectMake(self.X, self.Y, Size.width, Size.height);
}


@end
