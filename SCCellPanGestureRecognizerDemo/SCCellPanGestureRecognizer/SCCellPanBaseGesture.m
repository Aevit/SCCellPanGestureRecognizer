//
//  SCCellBasePanGesture.m
//  WeTime
//
//  Created by Aevit on 15/3/27.
//  Copyright (c) 2015年 Aevit. All rights reserved.
//

#import "SCCellPanBaseGesture.h"

@interface SCCellPanBaseGesture()

@end

@implementation SCCellPanBaseGesture

/**
 *  override
 *
 *  @param target An object that is the recipient of action messages sent by the receiver when it recognizes a gesture. nil is not a valid value.
 *  @param action A selector that identifies the method implemented by the target to handle the gesture recognized by the receiver. The action selector must conform to the signature described in the class overview. NULL is not a valid value.
 *
 *  @return An initialized instance of a concrete UIGestureRecognizer subclass or nil if an error occurred in the attempt to initialize the object.
 */
- (instancetype)initWithTarget:(id)target action:(SEL)action {
    return [self initWithTableView:nil block:nil];
}

/**
 *  init
 *
 *  @param tableView the tableview
 *  @param block     callback when did pan to the border of the left or right view
 *
 *  @return instancetype
 */
- (instancetype)initWithTableView:(UITableView *)tableView block:(SCCellPanResultBlock)block {
    self = [super initWithTarget:self action:@selector(handlePanGesture:)];
    if (self && tableView) {
        self.tableView = tableView;
        self.scCellPanResultBlock = block;
    }
    return self;
}

/**
 *  add your custom left and right view
 *
 *  @param leftView  leftview
 *  @param rightView rightview
 */
- (void)buildLeftView:(UIView *)leftView rightView:(UIView *)rightView {
    self.leftView = leftView;
    self.rightView = rightView;
}

/**
 *  handle the pan gesture event
 *
 *  @param gesture the pan gesture
 */
- (void)handlePanGesture:(UIPanGestureRecognizer*)gesture {
    
    if (!self.tableView) {
        return;
    }
    
    self.startPoint = [gesture locationInView:self.tableView];
    self.translationPoint = [gesture translationInView:self.tableView];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.indexPath = [self.tableView indexPathForRowAtPoint:self.startPoint];
            self.currCell= [self.tableView cellForRowAtIndexPath:self.indexPath];
            [self handlePanBegin:gesture];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            [self handlePanChanged:gesture];
            break;
        }
        case UIGestureRecognizerStateEnded: case UIGestureRecognizerStateCancelled:
        {
            [self handlePanEndedOrCancelled:gesture];
            break;
        }
        default:
            break;
    }
}

/**
 *  handle the event when you begin to pan
 *
 *  @param gesture the pan gesture
 */
- (void)handlePanBegin:(UIPanGestureRecognizer *)gesture {
    
}

/**
 *  handle the event when you are panning
 *
 *  @param gesture the pan gesture
 */
- (void)handlePanChanged:(UIPanGestureRecognizer *)gesture {
    
}

/**
 *  handle the event when you end or cancel to pan
 *
 *  @param gesture the pan gesture
 */
- (void)handlePanEndedOrCancelled:(UIPanGestureRecognizer *)gesture {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self movingToOriginCenter];
    } completion:^(BOOL finished) {
        [self didMoveToOriginCenter];
    }];
#else
    [UIView animateWithDuration:0.5 animations:^{
        [self movingToOriginCenter];
    } completion:^(BOOL finished) {
        [self didMoveToOriginCenter];
    }];
#endif
}

/**
 *  do sth during the view moving back when you end or cancel to pan
 */
- (void)movingToOriginCenter {
    
}

/**
 *  do sth when the view did move back
 */
- (void)didMoveToOriginCenter {
    
}

@end
