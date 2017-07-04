# KRKeyboard

KRKeyboard: A multi-function keyboard.

### Support type:

* numeric 
* alphabetic 
* symbol 
* password

# Effects

[![效果](https://github.com/DengKaiRong/KRKeyboard/blob/master/krkeyboard1.gif)](https://github.com/DengKaiRong/KRKeyboard/blob/master/krkeyboard1.gif)
[![效果](https://github.com/DengKaiRong/KRKeyboard/blob/master/krkeyboard2.gif)](https://github.com/DengKaiRong/KRKeyboard/blob/master/krkeyboard2.gif)

# Use

> 1. Drag `KRKeyboard` folder into your project.
> 2. Import `KRKeyboard.h`
> 3. init KRKeyboard
> 4. implementation protocol
> 5. run project :)

####  numeric keyboard:

```objective-c
// 数字键盘
KRKeyboard * zxKB = [KRKeyboard creatWithKeyboardType:NumberKeyboard delegateTarget:self];
// 设置为输入键盘, tf 是 UITextField 对象
tf.inputView = zxKB;
```

####  alphabetic keyboard:

```objective-c
// 字母键盘
KRKeyboard * zxKB = [KRKeyboard creatWithKeyboardType:LetterKeyboard delegateTarget:self];
// 设置为输入键盘, tf 是 UITextField 对象
tf.inputView = zxKB;
```

####  symbol keyboard:

```objective-c
// 符号键盘
KRKeyboard * zxKB = [KRKeyboard creatWithKeyboardType:SymbolKeyboard delegateTarget:self];
// 设置为输入键盘, tf 是 UITextField 对象
tf.inputView = zxKB;
```

####  password keyboard:

```objective-c
// 密码键盘
KRKeyboard * zxKB = [KRKeyboard creatWithKeyboardType:PassWordKeyboard delegateTarget:self];
// 设置为输入键盘, tf 是 UITextField 对象
tf.inputView = zxKB;
```

# Delegate、Config、Setting:

#### KRKeyboardDelegate:

```objective-c
/**
 按键回调

 @param key 单击的文本
 @param keyType 单击的文本类型
 @param keyboardType 键盘类型
 @param content 已输入的内容
 */
- (void)pressKey:(NSString *)key keyType:(KRKeyType)keyType keyboardType:(KRKeyboardType)keyboardType content:(NSString *)content;
```

#### Config:

on `Define.h` file

```objective-c
//------  键盘配置  ------//

// 字体及大小
#define KRFONTNAME @"Helvetica-light"

// 键盘高度
#define KRKEYBOARDHEIGHT KSCREEN_HEIGHT * 0.4

// 键盘顶部logo视图的高度
#define KRLOGOVIEW_HEIGHT 40
```

#### Setting:

```objective-c
[zxKB setClickSoundEnable:NO];  // 是否开启键盘声音
```

#### any else. see demo.

# Other

#### any issue. Please contact me.

 ```    c
   Q  Q: 448150220
Wechat: dengsir058
E-mail: dengsir@goldenbeetech.com
 ```