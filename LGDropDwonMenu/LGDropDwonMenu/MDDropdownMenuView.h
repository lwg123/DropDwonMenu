//
//  MDDropdownMenuView.h
//  LGDropDwonMenu
//
//  Created by weiguang on 2019/10/14.
//  Copyright © 2019 weiguang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MDDropdownMenuView;

@protocol MDDropdownMenuDelegate <NSObject>

@optional

- (void)dropdownMenu:(MDDropdownMenuView *)menu selectedCellNumber:(NSInteger)number; // 当选择某个选项时调用

@end



@interface MDDropdownMenuView : UIView

@property (nonatomic, weak) id <MDDropdownMenuDelegate>delegate;


- (instancetype)initWithFrame:(CGRect)frame title:(NSArray *)titles;


@end

NS_ASSUME_NONNULL_END
