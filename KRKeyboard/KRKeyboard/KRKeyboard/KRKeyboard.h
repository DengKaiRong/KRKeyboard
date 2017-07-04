//
//  KRKeyboard.h
//  KRKeyBoardProject
//
//  Created by dengsir on 28/05/2017.
//  Copyright © 2017 dengsir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRBaseKeyboard.h"

@protocol KRKeyboardDelegate

// Todo 用于拓展功能


/**
 按键回调

 @param key 单击的文本
 @param keyType 单击的文本类型
 @param keyboardType 键盘类型
 @param content 已输入的内容
 */
- (void)pressKey:(NSString *)key keyType:(KRKeyType)keyType keyboardType:(KRKeyboardType)keyboardType content:(NSString *)content;

@required

@optional

@end

@interface KRKeyboard : UIView

/**********************  其他变量  **********************/

/** 按键声音开关 **/
@property (nonatomic, assign) BOOL clickSoundEnable;

/** 输入的内容文本 **/
@property (nonatomic, strong) NSString * content;

/** 代理 **/
@property (nonatomic, weak) id<KRKeyboardDelegate> keyboardDelegate;

/**********************  类方法和对象方法  **********************/

/**
 快速创建键盘

 @param type 键盘类型
 @param delegateTarget 代理对象
 @return 键盘对象
 */
+(KRKeyboard *)creatWithKeyboardType:(KRKeyboardType)type delegateTarget:(id<KRKeyboardDelegate>)delegateTarget;


/**
 清除所有输入文本
 */
- (void)clearContent;

@end
