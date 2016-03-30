//
//  ViewController.m
//  keyboard
//
//  Created by 货大大 on 16/3/28.
//  Copyright © 2016年 货大大. All rights reserved.
//

#import "ViewController.h"
#import "ZZZKeyboard.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


    ZZZKeyboard *key = [[ZZZKeyboard alloc]initWithFrame:CGRectMake(0, 0, 375, 240)];

    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(30, 30, 300, 300)];
    textField.placeholder = @"请输入xxxxx";
    textField.inputView = key;

    [self.view addSubview:textField];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
