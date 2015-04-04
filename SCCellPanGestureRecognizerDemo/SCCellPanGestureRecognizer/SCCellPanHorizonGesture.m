//
//  SCCellPanHorizonGesture.m
//  WeTime
//
//  Created by Aevit on 15/3/27.
//  Copyright (c) 2015年 Aevit. All rights reserved.
//

#import "SCCellPanHorizonGesture.h"

@implementation SCCellPanHorizonGesture

#pragma mark - views
- (void)buildLeftImgStr:(NSString *)leftImgStr rightImgStr:(NSString *)rightImgStr {
    
    UIImageView *leftImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftImgStr]];
    leftImgView.frame = CGRectMake(0, 0, LEFT_RIGHT_SQUARE_LENGTH, LEFT_RIGHT_SQUARE_LENGTH);
    leftImgView.contentMode = UIViewContentModeCenter;
    
    UIImageView *rightImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:rightImgStr]];
    rightImgView.frame = CGRectMake(0, 0, LEFT_RIGHT_SQUARE_LENGTH, LEFT_RIGHT_SQUARE_LENGTH);
    rightImgView.contentMode = UIViewContentModeCenter;
    
    [self buildLeftView:leftImgView rightView:rightImgView];
}

#pragma mark - actions
- (void)handlePanBegin:(UIPanGestureRecognizer *)gesture {
    
    self.copiedCell = self.currCell.contentView;
    
    self.leftView.frame = (CGRect){.origin.x = 0, .origin.y = (self.currCell.frame.size.height - self.leftView.frame.size.height) / 2, .size = self.leftView.frame.size};
    [self.copiedCell.superview insertSubview:self.leftView belowSubview:self.copiedCell];
    
    self.rightView.frame = (CGRect){.origin.x = self.currCell.frame.size.width - self.rightView.frame.size.width, .origin.y = (self.currCell.frame.size.height - self.rightView.frame.size.height) / 2, .size = self.rightView.frame.size};
    [self.copiedCell.superview insertSubview:self.rightView belowSubview:self.copiedCell];
}

- (void)handlePanChanged:(UIPanGestureRecognizer *)gesture {
    
    CGPoint cellCenter = self.copiedCell.center;
    cellCenter.x += self.translationPoint.x;
    self.copiedCell.center = cellCenter;
    
    BOOL isMoveingToRight = self.copiedCell.center.x - self.tableView.center.x > 0;
    self.leftView.alpha = (isMoveingToRight ? 1 : 0);
    self.rightView.alpha = (isMoveingToRight ? 0 : 1);
    
    if (self.copiedCell.center.x - self.tableView.center.x > self.leftView.frame.size.width) {
        self.leftView.frame = (CGRect){.origin.x = self.copiedCell.frame.origin.x - self.leftView.frame.size.width, .origin.y = self.leftView.frame.origin.y, .size = self.leftView.frame.size};
    }
    
    if (self.tableView.center.x - self.copiedCell.center.x > self.rightView.frame.size.width) {
        self.rightView.frame = (CGRect){.origin.x = self.copiedCell.frame.origin.x + self.copiedCell.frame.size.width, .origin.y = self.rightView.frame.origin.y, .size = self.rightView.frame.size};
    }
    
    [gesture setTranslation:CGPointZero inView:gesture.view];
}

- (void)handlePanEndedOrCancelled:(UIPanGestureRecognizer *)gesture {
    
    if (self.copiedCell.center.x - self.tableView.center.x > self.leftView.frame.size.width) {
        // left
        self.scCellPanResultBlock((UITableViewCell*)self.copiedCell.superview, YES);
    }
    
    if (self.tableView.center.x - self.copiedCell.center.x > self.rightView.frame.size.width) {
        // right
        self.scCellPanResultBlock((UITableViewCell*)self.copiedCell.superview, NO);
    }
    [super handlePanEndedOrCancelled:gesture];
}

- (void)movingToOriginCenter {
    
    CGPoint cellCenter = self.copiedCell.center;
    cellCenter.x = self.tableView.center.x;
    self.copiedCell.center = cellCenter;
    
    self.leftView.frame = (CGRect){.origin.x = 0, .origin.y = self.leftView.frame.origin.y, .size = self.leftView.frame.size};
    self.leftView.alpha = 0;
    
    self.rightView.frame = (CGRect){.origin.x = self.copiedCell.superview.frame.size.width - self.rightView.frame.size.width, .origin.y = self.rightView.frame.origin.y, .size = self.rightView.frame.size};
    self.leftView.alpha = 0;
}

- (void)didMoveToOriginCenter {
    
    [self.leftView removeFromSuperview];
    [self.rightView removeFromSuperview];
}

@end
