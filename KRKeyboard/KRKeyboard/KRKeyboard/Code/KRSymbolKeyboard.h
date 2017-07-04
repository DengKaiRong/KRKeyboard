//
//  KRSymbolKeyboard.h
//  KRKeyBoardProject
//
//  Created by dengsir on 28/05/2017.
//  Copyright © 2017 dengsir. All rights reserved.
//

// 符号键盘

#import <UIKit/UIKit.h>
#import "KRBaseKeyboard.h"

@interface KRSymbolKeyboard : KRBaseKeyboard

/**
 快速创建符号键盘
 
 @param delegateTarget 代理对象
 @return 键盘对象
 */
+ (KRSymbolKeyboard *)creatSymbolKeyboardWithDelegateTarget:(id<KRBaseKeyboardDelegate>)delegateTarget;

@end
