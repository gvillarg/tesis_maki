//
//  ViewController.m
//  GUI Catalogo de plantas
//
//  Created by Gustavo Villar on 2/26/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *barHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.barHeight setConstant:88];
}

@end
