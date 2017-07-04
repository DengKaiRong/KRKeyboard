//
//  KRNumberKeyboard.m
//  KRKeyBoardProject
//
//  Created by dengsir on 28/05/2017.
//  Copyright © 2017 dengsir. All rights reserved.
//

#import "KRNumberKeyboard.h"
#import "Masonry.h"

@interface KRNumberKeyboard()

@end

@implementation KRNumberKeyboard

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
        case 9:
        {
            [self.baseKeyboardDelegate pressKey:@"符号" keyType:SymbolSwitchKeyType keyboardType:NumberKeyboard];
        }
            break;
        case 10:
        {
            [self.baseKeyboardDelegate pressKey:@"字母" keyType:LetterSwitchKeyType keyboardType:NumberKeyboard];
        }
            break;
        case 11:
        {
            [self.baseKeyboardDelegate pressKey:@"0" keyType:NumberKeyType keyboardType:NumberKeyboard];
        }
            break;
        case 12:
        {
            [self.baseKeyboardDelegate pressKey:@"删除" keyType:DeleteKeyType keyboardType:NumberKeyboard];
        }
            break;
        default:
        {
            [self.baseKeyboardDelegate pressKey:sender.titleLabel.text keyType:NumberKeyType keyboardType:NumberKeyboard];
        }
            break;
    }
    
}

#pragma mark - =============网络数据处理==============

#pragma mark - =============声明的成员方法和类方法======

/**
 快速创建数字键盘
 
 @param delegateTarget 代理对象
 @return 键盘对象
 */
+ (KRNumberKeyboard *)creatNumberKeyboardWithDelegateTarget:(id<KRBaseKeyboardDelegate>)delegateTarget{
    KRNumberKeyboard * keyboard = [[KRNumberKeyboard alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KRKEYBOARDHEIGHT)];
    keyboard.baseKeyboardDelegate = delegateTarget;
    return keyboard;
}

#pragma mark - =============私有方法=================

#pragma mark - 初始化UI
//初始化UI
- (void)setUI{
    // 添加按钮
    [self creatButtons];
}

#pragma mark - 初始化数据
//初始化数据
- (void)setData{
    
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
        
        if (i != 9) {
            
            UIButton * bt = [UIButton new];
            bt.tag = i > 9 ? i + 1 : i;
            [bt setBackgroundImage:[[UIImage imageNamed:@"shuzibaikuang"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
            [bt setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
            [bt setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            bt.titleLabel.font = KFONT(KRFONTNAME,22);
            [bt addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
            [btSuperView addSubview:bt];
            
            switch (i) {
                case 10:
                {
                    [bt setTitle:@"0" forState:UIControlStateNormal];
                }
                    break;
                case 11:
                {
                    [bt setTitle:@"" forState:UIControlStateNormal];
                    [bt setBackgroundImage:[[UIImage imageNamed:@"dasahnchu"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
                }
                    break;
                default:
                    break;
            }
            
        }else{
            
            // 创建2个按钮
            UIView * tempSuperView = [UIView new];
            [btSuperView addSubview:tempSuperView];
            
            // 符号按钮
            UIButton * symbolBt = [UIButton new];
            symbolBt.tag = i;
            [symbolBt setBackgroundImage:[[UIImage imageNamed:@"shuzibaikuang"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
            [symbolBt setTitle:@"符" forState:UIControlStateNormal];
            [symbolBt setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            symbolBt.titleLabel.font = KFONT(KRFONTNAME,17);
            [symbolBt addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
            [tempSuperView addSubview:symbolBt];
            
            // 字母按钮
            UIButton * letterBt = [UIButton new];
            letterBt.tag = i + 1;
            [letterBt setBackgroundImage:[[UIImage imageNamed:@"shuzibaikuang"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
            [letterBt setTitle:@"abc" forState:UIControlStateNormal];
            [letterBt setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            letterBt.titleLabel.font = KFONT(KRFONTNAME,17);
            [letterBt addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
            [tempSuperView addSubview:letterBt];
            
            [tempSuperView.subviews mas_distributeSudokuViewsWithFixedLineSpacing:5 fixedInteritemSpacing:5 warpCount:2 topSpacing:0 bottomSpacing:0 leadSpacing:0 tailSpacing:0];
            
        }
    }
    
    [btSuperView.subviews mas_distributeSudokuViewsWithFixedLineSpacing:5 fixedInteritemSpacing:3 warpCount:3 topSpacing:8 bottomSpacing:8 leadSpacing:8 tailSpacing:8];
}

#pragma mark - =============访问器方法===============

@end
