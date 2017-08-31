//
//  ZBDropdownMenu.h
//  ZhongBao
//
//  Created by weiguang on 2017/8/29.
//  Copyright © 2017年 weiguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZBDropdownMenu;

@protocol ZBDropdownMenuDelegate <NSObject>

@optional
- (void)dropdownMenuWillShow:(ZBDropdownMenu *)menu;    // 当下拉菜单将要显示时调用
- (void)dropdownMenuDidShow:(ZBDropdownMenu *)menu;     // 当下拉菜单已经显示时调用
- (void)dropdownMenuWillHidden:(ZBDropdownMenu *)menu;  // 当下拉菜单将要收起时调用
- (void)dropdownMenuDidHidden:(ZBDropdownMenu *)menu;   // 当下拉菜单已经收起时调用

- (void)dropdownMenu:(ZBDropdownMenu *)menu selectedCellNumber:(NSInteger)number; // 当选择某个选项时调用

@end


@interface ZBDropdownMenu : UIView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIButton * mainBtn;  // 主按钮 可以自定义样式 可在.m文件中修改默认的一些属性

@property (nonatomic,strong) NSString * title;    // 可以定义按钮title

@property (nonatomic, weak) id <ZBDropdownMenuDelegate>delegate;


- (void)setMenuTitles:(NSArray *)titlesArr rowHeight:(CGFloat)rowHeight;  // 设置下拉菜单控件样式

- (void)showDropDown; // 显示下拉菜单
- (void)hideDropDown; // 隐藏下拉菜单

@end
