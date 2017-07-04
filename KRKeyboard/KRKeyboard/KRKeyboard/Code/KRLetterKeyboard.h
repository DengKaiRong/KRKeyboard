//
//  KRLetterKeyboard.h
//  KRKeyBoardProject
//
//  Created by dengsir on 28/05/2017.
//  Copyright © 2017 dengsir. All rights reserved.
//

// 字母键盘

#import <UIKit/UIKit.h>
#import "KRBaseKeyboard.h"

@interface KRLetterKeyboard : KRBaseKeyboard

/**
 快速创建字母键盘
 
 @param delegateTarget 代理对象
 @return 键盘对象
 */
+ (KRLetterKeyboard *)creatLetterKeyboardWithDelegateTarget:(id<KRBaseKeyboardDelegate>)delegateTarget;

@end
