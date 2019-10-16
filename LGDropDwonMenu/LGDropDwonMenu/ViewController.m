//
//  ViewController.m
//  LGDropDwonMenu
//
//  Created by weiguang on 2017/8/31.
//  Copyright © 2017年 weiguang. All rights reserved.
//

#import "ViewController.h"
#import "ZBDropdownMenu.h"
#import "Macro.h"
#import "UIView+Frame.h"
#import "SecondViewController.h"

@interface ViewController ()<ZBDropdownMenuDelegate>
{
    UIView *weChatView;
    UIView *alipayView;
}
@property (nonatomic, strong) ZBDropdownMenu * cardDropMenu;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setupUI];
    
    // 下一页
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    [nextBtn setTitle:@"下一页" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.backgroundColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nextBtn];

}


// 设置下拉菜单
- (void)setupUI{
    
    NSArray *titleArray = @[@"储蓄银行卡",@"微信",@"支付宝"];
    ZBDropdownMenu * dropdownMenu = [[ZBDropdownMenu alloc] init];
    [dropdownMenu setFrame:CGRectMake(14, 144, SCREEN_WIDTH - 28, 50)];
    [dropdownMenu setMenuTitles:titleArray rowHeight:50];
    dropdownMenu.delegate = self;
    dropdownMenu.title = @"提现方式";
    dropdownMenu.tag = 0;
    // 给title设置富文本
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@：   %@",dropdownMenu.title,titleArray[0]]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,dropdownMenu.title.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(dropdownMenu.title.length+4,[titleArray[0] length])];
    [dropdownMenu.mainBtn setAttributedTitle:str forState:UIControlStateNormal];
    
    [self.view addSubview:dropdownMenu];
    
    [self createCardDropMenu];
    
}

- (void)createCardDropMenu{
    NSArray *titleArray = @[@"招商银行储蓄卡（5789）",@"工商银行储蓄卡（5789）",@"使用新卡提现"];
    self.cardDropMenu = [[ZBDropdownMenu alloc] init];
    [self.cardDropMenu setFrame:CGRectMake(14, 194.5, SCREEN_WIDTH - 28, 50)];
    [self.cardDropMenu setMenuTitles:titleArray rowHeight:50];
    self.cardDropMenu.delegate = self;
    self.cardDropMenu.tag = 1;
    // 给title设置富文本
    self.cardDropMenu.title = @"选择银行卡";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"选择银行卡：   %@",titleArray[0]]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,self.cardDropMenu.title.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(self.cardDropMenu.title.length+4,[titleArray[0] length])];
    [self.cardDropMenu.mainBtn setAttributedTitle:str forState:UIControlStateNormal];
    
    [self.view addSubview:self.cardDropMenu];
    
    weChatView = [self createLabelWithTitle:@"微信账号：" content:@"12345678"];
    weChatView.hidden = YES;
    [self.view addSubview:weChatView];
    
    alipayView = [self createLabelWithTitle:@"支付宝账号：" content:@"Age****5678"];
    alipayView.hidden = YES;
    [self.view addSubview:alipayView];
}

#pragma  MARK : - ZBDropdownMenuDelegate
- (void)dropdownMenu:(ZBDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
    
    if (menu.tag == 0) {
        switch (number) {
            case 0:
            {
                self.cardDropMenu.hidden = NO;
                alipayView.hidden = YES;
                weChatView.hidden = YES;
            }
                break;
            case 1:
            {
                
                self.cardDropMenu.hidden = YES;
                alipayView.hidden = YES;
                weChatView.hidden = NO;
            }
                break;
            case 2:
            {
                
                self.cardDropMenu.hidden = YES;
                weChatView.hidden = YES;
                alipayView.hidden = NO;
                
            }
                break;
                
            default:
                break;
        }
        
    }
    
}




#pragma MARK : - 生成label
- (UIView *)createLabelWithTitle:(NSString *)title content:(NSString *)content{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(14, 194.5, SCREEN_WIDTH - 28, 50)];
    view.backgroundColor = [UIColor whiteColor];
    CGFloat w = [self getWidthWithTitle:title font:[UIFont systemFontOfSize:14.0]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, w, 50)];
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:14.0];
    label.text = title;
    label.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label];
    
    CGFloat w1 = [self getWidthWithTitle:content font:[UIFont systemFontOfSize:14.0]];
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(label.MaxX+10, 0, w1, 50)];
    lab1.textColor = [UIColor lightGrayColor];
    lab1.font = [UIFont systemFontOfSize:14.0];
    lab1.text = content;
    lab1.textAlignment = NSTextAlignmentLeft;
    [view addSubview:lab1];
    
    return view;
}

- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAXFLOAT, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

- (void)nextPage {
    SecondViewController *vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
