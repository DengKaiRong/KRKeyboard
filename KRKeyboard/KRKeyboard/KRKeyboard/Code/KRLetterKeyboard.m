//
//  KRLetterKeyboard.m
//  KRKeyBoardProject
//
//  Created by dengsir on 28/05/2017.
//  Copyright © 2017 dengsir. All rights reserved.
//

#import "KRLetterKeyboard.h"
#import "Masonry.h"
#import "KRHintBubble.h"

@interface KRLetterKeyboard()

/** 字母按钮数组 **/
@property (nonatomic, strong) NSMutableArray * letterBtArray;

/** 大小写标记 **/
@property (nonatomic, assign) BOOL isUp;

/** 键盘气泡 **/
@property (nonatomic, strong) KRHintBubble * bubble;

/** 标识触摸最后的按钮 **/
@property (nonatomic, strong) UIButton * lastButton;

/** 按钮数组 **/
@property (nonatomic, strong) NSMutableArray<UIButton *> * btnArray;

/** 键盘父视图 */
@property (nonatomic, strong) UIView * btSuperView;

@end

@implementation KRLetterKeyboard

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
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        {
            [self.baseKeyboardDelegate pressKey:sender.titleLabel.text keyType:NumberKeyType keyboardType:LetterKeyboard];
        }
            break;
        case 29:
        {
            [self.baseKeyboardDelegate pressKey:@"删除" keyType:DeleteKeyType keyboardType:LetterKeyboard];
        }
            break;
        case 30:
        {
            _isUp = !_isUp;
            
            [self switchUpLowCase:_isUp];
            
            [sender setBackgroundImage:[[UIImage imageNamed:_isUp?@"daxiaoxie_seleted":@"daxiaoxie"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
            
            [self.baseKeyboardDelegate pressKey:@"大小写" keyType:UpLowSwitchKeyType keyboardType:LetterKeyboard];
        }
            break;
        case 38:
        {
            [self.baseKeyboardDelegate pressKey:@"符号" keyType:SymbolSwitchKeyType keyboardType:LetterKeyboard];
        }
            break;
        case 39:
        {
            [self.baseKeyboardDelegate pressKey:@"123" keyType:NumberSwitchKeyType keyboardType:LetterKeyboard];
        }
            break;
        default:
        {
            [self.baseKeyboardDelegate pressKey:sender.titleLabel.text keyType:LetterKeyType keyboardType:LetterKeyboard];
        }
            break;
    }
        
}

#pragma mark - Touch Responders

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.lastButton = nil;
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    if (touch.view != _btSuperView) return;
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

#pragma mark - =============网络数据处理==============

#pragma mark - =============声明的成员方法和类方法======

/**
 快速创建字母键盘
 
 @param delegateTarget 代理对象
 @return 键盘对象
 */
+ (KRLetterKeyboard *)creatLetterKeyboardWithDelegateTarget:(id<KRBaseKeyboardDelegate>)delegateTarget{
    KRLetterKeyboard * keyboard = [[KRLetterKeyboard alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KRKEYBOARDHEIGHT)];
    keyboard.baseKeyboardDelegate = delegateTarget;
    return keyboard;
}

#pragma mark - =============私有方法=================

#pragma mark - 初始化UI
//初始化UI
- (void)setUI{
    
    // 初始化数组
    _letterBtArray = [NSMutableArray new];
    _btnArray = [NSMutableArray new];
    
    // 添加按钮
    [self creatButtons];

}

#pragma mark - 初始化数据
//初始化数据
- (void)setData{
    
}

#pragma mark - 创建按钮
- (void)creatButtons{
    
    NSString * str = @"1 2 3 4 5 6 7 8 9 0 q w e r t y u i o p a s d f g h j k l ; ' z x c v b n m , .";
    NSArray * letterArr = [str componentsSeparatedByString:@" "];
    
    // 添加按钮父视图
    _btSuperView = [UIView new];
    [self addSubview:_btSuperView];
    
    [_btSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_offset(KRLOGOVIEW_HEIGHT);
    }];
    
    for (int i  = 0; i < letterArr.count; i++) {
        
        UIButton * bt = [UIButton new];
        
        bt.tag = i;
        [bt setBackgroundImage:[[UIImage imageNamed:@"zimubaikuang"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
        [bt setTitle:letterArr[i] forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        bt.titleLabel.font = KFONT(KRFONTNAME,22);
        [_btSuperView addSubview:bt];
        bt.enabled = NO;
        
        switch (i) {
            case 29:
            {
                [bt setTitle:@"" forState:UIControlStateNormal];
                [bt setBackgroundImage:[[UIImage imageNamed:@"shanchu"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
                [bt addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
                bt.enabled = YES;
            }
                break;
            case 30:
            {
                [bt setTitle:@"" forState:UIControlStateNormal];
                [bt setBackgroundImage:[[UIImage imageNamed:@"daxiaoxie"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
            }
                break;
            case 38:
            {
                [bt setTitle:@"符" forState:UIControlStateNormal];
                bt.titleLabel.font = KFONT(KRFONTNAME, 17);
            }
                break;
            case 39:
            {
                [bt setTitle:@"123" forState:UIControlStateNormal];
                bt.titleLabel.font = KFONT(KRFONTNAME, 17);
            }
                break;
            default:
                break;
        }
        
        // 启用点击事件
        if (i == 29 || i == 30 || i == 38 || i == 39) {
            [bt addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
            bt.enabled = YES;
        }
        
        //------  添加引用  ------//
        
        if ((i > 9 && i < 29) || (i > 30 && i < 38)) [_letterBtArray addObject:bt];
        
        [_btnArray addObject:bt];
    }
    
    [_btSuperView.subviews mas_distributeSudokuViewsWithFixedLineSpacing:5 fixedInteritemSpacing:2 warpCount:10 topSpacing:8 bottomSpacing:8 leadSpacing:8 tailSpacing:8];
    
}

/**
 切换大小写

 @param isUp 是否切换大写
 */
- (void)switchUpLowCase:(BOOL)isUp{
    
    NSString *upStr = @"Q W E R T Y U I O P A S D F G H J K L Z X C V B N M";
    NSString *lowStr = @"q w e r t y u i o p a s d f g h j k l z x c v b n m";
    
    NSArray * letterArr = [NSArray arrayWithArray:isUp?[upStr componentsSeparatedByString:@" "]:[lowStr componentsSeparatedByString:@" "]];
    
    [_letterBtArray enumerateObjectsUsingBlock:^(UIButton *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitle:letterArr[idx] forState:UIControlStateNormal];
    }];

}

#pragma mark - 获取当前按钮
- (UIButton *)keyboardButtonWithLocation:(CGPoint)location
{
    for (UIButton *btn in _btnArray) {
        if (CGRectContainsPoint(btn.frame, location)) {
            // 过滤
            if (btn.tag == 29 || btn.tag == 30 || btn.tag == 38 || btn.tag == 39) return nil;
            
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
