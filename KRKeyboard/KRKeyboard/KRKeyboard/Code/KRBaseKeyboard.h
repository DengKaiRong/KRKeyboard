//
//  KRBaseKeyboard.h
//  KRKeyBoardProject
//
//  Created by dengsir on 28/05/2017.
//  Copyright © 2017 dengsir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "Masonry.h"

// 按键类型
typedef NS_ENUM(NSInteger, KRKeyType) {
    
    // 切换键类型
    SymbolSwitchKeyType, // 符号键盘切换
    NumberSwitchKeyType, // 数字键盘切换
    LetterSwitchKeyType, // 字母键盘切换
    UpLowSwitchKeyType,  // 大小写切换
    
    // 功能键类型
    DeleteKeyType, // 删除键
    DoneKeyType,   // 完成键
    
    // 值键类型
    SymbolKeyType, // 符号
    NumberKeyType, // 数字
    LetterKeyType  // 字母
    
};

// 键盘类型
typedef NS_ENUM(NSInteger, KRKeyboardType) {
    
    PassWordKeyboard, // 交易密码键盘
    LetterKeyboard,   // 字母键盘
    NumberKeyboard,   // 数字键盘
    SymbolKeyboard,   // 符号键盘
    CommonKeyboard    // 通用键盘(预留拓展), 包括字母/数字/符号键盘, 用于标记顶部右上角的完成按钮, 切勿当具体键盘类型使用!
    
};

@protocol KRBaseKeyboardDelegate <NSObject>

@required

/**
 按键回调

 @param key 文本值
 @param keyType 按键类型
 @param keyboardType 键盘类型
 */
- (void)pressKey:(NSString *)key keyType:(KRKeyType)keyType keyboardType:(KRKeyboardType)keyboardType;

@optional


@end

@interface KRBaseKeyboard : UIView

/** 键盘代理 **/
@property (nonatomic, weak) id<KRBaseKeyboardDelegate> baseKeyboardDelegate;

/** 是否隐藏键盘顶部的完成按钮 默认不隐藏 **/
@property (nonatomic, assign) BOOL hideTopDoneButton;

@end




