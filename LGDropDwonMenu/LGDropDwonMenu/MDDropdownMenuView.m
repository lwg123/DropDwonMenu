//
//  MDDropdownMenuView.m
//  LGDropDwonMenu
//
//  Created by weiguang on 2019/10/14.
//  Copyright © 2019 weiguang. All rights reserved.
//

#import "MDDropdownMenuView.h"
#import "Macro.h"
#import "UIView+Frame.h"
#define AnimateTime 0.2f   // 下拉动画时间
static NSString * const contentiditer   = @"MenuContentCollectionViewCell";

@interface MDDropdownMenuCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *lab;

@end

@implementation MDDropdownMenuCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        _lab.textColor = [UIColor lightGrayColor];
        _lab.font = [UIFont systemFontOfSize:14.0];
        _lab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_lab];
    }
    return self;
}

@end



@interface MDDropdownMenuView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionView *collectionView;   // 下拉列表
@property (nonatomic,strong) UIView *mainView;
/** 标题数组 */
@property (nonatomic,strong) NSArray *arrTitle;
/** 是否选中了当前的某一标题 */
@property ( nonatomic , assign) BOOL isSelect ;

@property (nonatomic,strong) UIButton * mainBtn;  // 主按钮

@end


@implementation MDDropdownMenuView
{
    UIView  * _listView;    // 下拉列表背景View
    CGFloat _rowHeight;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        //self.backgroundColor = [UIColor whiteColor];
        
        _arrTitle = titles;
        _isSelect = NO;
        _rowHeight = 40;
        
        [self setupAllView];
    }
    return self;
}


- (void)setupAllView {
    // 主按钮 显示在界面上的点击按钮
    _mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_mainBtn setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_mainBtn setTitle:@"切换页面" forState:UIControlStateNormal];
    
    _mainBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _mainBtn.titleLabel.font    = [UIFont systemFontOfSize:14.0];
    _mainBtn.titleEdgeInsets    = UIEdgeInsetsMake(0, 15, 0, 0);
    _mainBtn.selected           = NO;
    _mainBtn.backgroundColor    = [UIColor blueColor];

    [_mainBtn addTarget:self action:@selector(clickMainBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_mainBtn];
    
    
    // 下拉列表背景View
    _listView = [[UIView alloc] init];
    _listView.frame = CGRectMake(self.X , self.MaxY, self.Witdh,  0);
    _listView.clipsToBounds       = YES;
    _listView.layer.masksToBounds = NO;
    _listView.layer.borderColor   = [UIColor lightGrayColor].CGColor;
    _listView.layer.borderWidth   = 0.5f;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemW = _listView.Witdh / 2;
    CGFloat itemH = _rowHeight;
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _listView.Witdh, _listView.Height) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = RGB(238, 238, 244);
    //注册item
    [_collectionView registerClass:[MDDropdownMenuCell class] forCellWithReuseIdentifier:contentiditer];
    
    [_listView addSubview:_collectionView];
    
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


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrTitle.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MDDropdownMenuCell * cell = (MDDropdownMenuCell *)[collectionView dequeueReusableCellWithReuseIdentifier:contentiditer forIndexPath:indexPath];
    cell.lab.text = _arrTitle[indexPath.item];
    if (indexPath.item == 0) {
        cell.lab.textColor = [UIColor redColor];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MDDropdownMenuCell *cell = (MDDropdownMenuCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSString *currentTitle = _arrTitle[indexPath.row];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:currentTitle];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSRangeFromString(currentTitle)];
    [_mainBtn setAttributedTitle:str forState:UIControlStateNormal];
    

    for (MDDropdownMenuCell *cell in [collectionView visibleCells]) {
        cell.lab.textColor = [UIColor lightGrayColor];
    }

    cell.lab.textColor = [UIColor redColor];
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenu:selectedCellNumber:)]) {
        [self.delegate dropdownMenu:self selectedCellNumber:indexPath.row]; // 回调代理
    }
    
    [self hideDropDown];
}


// 显示下拉菜单
- (void)showDropDown {
    
    [_listView.superview bringSubviewToFront:_listView]; // 将下拉列表置于最上层
    
    [UIView animateWithDuration:AnimateTime animations:^{
        
        _listView.frame  = CGRectMake(_listView.X,
                                      _listView.Y
        , _listView.Witdh, _rowHeight *(_arrTitle.count+1)/2);
        _collectionView.frame = CGRectMake(0, 0, _listView.Witdh, _listView.Height);
        
    }completion:^(BOOL finished) {
        
        
    }];
    _mainBtn.selected = YES;
}

// 隐藏下拉菜单
- (void)hideDropDown {
    
    [UIView animateWithDuration:AnimateTime animations:^{
        
        _listView.frame  = CGRectMake(_listView.X, _listView.Y, _listView.Witdh, 0);
        _collectionView.frame = CGRectMake(0, 0, _listView.Witdh, _listView.Height);
        
    }completion:^(BOOL finished) {
        
        
    }];
    
    _mainBtn.selected = NO;
}


@end
