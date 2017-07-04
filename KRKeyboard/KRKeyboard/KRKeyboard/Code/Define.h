//
//  Define.h
//  beta
//
//  Created by dengsir on 28/05/2017.
//  Copyright © 2016年 dengsir. All rights reserved.
//

#ifndef Define_h
#define Define_h

//------  键盘配置  ------//

// 字体及大小
#define KRFONTNAME @"Helvetica-light"

// 键盘高度
#define KRKEYBOARDHEIGHT KSCREEN_HEIGHT * 0.4

// 键盘顶部logo视图的高度
#define KRLOGOVIEW_HEIGHT 40

//------  私人宏定义  ------//

// 屏幕宽
#define KSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
// 屏幕高
#define KSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
// 视图宽
#define KV_WIDTH self.frame.size.width
// 视图高
#define KV_HEIGHT self.frame.size.height
// 设置字体和大小
#define KFONT(f,s) [UIFont fontWithName:(f) size:(s)]
// 机型自适应
#define IS_IPHONE6 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 667 || [UIScreen mainScreen].bounds.size.width == 667)
#define IS_IPHONE6_PLUS ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 736 || [UIScreen mainScreen].bounds.size.width == 736)
#define AUTO_ADAPT_SIZE_VALUE(iPhone4_5, iPhone6, iPhone6plus) (IS_IPHONE6 ? iPhone6 : (IS_IPHONE6_PLUS ? iPhone6plus : iPhone4_5))

#endif /* Define_h */
