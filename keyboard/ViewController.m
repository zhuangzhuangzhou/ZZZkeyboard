//
//  ViewController.m
//  keyboard
//
//  Created by 大大 on 15/3/28.
//  Copyright © 2015年 大大. All rights reserved.
//

#import "ViewController.h"
#import "ZZZKeyboard.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ZZZKeyboard *keyboard = [[ZZZKeyboard alloc]initWithFrame:CGRectMake(0, 0, 375, 240)];
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(30, 30, 300, 300)];

    textField.placeholder = @"请输入xxxxx";
    textField.inputView = keyboard;

    [self.view addSubview:textField];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
