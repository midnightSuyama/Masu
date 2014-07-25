//
//  MasuViewController.m
//  Masu
//
//  Created by midnightSuyama on 07/26/2014.
//  Copyright (c) 2014 midnightSuyama. All rights reserved.
//

#import "MasuViewController.h"
#import <Masu/Masu.h>

@interface MasuViewController ()

@end

@implementation MasuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // UIView demo
    Masu *masu = [[Masu alloc] initWithFrame:CGRectMake(0, 300.0f, 220.0f, 100.0f)];
    masu.backgroundColor = [UIColor colorWithRed:0 green:0.5f blue:0.5f alpha:1];
    masu.text            = @"View";
    [self.view addSubview:masu];
    
    // UIImage demo
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(220.0f, 300.0f, 100.0f, 100.0f)];
    [btn setImage:[Masu imageWithSize:btn.frame.size backgroundColor:[UIColor grayColor] labelText:@"Button"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
