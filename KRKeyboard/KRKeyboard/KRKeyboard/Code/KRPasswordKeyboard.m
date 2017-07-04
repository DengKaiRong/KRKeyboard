//
//  KRPasswordKeyboard.m
//  KRKeyBoardProject
//
//  Created by dengsir on 28/05/2017.
//  Copyright © 2017 dengsir. All rights reserved.
//

#import "KRPasswordKeyboard.h"

@interface KRPasswordKeyboard()

@end

@implementation KRPasswordKeyboard

#pragma mark - =============生命周期=================

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setUI];
        
    }
    return self;
}

#pragma mark - =============代理方法=================

#pragma mark - =============事件处理=================

#pragma mark - 按钮点击事件
- (void)buttonTap:(UIButton *)sender{
    
    switch (sender.tag) {
        case 8:
        {
            [self.baseKeyboardDelegate pressKey:@"删除" keyType:DeleteKeyType keyboardType:PassWordKeyboard];
        }
            break;
        case 9:
        {
            [self.baseKeyboardDelegate pressKey:@"9" keyType:NumberKeyType keyboardType:PassWordKeyboard];
        }
            break;
        case 10:
        {
            [self.baseKeyboardDelegate pressKey:@"0" keyType:NumberKeyType keyboardType:PassWordKeyboard];
        }
            break;
        case 11:
        {
            [self.baseKeyboardDelegate pressKey:@"完成" keyType:DoneKeyType keyboardType:PassWordKeyboard];
        }
            break;
        default:
        {
            [self.baseKeyboardDelegate pressKey:sender.titleLabel.text keyType:NumberKeyType keyboardType:PassWordKeyboard];
        }
            break;
    }
    
}


#pragma mark - =============网络数据处理==============

#pragma mark - =============声明的成员方法和类方法======

/**
 快速创建交易密码键盘
 
 @param delegateTarget 代理对象
 @return 键盘对象
 */
+ (KRPasswordKeyboard *)creatPasswordKeyboardWithDelegateTarget:(id<KRBaseKeyboardDelegate>)delegateTarget{
    KRPasswordKeyboard * keyboard = [[KRPasswordKeyboard alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KRKEYBOARDHEIGHT)];
    keyboard.baseKeyboardDelegate = delegateTarget;
    return keyboard;
}

#pragma mark - =============私有方法=================

#pragma mark - 初始化UI
//初始化UI
- (void)setUI{
    
    // 隐藏右上角完成按钮
    self.hideTopDoneButton = YES;
    
    // 添加按钮
    [self creatButtons];
}

#pragma mark - 创建按钮
- (void)creatButtons{
    // 添加按钮父视图
    UIView * btSuperView = [UIView new];
    [self addSubview:btSuperView];
    
    [btSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_offset(KRLOGOVIEW_HEIGHT);
    }];
    
    // 添加按钮
    for (int i = 0 ; i < 12; i++) {
        UIButton * bt = [UIButton new];
        
        bt.tag = i;
        [bt setBackgroundImage:[[UIImage imageNamed:@"shuzibaikuang"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
        [bt setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        bt.titleLabel.font = KFONT(KRFONTNAME,22);
        [bt addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        [btSuperView addSubview:bt];
        
        switch (i) {
            case 8:
            {
                [bt setTitle:@"" forState:UIControlStateNormal];
                [bt setBackgroundImage:[[UIImage imageNamed:@"dasahnchu"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
            }
                break;
            case 11:
            {
                [bt setTitle:@"完成" forState:UIControlStateNormal];
                [bt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                bt.titleLabel.font = KFONT(KRFONTNAME, 17);
            }
                break;
            case 9:
            {
                [bt setTitle:@"9" forState:UIControlStateNormal];
            }
                break;
            case 10:
            {
                [bt setTitle:@"0" forState:UIControlStateNormal];
            }
                break;
            default:
                break;
        }
    }
    
    [btSuperView.subviews mas_distributeSudokuViewsWithFixedLineSpacing:5 fixedInteritemSpacing:3 warpCount:3 topSpacing:8 bottomSpacing:8 leadSpacing:8 tailSpacing:8];
    
}

#pragma mark - =============访问器方法===============

@end
