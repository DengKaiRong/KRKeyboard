//
//  KRPasswordKeyboard.h
//  KRKeyBoardProject
//
//  Created by dengsir on 28/05/2017.
//  Copyright © 2017 dengsir. All rights reserved.
//

// 交易密码键盘

#import <UIKit/UIKit.h>
#import "KRBaseKeyboard.h"

@interface KRPasswordKeyboard : KRBaseKeyboard

/**
 快速创建交易密码键盘

 @param delegateTarget 代理对象
 @return 键盘对象
 */
+ (KRPasswordKeyboard *)creatPasswordKeyboardWithDelegateTarget:(id<KRBaseKeyboardDelegate>)delegateTarget;

@end
