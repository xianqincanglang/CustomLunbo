//
//  ViewController.m
//  CustomScrolllView
//
//  Created by 陈天宇 on 16/4/27.
//  Copyright © 2016年 陈天宇. All rights reserved.
//

#import "ViewController.h"

#import "CustomScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *imageArray = [[NSArray alloc] initWithObjects:
                                   [UIImage imageNamed:@"0.jpg"],
                                   [UIImage imageNamed:@"1.jpg"],
                                   [UIImage imageNamed:@"2.jpg"],
                                   [UIImage imageNamed:@"3.jpg"], nil];
    CustomScrollView *customScrollView = [[CustomScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300) withImageArray:imageArray];
   
    [self.view addSubview:customScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
