//
//  SCCellPanBaseGesture.h
//  WeTime
//
//  Created by Aevit on 15/3/27.
//  Copyright (c) 2015年 Aevit. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LEFT_RIGHT_SQUARE_LENGTH    60

typedef void(^SCCellPanResultBlock)(UITableViewCell *cell, BOOL isLeft);


@interface SCCellPanBaseGesture : UIPanGestureRecognizer

/**
 *  the tableview
 */
@property (nonatomic, weak) UITableView *tableView;

/**
 *  callback when did pan to the border of the left or right view
 */
@property (nonatomic, copy) SCCellPanResultBlock scCellPanResultBlock;

/**
 *  the cell will move
 */
@property (nonatomic, weak) UITableViewCell *currCell;

/**
 *  the indexPath of the cell which will move
 */
@property (nonatomic, weak) NSIndexPath *indexPath;

/**
 *  copy the cell which will move
 */
@property (nonatomic, strong) UIView *copiedCell;


/**
 *  the start point when begin to pan
 */
@property (nonatomic, assign) CGPoint startPoint;

/**
 *  the moving point when panning
 */
@property (nonatomic, assign) CGPoint translationPoint;

/**
 *  the left view
 */
@property (nonatomic, strong) UIView *leftView;

/**
 *  the right view
 */
@property (nonatomic, strong) UIView *rightView;

/**
 *  init
 *
 *  @param tableView the tableview
 *  @param block     callback
 *
 *  @return instancetype
 */
- (instancetype)initWithTableView:(UITableView*)tableView block:(SCCellPanResultBlock)block;

/**
 *  add your custom left and right view
 *
 *  @param leftView  leftview
 *  @param rightView rightview
 */
- (void)buildLeftView:(UIView*)leftView rightView:(UIView*)rightView;



/**
 *  handle the event when you begin to pan
 *
 *  @param gesture the pan gesture
 */
- (void)handlePanBegin:(UIPanGestureRecognizer*)gesture;

/**
 *  handle the event when you are panning
 *
 *  @param gesture the pan gesture
 */
- (void)handlePanChanged:(UIPanGestureRecognizer*)gesture;

/**
 *  handle the event when you end or cancel to pan
 *
 *  @param gesture the pan gesture
 */
- (void)handlePanEndedOrCancelled:(UIPanGestureRecognizer*)gesture;



/**
 *  do sth during the view moving back when you end or cancel to pan
 */
- (void)movingToOriginCenter;

/**
 *  do sth when the view did move back
 */
- (void)didMoveToOriginCenter;

@end
