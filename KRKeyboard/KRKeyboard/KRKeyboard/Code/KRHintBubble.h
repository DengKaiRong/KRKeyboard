//
//  KRHintBubble.h
//  KRKeyBoardProject
//
//  Created by dengsir on 29/05/2017.
//  Copyright © 2017 dengsir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KRHintBubble : UIView

/**
 显示气泡

 @param button 按钮
 */
- (void)showFromButton:(UIButton *)button;

/**
 显示气泡
 
 @param button 按钮
 @param superView 相对位置父视图
 */
- (void)showFromButton:(UIButton *)button toSuperView:(UIView *)superView;

@end
