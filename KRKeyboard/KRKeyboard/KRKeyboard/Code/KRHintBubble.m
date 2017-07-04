//
//  KRHintBubble.m
//  KRKeyBoardProject
//
//  Created by dengsir on 29/05/2017.
//  Copyright © 2017 dengsir. All rights reserved.
//

#import "KRHintBubble.h"
#import "Masonry.h"
#import "Define.h"

@interface KRHintBubble ()

/** 背景图 **/
@property (nonatomic, strong) UIImageView * imgageView;

/** 文字标签 **/
@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation KRHintBubble

#pragma mark - =============生命周期================

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setBubbleUI];
    }
    return self;
}

#pragma mark - =============代理方法=================

#pragma mark - =============事件处理=================

#pragma mark - =============网络数据处理==============

#pragma mark - =============声明的成员方法和类方法======

/**
 显示气泡
 
 @param button 按钮
 */
- (void)showFromButton:(UIButton *)button{
    
    self.titleLabel.text = button.currentTitle;
    
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    
    CGFloat popViewW = AUTO_ADAPT_SIZE_VALUE(72, 82, 88);
    CGFloat popViewH = AUTO_ADAPT_SIZE_VALUE(100, 108, 118);
    CGFloat popViewX = 0;
    
    CGFloat popViewY = btnFrame.origin.y - (popViewH - btnFrame.size.height);
    if ([button.currentTitle.lowercaseString isEqualToString:@"q"] || [button.currentTitle isEqualToString:@"1"] || [button.currentTitle isEqualToString:@"a"] || [button.currentTitle isEqualToString:@"~"] || [button.currentTitle isEqualToString:@"("] || [button.currentTitle isEqualToString:@"|"] ) {
        
        // 按钮在左边的情形
        self.imgageView.image = [UIImage imageNamed:@"keyboard_pop_left"];
        popViewX = btnFrame.origin.x - AUTO_ADAPT_SIZE_VALUE(4, 4, 4);
        
    } else if ([button.currentTitle.lowercaseString isEqualToString:@"p"] || [button.currentTitle isEqualToString:@"0"] || [button.currentTitle isEqualToString:@"*"] || [button.currentTitle isEqualToString:@"]"] || [button.currentTitle isEqualToString:@"¥"]) {
        
        // 按钮在右边的情形
        self.imgageView.image = [UIImage imageNamed:@"keyboard_pop_right"];
        popViewX = btnFrame.origin.x + btnFrame.size.width - AUTO_ADAPT_SIZE_VALUE(69, 79, 85);

    } else {
        
        // 按钮在中间部分
        self.imgageView.image = [UIImage imageNamed:@"keyboard_pop"];
        popViewX = btnFrame.origin.x - (popViewW - btnFrame.size.width) * 0.5;

    }
    
    CGRect frame = CGRectMake(popViewX, popViewY, popViewW, popViewH);
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    self.frame = frame;
    [window addSubview:self];
}

/**
 显示气泡
 
 @param button 按钮
 @param superView 相对位置父视图
 */
- (void)showFromButton:(UIButton *)button toSuperView:(UIView *)superView{
    
    self.titleLabel.text = button.currentTitle;
    
    CGRect btnFrame = [button convertRect:button.bounds toView:superView];
    
    CGFloat popViewW = AUTO_ADAPT_SIZE_VALUE(72, 82, 88);
    CGFloat popViewH = AUTO_ADAPT_SIZE_VALUE(100, 108, 118);
    CGFloat popViewX = 0;
    
    CGFloat popViewY = btnFrame.origin.y - (popViewH - btnFrame.size.height);
    if ([button.currentTitle.lowercaseString isEqualToString:@"q"] || [button.currentTitle isEqualToString:@"1"] || [button.currentTitle isEqualToString:@"a"] || [button.currentTitle isEqualToString:@"~"] || [button.currentTitle isEqualToString:@"("] || [button.currentTitle isEqualToString:@"|"] ) {
        
        // 按钮在左边的情形
        self.imgageView.image = [UIImage imageNamed:@"keyboard_pop_left"];
        popViewX = btnFrame.origin.x - AUTO_ADAPT_SIZE_VALUE(4, 4, 4);
        
    } else if ([button.currentTitle.lowercaseString isEqualToString:@"p"] || [button.currentTitle isEqualToString:@"0"] || [button.currentTitle isEqualToString:@"*"] || [button.currentTitle isEqualToString:@"]"] || [button.currentTitle isEqualToString:@"¥"]) {
        
        // 按钮在右边的情形
        self.imgageView.image = [UIImage imageNamed:@"keyboard_pop_right"];
        popViewX = btnFrame.origin.x + btnFrame.size.width - AUTO_ADAPT_SIZE_VALUE(69, 79, 85);
        
    } else {
        
        // 按钮在中间部分
        self.imgageView.image = [UIImage imageNamed:@"keyboard_pop"];
        popViewX = btnFrame.origin.x - (popViewW - btnFrame.size.width) * 0.5;
        
    }
    
    CGRect frame = CGRectMake(popViewX, popViewY, popViewW, popViewH);
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    self.frame = frame;
    [window addSubview:self];
}

#pragma mark - =============私有方法=================

#pragma mark - 初始化UI
- (void)setBubbleUI{
    
    //------  添加背景和文字  ------//
    [self addSubview:self.imgageView];
    [self addSubview:self.titleLabel];
    
    [_imgageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_offset(0);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.top.mas_offset(8);
    }];
}

#pragma mark - =============访问器方法===============

-(UIImageView *)imgageView{
    if (!_imgageView) {
        _imgageView = [UIImageView new];
    }
    return _imgageView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = KFONT(KRFONTNAME, 30);
    }
    return _titleLabel;
}

@end
