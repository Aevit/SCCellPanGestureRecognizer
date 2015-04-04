//
//  DemoTableViewController.h
//  SCCellPanGestureRecognizerDemo
//
//  Created by Aevit on 15/4/2.
//  Copyright (c) 2015年 Aevit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SCCellPanType) {
    SCCellPanTypeHorizon        = 0,
    SCCellPanTypeRotate         = 1
};

@interface DemoTableViewController : UIViewController

@property (nonatomic, assign) SCCellPanType panType;

@end
