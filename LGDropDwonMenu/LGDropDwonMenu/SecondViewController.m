//
//  SecondViewController.m
//  LGDropDwonMenu
//
//  Created by weiguang on 2019/10/15.
//  Copyright © 2019 weiguang. All rights reserved.
//

#import "SecondViewController.h"
#import "MDDropdownMenuView.h"
#import "Macro.h"
#import "UIView+Frame.h"

@interface SecondViewController ()<MDDropdownMenuDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray * arr = [NSArray arrayWithObjects:@"岗位",@"结算方式",@"企业性质",@"财务云",@"报表",@"邮箱", @"服务采购",@"任务",@"生活服务",@"审批",@"资讯",@"文件",nil];
    
    MDDropdownMenuView *menuView = [[MDDropdownMenuView alloc] initWithFrame:CGRectMake(20, 64, SCREEN_WIDTH - 40, 50) title:arr];
    menuView.delegate = self;
    menuView.backgroundColor = [UIColor redColor];
    [self.view addSubview:menuView];
}

- (void)dropdownMenu:(MDDropdownMenuView *)menu selectedCellNumber:(NSInteger)number {
    NSLog(@"你选择的是%ld",number);
}


@end
