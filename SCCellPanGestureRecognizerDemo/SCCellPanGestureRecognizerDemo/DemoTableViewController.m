//
//  DemoTableViewController.m
//  SCCellPanGestureRecognizerDemo
//
//  Created by Aevit on 15/4/2.
//  Copyright (c) 2015年 Aevit. All rights reserved.
//

#import "DemoTableViewController.h"
#import "SCCellPanHorizonGesture.h"
#import "SCCellPanRotateGesture.h"

@interface DemoTableViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation DemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // title
    self.title = (_panType == SCCellPanTypeHorizon ? @"Pan Horizon Demo" : (_panType == SCCellPanTypeRotate ? @"Pan Rotate Demo" : @"what the hell?"));
    
    // doneBarButtonItem
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBtnPressed:)];
    self.navigationItem.rightBarButtonItem = doneBtn;
    
    // tableview
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    // add pan gesture
    [self addPanGesture:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - gesture
- (void)addPanGesture:(UITableView*)tableView {
    
    if (_panType == SCCellPanTypeHorizon) {
        SCCellPanHorizonGesture *panGes = [[SCCellPanHorizonGesture alloc] initWithTableView:tableView block:^(UITableViewCell *cell, BOOL isLeft) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"tips" message:(isLeft ? @"do sth to \"done\"" : @"do sth to \"delete\"") delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
        }];
        [panGes buildLeftImgStr:@"icon_list_ok.png" rightImgStr:@"icon_list_del.png"];
        [self.view addGestureRecognizer:panGes];
        
    } else if (_panType == SCCellPanTypeRotate) {
        SCCellPanRotateGesture *panGes = [[SCCellPanRotateGesture alloc] initWithTableView:tableView block:^(UITableViewCell *cell, BOOL isLeft) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"tips" message:(isLeft ? @"do sth to \"done\"" : @"do sth to \"delete\"") delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
        }];
        [panGes buildLeftImgStr:@"icon_list_ok.png" rightImgStr:@"icon_list_del.png"];
        [self.view addGestureRecognizer:panGes];
    }
}

#pragma mark - actions
- (void)doneBtnPressed:(UIBarButtonItem*)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}

#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.contentView.backgroundColor = self.view.backgroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Row %ld", (long)indexPath.row];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
