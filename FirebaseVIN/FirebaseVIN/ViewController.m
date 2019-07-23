//
//  ViewController.m
//  FirebaseVIN
//
//  Created by 陈美安 on 2019/7/19.
//  Copyright © 2019年 深圳前海容易配. All rights reserved.
// 

#import "ViewController.h"
#import "VINCodeController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}

- (IBAction)topButton:(UIButton *)sender {
    VINCodeController *vinVC = [[VINCodeController  alloc] init];
    [self presentViewController:vinVC animated:YES completion:nil];
}

@end
