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



    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 50);
    [button setBackgroundColor:[UIColor grayColor]];
    button.center = self.view.center;
    [button setTitle:@"你好" forState:UIControlStateNormal];
    [button setTitle:@"高亮" forState:UIControlStateHighlighted];
    [button setTitle:@"选中" forState:UIControlStateSelected];

    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];


    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
