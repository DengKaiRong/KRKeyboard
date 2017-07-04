//
//  KRNumberKeyboard.h
//  KRKeyBoardProject
//
//  Created by dengsir on 28/05/2017.
//  Copyright © 2017 dengsir. All rights reserved.
//

// 数字键盘

#import <UIKit/UIKit.h>
#import "KRBaseKeyboard.h"

@interface KRNumberKeyboard : KRBaseKeyboard

/**
 快速创建数字键盘
 
 @param delegateTarget 代理对象
 @return 键盘对象
 */
+ (KRNumberKeyboard *)creatNumberKeyboardWithDelegateTarget:(id<KRBaseKeyboardDelegate>)delegateTarget;

@end
