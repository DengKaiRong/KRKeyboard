//
//  KRBaseKeyboard.m
//  KRKeyBoardProject
//
//  Created by dengsir on 28/05/2017.
//  Copyright © 2017 dengsir. All rights reserved.
//

#import "KRBaseKeyboard.h"

@interface KRBaseKeyboard()

/** 顶部左边Logo **/
@property (nonatomic, strong) UIImageView * logoImageView;
/** 顶部Logo键盘标题 **/
@property (nonatomic, strong) UILabel * logoLabel;
/** 右上角完成按钮 **/
@property (nonatomic, strong) UIButton * doneButton;

@end

@implementation KRBaseKeyboard

#pragma mark - =============生命周期=================

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setBaseUI];
    
    }
    return self;
}

#pragma mark - =============代理方法=================

#pragma mark - =============事件处理=================

#pragma mark - 右上角完成按钮点击事件
- (void)doneClick:(UIButton *)sender{
    [self.baseKeyboardDelegate pressKey:@"完成" keyType:DoneKeyType keyboardType:CommonKeyboard];
}

#pragma mark - =============网络数据处理==============

#pragma mark - =============声明的成员方法和类方法======

#pragma mark - =============私有方法=================

#pragma mark - 初始化UI
- (void)setBaseUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self creatKeyboardLogoView];
}

#pragma mark - 创建键盘顶部的Logo视图
- (void)creatKeyboardLogoView{
    
    UIView * logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KRLOGOVIEW_HEIGHT)];
    logoView.backgroundColor = [UIColor whiteColor];
    
    // 添加顶部视图
    [self addSubview:logoView];
    // 添加logo视图
    [logoView addSubview:self.logoImageView];
    // 添加标题
    [logoView addSubview:self.logoLabel];
    // 添加完成按钮
    [logoView addSubview:self.doneButton];
    
    //------  添加约束  ------//
    
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(KRLOGOVIEW_HEIGHT - 5);
        make.width.mas_equalTo((KRLOGOVIEW_HEIGHT - 5) * 0.72);
        make.centerY.mas_offset(0);
        make.left.mas_offset(5);
    }];
    
    [_logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_offset(0);
        make.height.mas_offset(KRLOGOVIEW_HEIGHT - 10);
    }];
    
    [_doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-5);
        make.centerY.mas_offset(0);
    }];
    
    //------  添加底部划线  ------//
    UIView * bottomLine = [UIView new];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    [logoView addSubview:bottomLine];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark - =============访问器方法===============

-(void)setHideTopDoneButton:(BOOL)hideTopDoneButton{
    _hideTopDoneButton = hideTopDoneButton;
    self.doneButton.hidden = _hideTopDoneButton;
}

-(UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    }
    return _logoImageView;
}

-(UILabel *)logoLabel{
    if (!_logoLabel) {
        _logoLabel = [[UILabel alloc] init];
        // 设置图片和文字
        NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:@"  KR安全键盘"];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, attrStr.string.length)];
        // 创建一个文字附件对象
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
        textAttachment.image = [UIImage imageNamed:@"github_logo"];  //设置图片源
        textAttachment.bounds = CGRectMake(0, - 7, 27, 27);  //设置图片位置和大小
        // 将文字附件转换成属性字符串
        NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
        // 将转换成属性字符串插入到目标字符串
        [attrStr insertAttributedString:attachmentAttrStr atIndex:0];
        [_logoLabel setAttributedText:attrStr];
        // 设置字体颜色
        _logoLabel.textColor = [UIColor darkGrayColor];
        // 设置字体大小
        _logoLabel.font = KFONT(KRFONTNAME,15);
    }
    return _logoLabel;
}

-(UIButton *)doneButton{
    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
        [_doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(doneClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

@end







