//
//  KRKeyboard.m
//  KRKeyBoardProject
//
//  Created by dengsir on 28/05/2017.
//  Copyright © 2017 dengsir. All rights reserved.
//

#import "KRKeyboard.h"
#import "Define.h"
#import "KRPasswordKeyboard.h"
#import "KRLetterKeyboard.h"
#import "KRNumberKeyboard.h"
#import "KRSymbolKeyboard.h"
#import <AVFoundation/AVFoundation.h>

@interface KRKeyboard() <KRBaseKeyboardDelegate>

/** 交易密码键盘 **/
@property (nonatomic, strong) KRPasswordKeyboard * passwordKeyboard;
/** 数字键盘 **/
@property (nonatomic, strong) KRNumberKeyboard * numberKeyboard;
/** 字母键盘 **/
@property (nonatomic, strong) KRLetterKeyboard * letterKeyboard;
/** 符号键盘 **/
@property (nonatomic, strong) KRSymbolKeyboard * symbolKeyboard;

/** 键盘数组 **/
@property (nonatomic, strong) NSMutableArray * keyboardsArray;

/** 按键声音1 **/
@property (nonatomic, assign) SystemSoundID soundID;
/** 按键声音2 **/
@property (nonatomic, assign) SystemSoundID soundID2;

@end

@implementation KRKeyboard

#pragma mark - =============生命周期=================

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KRKEYBOARDHEIGHT)]) {
        
        [self initKeyboard];
        
    }
    return self;
}

- (void)dealloc{
    AudioServicesDisposeSystemSoundID(_soundID);
    AudioServicesDisposeSystemSoundID(_soundID2);
}

#pragma mark - =============代理方法=================

#pragma mark - KRBaseKeyboardDelegate

- (void)pressKey:(NSString *)key keyType:(KRKeyType)keyType keyboardType:(KRKeyboardType)keyboardType{
    
    //------  拦截键盘切换  ------//
    
    switch (keyType) {
        case SymbolSwitchKeyType:
        {
            [self switchKeyboardWithType:SymbolKeyboard];
            if (_clickSoundEnable) AudioServicesPlaySystemSound(self.soundID2);
        }
            break;
        case NumberSwitchKeyType:
        {
            [self switchKeyboardWithType:NumberKeyboard];
            if (_clickSoundEnable) AudioServicesPlaySystemSound(self.soundID2);
        }
            break;
        case LetterSwitchKeyType:
        {
            [self switchKeyboardWithType:LetterKeyboard];
            if (_clickSoundEnable) AudioServicesPlaySystemSound(self.soundID2);
        }
            break;
        case UpLowSwitchKeyType:
        {
            if (_clickSoundEnable) AudioServicesPlaySystemSound(self.soundID2);
        }
            break;
        case DeleteKeyType:
        {
            if (_content.length > 0) _content = [_content substringToIndex:_content.length - 1];
            if (_clickSoundEnable) AudioServicesPlaySystemSound(self.soundID2);
        }
            break;
        case DoneKeyType:{
            if (_clickSoundEnable) AudioServicesPlaySystemSound(self.soundID2);
        }
            break;
        default:
        {
            _content = [_content stringByAppendingString:key];
            
            if (_clickSoundEnable) AudioServicesPlaySystemSound(self.soundID);
        }
            break;
    }

    [self.keyboardDelegate pressKey:key keyType:keyType keyboardType:keyboardType content:_content];
    
    NSLog(@"content: %@",_content);
}

#pragma mark - =============事件处理=================

#pragma mark - =============网络数据处理==============

#pragma mark - =============声明的成员方法和类方法======

/**
 快速创建键盘
 
 @param type 键盘类型
 @param delegateTarget 代理对象
 @return 键盘对象
 */
+(KRKeyboard *)creatWithKeyboardType:(KRKeyboardType)type delegateTarget:(id<KRKeyboardDelegate>)delegateTarget{
    
    KRKeyboard *zxKeyboard = [KRKeyboard new];
    zxKeyboard.keyboardDelegate = delegateTarget;
    [zxKeyboard switchKeyboardWithType:type];
    return zxKeyboard;
}

//------  保留此方法用于后期拓展  ------//

/**
 快速创建键盘
 
 @param type 键盘类型
 @param delegateTarget 代理对象
 @param keyboardHeight 键盘高度
 @return 键盘对象
 */
+(KRKeyboard *)creatWithKeyboardType:(KRKeyboardType)type delegateTarget:(id<KRKeyboardDelegate>)delegateTarget keyboardHeight:(double)keyboardHeight{
    
    KRKeyboard *zxKeyboard = [KRKeyboard creatWithKeyboardType:type delegateTarget:delegateTarget];
    
    return zxKeyboard;
}

/**
 清除所有输入文本
 */
-(void)clearContent{
    _content = @"";
}
#pragma mark - =============私有方法=================

#pragma mark - 初始化UI
//初始化UI
- (void)setUI{
    
}

#pragma mark - 初始化数据
//初始化数据
- (void)setData{
    
}

#pragma mark - 初始化键盘
- (void)initKeyboard{
    
    // 按键音默认开启
    _clickSoundEnable = YES;
    
    // 初始化输入内容
    _content = @"";
    
    // 初始化键盘
    [self addSubview:self.passwordKeyboard];
    [self addSubview:self.numberKeyboard];
    [self addSubview:self.letterKeyboard];
    [self addSubview:self.symbolKeyboard];
    
    // 添加键盘数组
    self.keyboardsArray = [[NSMutableArray alloc] initWithObjects:_passwordKeyboard,_letterKeyboard,_numberKeyboard,_symbolKeyboard, nil];
    
}

#pragma mark - 切换键盘
- (void)switchKeyboardWithType:(KRKeyboardType)keyboardType{

    if (keyboardType > 3) keyboardType = LetterKeyboard;
    
    for (int i = 0; i < 4; i++) {
        
        KRBaseKeyboard * keyboard = self.keyboardsArray[i];
        
        if (i == keyboardType) {
            keyboard.hidden = NO;
        }else{
            keyboard.hidden = YES;
        }
    }
    
}

#pragma mark - =============访问器方法===============

- (KRPasswordKeyboard *)passwordKeyboard{
    if (!_passwordKeyboard) {
        _passwordKeyboard = [KRPasswordKeyboard creatPasswordKeyboardWithDelegateTarget:self];
        _passwordKeyboard.hidden = YES;
    }
    return _passwordKeyboard;
}

- (KRNumberKeyboard *)numberKeyboard{
    if (!_numberKeyboard) {
        _numberKeyboard = [KRNumberKeyboard creatNumberKeyboardWithDelegateTarget:self];
        _numberKeyboard.hidden = YES;
    }
    return _numberKeyboard;
}

- (KRLetterKeyboard *)letterKeyboard{
    if (!_letterKeyboard) {
        _letterKeyboard = [KRLetterKeyboard creatLetterKeyboardWithDelegateTarget:self];
        _letterKeyboard.hidden = YES;
    }
    return _letterKeyboard;
}

- (KRSymbolKeyboard *)symbolKeyboard{
    if (!_symbolKeyboard) {
        _symbolKeyboard = [KRSymbolKeyboard creatSymbolKeyboardWithDelegateTarget:self];
        _symbolKeyboard.hidden = YES;
    }
    return _symbolKeyboard;
}

- (SystemSoundID)soundID
{
    if (_soundID == 0) {
        NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"keyboard-click.aiff" withExtension:nil];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(soundURL), &_soundID);
    }
    return _soundID;
}

- (SystemSoundID)soundID2
{
    if (_soundID2 == 0) {
        NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"keyboard-click2.aiff" withExtension:nil];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(soundURL), &_soundID2);
    }
    return _soundID2;
}

@end
