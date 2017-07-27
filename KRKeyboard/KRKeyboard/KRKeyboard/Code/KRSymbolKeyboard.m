//
//  KRSymbolKeyboard.m
//  KRKeyBoardProject
//
//  Created by dengsir on 28/05/2017.
//  Copyright © 2017 dengsir. All rights reserved.
//

#import "KRSymbolKeyboard.h"
#import "Masonry.h"
#import "KRHintBubble.h"

#define FIXEDLINESPACING 5 // 行间距
#define FIXEDINTERITEMSPACING 2 // 列间距
#define WARPCOUNT 10 // 折行点
#define TOPSPACING 8 // 顶间距
#define BOTTOMSPACING 8 // 底间距
#define LEADSPACING 8 // 左间距
#define TAILSPACING 8 // 右间距
#define ITEM_HEIGHT(f) ((KRKEYBOARDHEIGHT-(((f)-1)*FIXEDLINESPACING)-BOTTOMSPACING-TOPSPACING-KRLOGOVIEW_HEIGHT)/(f))
#define ITEM_WIDTH ((KSCREEN_WIDTH-(((WARPCOUNT-1)*FIXEDINTERITEMSPACING)+LEADSPACING+TAILSPACING))/WARPCOUNT)

@interface KRSymbolKeyboard()
{
    UIView * topSuperView;
}

/** 键盘气泡 **/
@property (nonatomic, strong) KRHintBubble * bubble;

/** 标识触摸最后的按钮 **/
@property (nonatomic, strong) UIButton * lastButton;

/** 按钮数组 **/
@property (nonatomic, strong) NSMutableArray<UIButton *> * btnArray;

@end

@implementation KRSymbolKeyboard

#pragma mark - =============生命周期=================

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setData];
        
        [self setUI];
        
    }
    return self;
}

#pragma mark - =============代理方法=================

#pragma mark - Touch Responders

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.lastButton = nil;
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    if (touch.view != topSuperView) return;
    CGPoint location = [touch locationInView:touch.view];
    UIButton *btn = [self keyboardButtonWithLocation:location];
    
    if (btn) {
        self.lastButton = btn;
        [self.bubble showFromButton:btn];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.bubble removeFromSuperview];
    
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:touch.view];
    UIButton *btn = [self keyboardButtonWithLocation:location];
    
    if (btn) {
        [self buttonTap:btn];
    } else if (self.lastButton) {
        [self buttonTap:self.lastButton];
    }
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.bubble removeFromSuperview];
}

#pragma mark - =============事件处理=================

#pragma mark - 按钮点击事件
- (void)buttonTap:(UIButton *)sender{
    
    switch (sender.tag) {
        case 29:
        {
            [self.baseKeyboardDelegate pressKey:@"删除" keyType:DeleteKeyType keyboardType:SymbolKeyboard];
        }
            break;
        case 30:
        {
            [self.baseKeyboardDelegate pressKey:@"数字" keyType:NumberSwitchKeyType keyboardType:SymbolKeyboard];
        }
            break;
        case 31:
        {
            [self.baseKeyboardDelegate pressKey:@"字母" keyType:LetterSwitchKeyType keyboardType:SymbolKeyboard];
        }
            break;
        case 34:
        {
            [self.baseKeyboardDelegate pressKey:@" " keyType:SymbolKeyType keyboardType:SymbolKeyboard];
        }
            break;
        default:
        {
            [self.baseKeyboardDelegate pressKey:sender.titleLabel.text keyType:SymbolKeyType keyboardType:SymbolKeyboard];
        }
            break;
    }
    
}

#pragma mark - =============网络数据处理==============

#pragma mark - =============声明的成员方法和类方法======

/**
 快速创建符号键盘
 
 @param delegateTarget 代理对象
 @return 键盘对象
 */
+ (KRSymbolKeyboard *)creatSymbolKeyboardWithDelegateTarget:(id<KRBaseKeyboardDelegate>)delegateTarget{
    KRSymbolKeyboard * keyboard = [[KRSymbolKeyboard alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KRKEYBOARDHEIGHT)];
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
    _btnArray = [NSMutableArray new];
}

#pragma mark - 创建按钮
- (void)creatButtons{
    
    //------  添加按钮父视图  ------//
    
    topSuperView = [UIView new];
    [self addSubview:topSuperView];
    
    [topSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_offset(KRLOGOVIEW_HEIGHT);
    }];

    //------  添加按钮  ------//
    
    NSString * str = @"~ ` ! @ # $ % ^ & * ( ) _ - + = { } [ ] | \\ : ; “ ‘ < ， > back 123 abc ? . space / € ￡ ¥";
    
    NSArray * symbolArr = [str componentsSeparatedByString:@" "];
    
    for (int i = 0; i < symbolArr.count; i++) {
        
        UIButton * bt = [UIButton new];
        bt.tag = i;
        [bt setBackgroundImage:[[UIImage imageNamed:@"zimubaikuang"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
        [bt setTitle:symbolArr[i] forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        bt.titleLabel.font = KFONT(KRFONTNAME,22);
        bt.enabled = NO;
        
        switch (i) {
            case 29:
            {
                [bt setTitle:@"" forState:UIControlStateNormal];
                [bt setBackgroundImage:[[UIImage imageNamed:@"shanchu"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
            }
                break;
            case 30:
            case 31:
            {
                bt.titleLabel.font = KFONT(KRFONTNAME,16);
            }
                break;
            case 34:
            {
                [bt setTitle:@"" forState:UIControlStateNormal];
                [bt setBackgroundImage:[[UIImage imageNamed:@"kongge"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
            }
                break;
            default:
                break;
        }
        
        // 启用点击事件
        if (i == 29 || i == 30 || i == 31 || i == 34) {
            [bt addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
            bt.enabled = YES;
        }
        
        // 添加到父视图
        if (i < 34) {
            [topSuperView addSubview:bt];
        }
        
        // 添加到数组
        [_btnArray addObject:bt];
        
    }
    
    [topSuperView.subviews mas_distributeSudokuViewsWithFixedLineSpacing:FIXEDLINESPACING fixedInteritemSpacing:FIXEDINTERITEMSPACING warpCount:WARPCOUNT topSpacing:TOPSPACING bottomSpacing:BOTTOMSPACING leadSpacing:LEADSPACING tailSpacing:TAILSPACING];
    
    //------  添加最后5个按钮约束  ------//
    
    UIButton * referenceBt = _btnArray[33];
    UIButton * preBt;
    
    for (NSInteger i = _btnArray.count - 1; i >= 34; i--) {
        
        UIButton * currentBt = _btnArray[i];
        
        [topSuperView addSubview:currentBt];
        
        if (i == _btnArray.count - 1){
            // 最后按钮
            [currentBt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(referenceBt);
                make.right.mas_offset(-TAILSPACING);
                make.width.mas_equalTo(ITEM_WIDTH);
            }];
        }else if (i == 34){
            // 空格按钮
            [currentBt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(referenceBt.mas_right).mas_offset(FIXEDINTERITEMSPACING);
                make.top.bottom.mas_equalTo(referenceBt);
                make.right.mas_equalTo(preBt.mas_left).mas_offset(-FIXEDINTERITEMSPACING);
            }];
        }else{
            // 中间按钮
            [currentBt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(preBt.mas_left).mas_offset(-FIXEDINTERITEMSPACING);
                make.top.bottom.mas_equalTo(referenceBt);
                make.width.mas_equalTo(ITEM_WIDTH);
            }];
        }
        
        preBt = currentBt;
    }
    
}

#pragma mark - 获取当前按钮
- (UIButton *)keyboardButtonWithLocation:(CGPoint)location
{
    
    for (UIButton *btn in _btnArray) {
        if (CGRectContainsPoint(btn.frame, location)) {
            // 过滤
            if (btn.tag == 29 || btn.tag == 30 || btn.tag == 31 || btn.tag == 34) return nil;
            
            return btn;
        }
    }
    
    return nil;
}

#pragma mark - =============访问器方法===============

-(KRHintBubble *)bubble{
    if (!_bubble) {
        _bubble = [KRHintBubble new];
    }
    return _bubble;
}

-(NSMutableArray<UIButton *> *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray new];
    }
    return _btnArray;
}

@end
