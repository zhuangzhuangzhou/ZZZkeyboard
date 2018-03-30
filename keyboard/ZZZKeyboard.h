//
//  ZZZKeyboard.h
//  keyboard
//
//  Created by 大大 on 15/3/28.
//  Copyright © 2015年 大大. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZZKeyboard : UIInputView<UITextInputDelegate>
@property (nonatomic,weak) id <UIKeyInput> keyInput;
/**
 是否自动滚动
 */
@property (nonatomic,assign) BOOL isAutoScroll;
@end
