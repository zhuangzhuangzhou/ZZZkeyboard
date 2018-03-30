//
//  ZZZKeyboardButton.m
//  keyboard
//
//  Created by WN-Apple on 2018/3/30.
//  Copyright © 2018年 货大大. All rights reserved.
//

#import "ZZZKeyboardButton.h"

@implementation ZZZKeyboardButton

+(ZZZKeyboardButton *)keyboardButtonWithStyle:(ZZZKeyboardButtonStyle)style{
    ZZZKeyboardButton *button = [self buttonWithType:UIButtonTypeCustom];
    button.style = style;
    return button;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self buttonStyleDidChange];
    }
    return self;
}

- (void)setStyle:(ZZZKeyboardButtonStyle)style{
    if (style != _style) {
        _style = style;
        [self buttonStyleDidChange];
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    if (newWindow) {
        [self updateButtonAppearance];
    }
}

- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    [self updateButtonAppearance];
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self updateButtonAppearance];
}

- (void)buttonStyleDidChange{
    const ZZZKeyboardButtonStyle style = self.style;
    
    UIColor *bgColor = nil;
    UIColor *highlightedBgColor = nil;
    if (style == ZZZKeyboardButtonStyleWhite) {
        bgColor = [UIColor whiteColor];
        highlightedBgColor = [self getColor:@"00B365"];
    }else if(style == ZZZKeyboardButtonStyleGrey){
        bgColor = [self getColor:@"E4E8ED"];
        highlightedBgColor =[UIColor whiteColor];
    }else if (style == ZZZKeyboardButtonStyleDone){
        bgColor = [self getColor:@"00B365"];
        highlightedBgColor = [self getColor:@"008C4F"];
    }else if (style == ZZZKeyboardButtonStyleDismiss){
        bgColor = [self getColor:@"E4E8ED"];
        highlightedBgColor = [self getColor:@"CBD1D6"];
    }
    
    
    UIColor *textColor = nil;
    UIColor *highlightedTextColor = nil;
    if (style == ZZZKeyboardButtonStyleGrey) {
        textColor = [self getColor:@"7D7F82"];
        highlightedTextColor = [UIColor blackColor];
    }else if(style == ZZZKeyboardButtonStyleWhite){
        textColor = [UIColor blackColor];
        highlightedTextColor = [UIColor whiteColor];
    }
    
    [self setTitleColor:textColor forState:UIControlStateNormal];
    [self setTitleColor:highlightedTextColor forState:UIControlStateHighlighted];
    [self setTitleColor:highlightedTextColor forState:UIControlStateSelected];
    
    self.bgColor = bgColor;
    self.highlightedBgColor = highlightedBgColor;
    self.textColor = textColor;
    self.highlightedTextColor = highlightedTextColor;
}


- (void)updateButtonAppearance{
    if (self.isHighlighted || self.isSelected) {
        self.backgroundColor = self.highlightedBgColor;
        self.imageView.tintColor = self.highlightedTextColor;
    }else{
        self.backgroundColor = self.bgColor;
        self.imageView.tintColor = self.textColor;
    }
}


- (UIColor *)getColor:(NSString *)hexColor{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt: &red ];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt: &green ];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red / 255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1];
}



@end
