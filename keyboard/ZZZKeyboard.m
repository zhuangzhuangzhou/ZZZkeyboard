//
//  ZZZKeyboard.m
//  keyboard
//
//  Created by 货大大 on 16/3/28.
//  Copyright © 2016年 货大大. All rights reserved.
//

#import "ZZZKeyboard.h"


#pragma mark BUTTON 组件


typedef NS_ENUM(NSInteger,ZZZKeyboardButtonStyle){
    ZZZKeyboardButtonStyleWhite,
    ZZZKeyboardButtonStyleGrey,
    ZZZKeyboardButtonStyleDismiss,
    ZZZKeyboardButtonStyleDone
};


@interface ZZZKeyboardButton : UIButton

+(ZZZKeyboardButton *)keyboardButtonWithStyle:(ZZZKeyboardButtonStyle)style;


@property (nonatomic,strong) UIColor *bgColor;//背景色
@property (nonatomic,strong) UIColor *highlightedBgColor;//选中-背景色

@property (nonatomic,strong) UIColor *textColor;//文字颜色
@property (nonatomic,strong) UIColor *highlightedTextColor;//选中-文字颜色

@property (nonatomic,assign) ZZZKeyboardButtonStyle style;//样式
@end

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
        self.imageView.tintColor = self.textColor;
    }else{
        self.backgroundColor = self.bgColor;
        self.imageView.tintColor = self.highlightedTextColor;
    }
}


//色值
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



/*********************************************************************/


static __weak id currentFirstResponder;
@implementation UIResponder(FirstResponder)


+ (id)ZZZ_currentFirstResponder
{
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(ZZZ_findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}
#pragma clang diagnostic pop

- (void)ZZZ_findFirstResponder:(id)sender
{
    currentFirstResponder = self;
}

@end


/*********************************************************************/


#define SCREENWIDE CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREENHEIGHT  CGRectGetHeight([UIScreen mainScreen].bounds)


#define HEIGHT 196// 240 - 44

static NSInteger currentIndex = 0;
static NSInteger previousIndex = 5645;

@interface ZZZKeyboard()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIView *provinceView;
@property (nonatomic,strong)UIView *letterView;
@property (nonatomic,strong)UIView *numView;

@end

@implementation ZZZKeyboard

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame inputViewStyle:UIInputViewStyleDefault];
    if (self) {
        [self initToolButton];
        [self initKeyboard];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame inputViewStyle:(UIInputViewStyle)inputViewStyle{
    self = [super initWithFrame:frame inputViewStyle:inputViewStyle];
    if (self) {

    }
    return self;
}




- (void)initKeyboard{
    //[self addSubview:self.scrollView];
    
    NSArray *provinceArray = @[@"京",@"渝",@"黑",@"闽",@"鄂",@"川",@"甘",@"津",@"晋",@"苏",@"赣",@"湘",@"黔",@"青",@"蒙",@"沪",@"辽",@"浙",@"鲁",@"粤",@"云",@"藏",@"宁",@"冀",@"吉",@"皖",@"豫",@"琼",@"陕",@"桂",@"新"];
    [self CreateButtonWithArray:provinceArray columeCount:8 backspaceButtonIndex:7 textFont:[UIFont systemFontOfSize:18 weight:UIFontWeightRegular] for:self.provinceView];
    
    NSArray *leeterArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    [self CreateButtonWithArray:leeterArray columeCount:7 backspaceButtonIndex:6 textFont:[UIFont systemFontOfSize:18 weight:UIFontWeightRegular] for:self.letterView ];
    
    NSArray *numArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"0",@"7",@"8",@"9"];
    [self CreateButtonWithArray:numArray columeCount:4 backspaceButtonIndex:3 textFont:[UIFont systemFontOfSize:18 weight:UIFontWeightRegular]for:self.numView];
}



- (void)initToolButton{
    NSArray *array = @[@"",@"省",@"ABC",@"123",@"确定"];
    float width = SCREENWIDE / 5 ;
    float height = 44;
    
    for (int i = 0; i < array.count; i ++) {
        ZZZKeyboardButton *button = [ZZZKeyboardButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * width, (self.frame.size.height - height), width, height);
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
        
        if (i == 0) {
            button.style = ZZZKeyboardButtonStyleGrey;
            [button setImage:[UIImage imageNamed:@"ic_keyboard_folded_small"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(dismissKeyboard:) forControlEvents:UIControlEventTouchUpInside];
        }else if(i == array.count - 1){
            button.style = ZZZKeyboardButtonStyleDone;
            [button addTarget:self action:@selector(dismissKeyboard:) forControlEvents:UIControlEventTouchUpInside];
        }else {
            button.style = ZZZKeyboardButtonStyleGrey;
            button.tag = 5644 + i;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(handleToolButton:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 1) {
                button.selected = YES;
                NSLog(@"TAG :%ld",(long)button.tag);
            }
        }
        [self addSubview:button];
    }
}



- (void)handleToolButton:(UIButton *)sender{

    currentIndex = sender.tag;
    UIButton *currentButton = (UIButton *)[self viewWithTag:currentIndex];
    currentButton.selected = YES;
    currentButton.userInteractionEnabled = NO;

     NSLog(@"previousButton :%@,enabled:%d",sender  ,sender.userInteractionEnabled);

    UIButton *previousButton = (UIButton *)[self viewWithTag:previousIndex];
    previousButton.selected = NO;
    currentButton.userInteractionEnabled = YES;
    previousIndex = currentIndex;
    
    
    if (sender.tag == 5645) {
        [self.scrollView setContentOffset:CGPointZero animated:YES];
    }else if (sender.tag == 5646){
        [self.scrollView setContentOffset:CGPointMake(SCREENWIDE, 0) animated:YES];
    }else if (sender.tag == 5647){
        [self.scrollView setContentOffset:CGPointMake(2 * SCREENWIDE, 0) animated:YES];
    }
}


- (id<UIKeyInput>)keyInput
{
    id <UIKeyInput> keyInput = _keyInput;
    if (keyInput) {
        return keyInput;
    }

    keyInput = [UIResponder ZZZ_currentFirstResponder];
    if (![keyInput conformsToProtocol:@protocol(UITextInput)]) {
        return nil;
    }

    _keyInput = keyInput;

    return keyInput;
}


- (void)dismissKeyboard:(UIButton *)sender
{
    UIResponder *firstResponder = self.keyInput;
    if (firstResponder) {
        [firstResponder resignFirstResponder];
    }
}




/**
 *  批量给View上添加button
 *
 *  @param array     包含button名字的数组
 *  @param count     列数
 *  @param index     退格
 *  @param font      字体
 *  @param superView 要添加的View
 */
- (void)CreateButtonWithArray:(NSArray *)array columeCount:(NSUInteger)count backspaceButtonIndex:(NSUInteger)index textFont:(UIFont *)font for:(UIView *)superView{
    
    NSMutableArray *nameArray = [NSMutableArray arrayWithArray:array];
    [nameArray insertObject:@"" atIndex:index];
    
    NSUInteger line = nameArray.count / count;//行数
    if (nameArray.count % count) {
        line += 1;
    }
    
    float width = SCREENWIDE / count;
    float height = HEIGHT / line;
    
    for (int i = 0; i < nameArray.count ; i ++) {
        ZZZKeyboardButton *button = [ZZZKeyboardButton keyboardButtonWithStyle:ZZZKeyboardButtonStyleWhite];
        button.frame = CGRectMake((i % count) * width, (i / count) * height + 0.5, width - 0.5 , height - 0.5);
        if (i == index) {
            [button setImage:[UIImage imageNamed:@"ic_keyboard_backspace_small"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonBackspace:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [button setTitle:nameArray[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonInput:) forControlEvents:UIControlEventTouchUpInside];
        }
            [superView addSubview:button];
        
        if ([button.titleLabel.text isEqualToString:@"0"]) {
            CGRect frame = button.frame;
            frame.size.height = height * 2 - 0.5;
            button.frame = frame;
        }
        
    }
}

- (void)buttonInput:(UIButton *)sender{
    
    id <UIKeyInput>keyInput = self.keyInput;
    [keyInput insertText:sender.titleLabel.text];
    
}


- (void)buttonBackspace:(UIButton *)sender{
    id <UIKeyInput> keyInput = self.keyInput;
    [keyInput deleteBackward];
}



//色值
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

#pragma mark scrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    NSInteger index = offset.x / SCREENWIDE;
    
    UIButton *provinceButton = [self viewWithTag:5645 + index];
    provinceButton.selected = NO;
    
    UIButton *button = [self viewWithTag:5645 + index];
    button.selected = YES;
//    if (index == 1) {
//        
//    }else if(index == 2){
//        
//    }else if (index == 3){
//        
//    }
    
}




#pragma mark getter

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDE, HEIGHT)];
        _scrollView.contentSize = CGSizeMake( 3 * SCREENWIDE, HEIGHT);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}


- (UIView *)provinceView{
    if (!_provinceView) {
        _provinceView = [[UIView alloc]initWithFrame:_scrollView.frame];
        [self.scrollView addSubview:_provinceView];
    }
    return _provinceView;
}


- (UIView *)letterView{

    if (!_letterView) {
        _letterView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDE, 0, SCREENWIDE, HEIGHT)];
        [self.scrollView addSubview:_letterView];
    }
    return _letterView;
}


- (UIView *)numView{
    if (!_numView) {
        _numView = [[UIView alloc]initWithFrame:CGRectMake(2 * SCREENWIDE,0 , SCREENWIDE, HEIGHT)];
        [self.scrollView addSubview:_numView];
    }
    return _numView;
}


@end





