//
//  ViewController.m
//  KRKeyboard
//
//  Created by dengsir on 04/07/2017.
//  Copyright © 2017 dengsir. All rights reserved.
//

#import "ViewController.h"
#import "KRKeyboard.h"

@interface ViewController () <KRKeyboardDelegate>
{
    UITextField * tf;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置VC背景
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // 添加文本输入框
    tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, 40)];
    [self.view addSubview:tf];
    // 设置文本输入框
    tf.backgroundColor = [UIColor whiteColor];
    
    
    //------  实例化键盘  ------//
    
    // 交易密码键盘
    KRKeyboard * zxKB = [KRKeyboard creatWithKeyboardType:PassWordKeyboard delegateTarget:self];
    
    // 字母键盘
    //    KRKeyboard * zxKB = [KRKeyboard creatWithKeyboardType:LetterKeyboard delegateTarget:self];
    
    // 数字键盘
    //    KRKeyboard * zxKB = [KRKeyboard creatWithKeyboardType:NumberKeyboard delegateTarget:self];
    
    // 符号键盘
    // KRKeyboard * zxKB = [KRKeyboard creatWithKeyboardType:SymbolKeyboard delegateTarget:self];
    
    // [zxKB setClickSoundEnable:NO];  // 是否开启键盘声音
    
    // 设置为输入键盘
    tf.inputView = zxKB;
}

#pragma mark - KRKeyboardDelegate

- (void)pressKey:(NSString *)key keyType:(KRKeyType)keyType keyboardType:(KRKeyboardType)keyboardType content:(NSString *)content{
    
    NSLog(@"key = %@ keyType = %ld KeyboardType = %ld",key,(long)keyType,(long)keyboardType);
    
    if (keyType == DoneKeyType) {
        [tf resignFirstResponder];
    }
    
    tf.text = content;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 放弃第一响应者
    [tf resignFirstResponder];
}

@end
