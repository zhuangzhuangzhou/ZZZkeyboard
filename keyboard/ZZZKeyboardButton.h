//
//  ZZZKeyboardButton.h
//  keyboard
//
//  Created by WN-Apple on 2015/3/30.
//  Copyright © 2015年 大大. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZZZKeyboardButtonStyle){
    ZZZKeyboardButtonStyleWhite,//白色按钮（数字）
    ZZZKeyboardButtonStyleGrey,//灰色按钮（功能）
    ZZZKeyboardButtonStyleDismiss,//回收按钮
    ZZZKeyboardButtonStyleDone//完成按钮
};


@interface ZZZKeyboardButton : UIButton

/**
 初始化
 */
+(ZZZKeyboardButton *)keyboardButtonWithStyle:(ZZZKeyboardButtonStyle)style;

/**
 背景色
 */
@property (nonatomic,strong) UIColor *bgColor;

/**
 高亮背景色
 */
@property (nonatomic,strong) UIColor *highlightedBgColor;

/**
 文字颜色
 */
@property (nonatomic,strong) UIColor *textColor;

/**
 高亮文字颜色
 */
@property (nonatomic,strong) UIColor *highlightedTextColor;

/**
 按钮样式
 */
@property (nonatomic,assign) ZZZKeyboardButtonStyle style;
@end
