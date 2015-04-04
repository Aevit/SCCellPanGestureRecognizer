//
//  ViewController.m
//  SCCellPanGestureRecognizerDemo
//
//  Created by Aevit on 15/4/2.
//  Copyright (c) 2015年 Aevit. All rights reserved.
//

#import "ViewController.h"
#import "DemoTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *horizonPanDemoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    horizonPanDemoBtn.frame = (CGRect){.origin.x = (self.view.frame.size.width - 120) / 2, .origin.y = self.view.center.y - 60, .size = CGSizeMake(120, 40)};
    [horizonPanDemoBtn setTitle:@"Pan Horizon" forState:UIControlStateNormal];
    [horizonPanDemoBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [horizonPanDemoBtn addTarget:self action:@selector(horizonPanDemoBtnPresssed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:horizonPanDemoBtn];
    
    
    UIButton *rotatePanDemoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rotatePanDemoBtn.frame = (CGRect){.origin.x = horizonPanDemoBtn.frame.origin.x, .origin.y = horizonPanDemoBtn.frame.origin.y + horizonPanDemoBtn.frame.size.height + 20, .size = horizonPanDemoBtn.frame.size};
    [rotatePanDemoBtn setTitle:@"Pan Rotate" forState:UIControlStateNormal];
    [rotatePanDemoBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [rotatePanDemoBtn addTarget:self action:@selector(rotatePanDemoBtnPresssed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rotatePanDemoBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)horizonPanDemoBtnPresssed:(UIButton*)sender {
    DemoTableViewController *con = [[DemoTableViewController alloc] init];
    con.panType = SCCellPanTypeHorizon;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:con];
    [self presentViewController:nav animated:YES completion:^{
        ;
    }];
}

- (void)rotatePanDemoBtnPresssed:(UIButton*)sender {
    DemoTableViewController *con = [[DemoTableViewController alloc] init];
    con.panType = SCCellPanTypeRotate;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:con];
    [self presentViewController:nav animated:YES completion:^{
        ;
    }];
}

@end
