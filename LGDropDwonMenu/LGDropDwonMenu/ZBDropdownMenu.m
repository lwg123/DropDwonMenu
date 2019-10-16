//
//  ZBDropdownMenu.m
//  ZhongBao
//
//  Created by weiguang on 2017/8/29.
//  Copyright © 2017年 weiguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "UIView+Frame.h"

#define AnimateTime 0.2f   // 下拉动画时间

@interface DropdownMenuCell : UITableViewCell

@property (nonatomic,strong) UILabel *lab;

@end


@implementation DropdownMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _lab = [[UILabel alloc] initWithFrame:CGRectMake(98, 0, SCREEN_WIDTH - 98, self.contentView.frame.size.height)];
        _lab.textColor = [UIColor lightGrayColor];
        _lab.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_lab];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 50-0.5, SCREEN_WIDTH - 28, 0.5)];
        line.backgroundColor = [UIColor darkGrayColor];
        [self.contentView addSubview:line];
        
    }
    
    return self;
}
@end


#import "ZBDropdownMenu.h"

@implementation ZBDropdownMenu
{
    UIImageView * _arrowMark;   // 尖头图标
    UIView      * _listView;    // 下拉列表背景View
    UITableView * _tableView;   // 下拉列表
    
    NSArray     * _titleArr;    // 选项数组
    CGFloat       _rowHeight;   // 下拉列表行高
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
         [self createMainBtnWithFrame:frame];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    [self createMainBtnWithFrame:frame];
}

- (void)createMainBtnWithFrame:(CGRect)frame{
    
    [_mainBtn removeFromSuperview];
    _mainBtn = nil;
    
    // 主按钮 显示在界面上的点击按钮
    _mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_mainBtn setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    
    _mainBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _mainBtn.titleLabel.font    = [UIFont systemFontOfSize:14.0];
    _mainBtn.titleEdgeInsets    = UIEdgeInsetsMake(0, 15, 0, 0);
    _mainBtn.selected           = NO;
    _mainBtn.backgroundColor    = [UIColor whiteColor];

     [_mainBtn addTarget:self action:@selector(clickMainBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, _mainBtn.MaxY-0.5, _mainBtn.Witdh, 0.5);
    layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [_mainBtn.layer addSublayer:layer];

    [self addSubview:_mainBtn];
    
    // 旋转尖头
    _arrowMark = [[UIImageView alloc] initWithFrame:CGRectMake(_mainBtn.frame.size.width - 30, 0, 12, 10)];
    _arrowMark.center = CGPointMake(_arrowMark.CenterX, _mainBtn.Height/2);
    _arrowMark.image  = [UIImage imageNamed:@"tri_down"];
    [_mainBtn addSubview:_arrowMark];
}


- (void)setMenuTitles:(NSArray *)titlesArr rowHeight:(CGFloat)rowHeight{
    
    if (self == nil) {
        return;
    }
    
    _titleArr  = [NSArray arrayWithArray:titlesArr];
    _rowHeight = rowHeight;
    
    
    // 下拉列表背景View
    _listView = [[UIView alloc] init];
    _listView.frame = CGRectMake(self.X , self.MaxY, self.Witdh,  0);
    _listView.clipsToBounds       = YES;
    _listView.layer.masksToBounds = NO;
    _listView.layer.borderColor   = [UIColor lightGrayColor].CGColor;
    _listView.layer.borderWidth   = 0.5f;
    
    
    // 下拉列表TableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,_listView.Witdh, _listView.Height)];
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.bounces         = NO;
    [_listView addSubview:_tableView];
}

- (void)clickMainBtn:(UIButton *)button{
    
    [self.superview addSubview:_listView]; // 将下拉视图添加到控件的俯视图上
    
    if(button.selected == NO) {
        [self showDropDown];
    }
    else {
        [self hideDropDown];
    }
}

- (void)showDropDown{   // 显示下拉列表
    
    [_listView.superview bringSubviewToFront:_listView]; // 将下拉列表置于最上层
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuWillShow:)]) {
        [self.delegate dropdownMenuWillShow:self]; // 将要显示回调代理
    }
    // 改变箭头方向
    _arrowMark.transform = CGAffineTransformMakeRotation(M_PI);
    
    [UIView animateWithDuration:AnimateTime animations:^{
        
        _listView.frame  = CGRectMake(_listView.X,
                                      _listView.Y
        , _listView.Witdh, _rowHeight *_titleArr.count);
        _tableView.frame = CGRectMake(0, 0, _listView.Witdh, _listView.Height);
        
    }completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
            [self.delegate dropdownMenuDidShow:self]; // 已经显示回调代理
        }
    }];
    
    _mainBtn.selected = YES;
}

- (void)hideDropDown{  // 隐藏下拉列表
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuWillHidden:)]) {
        [self.delegate dropdownMenuWillHidden:self]; // 将要隐藏回调代理
    }
    
    _arrowMark.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:AnimateTime animations:^{
        
        _listView.frame  = CGRectMake(_listView.X, _listView.Y, _listView.Witdh, 0);
        _tableView.frame = CGRectMake(0, 0, _listView.Witdh, _listView.Height);
        
    }completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(dropdownMenuDidHidden:)]) {
            [self.delegate dropdownMenuDidHidden:self]; // 已经隐藏回调代理
        }
    }];
    
    _mainBtn.selected = NO;
}

#pragma mark - UITableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titleArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
   
    DropdownMenuCell *cell = (DropdownMenuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
       
        cell = [[DropdownMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.lab.text =[_titleArr objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        cell.lab.textColor = [UIColor blueColor];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DropdownMenuCell *cell = (DropdownMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@：   %@",_title,_titleArr[indexPath.row]]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,_title.length+1)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(_title.length+4,[_titleArr[indexPath.row] length])];
    [_mainBtn setAttributedTitle:str forState:UIControlStateNormal];
    
    for (int i = 0; i < _titleArr.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        DropdownMenuCell *cell = (DropdownMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.lab.textColor = [UIColor lightGrayColor];
    }

    cell.lab.textColor = [UIColor blueColor];
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenu:selectedCellNumber:)]) {
        [self.delegate dropdownMenu:self selectedCellNumber:indexPath.row]; // 回调代理
    }
    
    [self hideDropDown];
}

@end






