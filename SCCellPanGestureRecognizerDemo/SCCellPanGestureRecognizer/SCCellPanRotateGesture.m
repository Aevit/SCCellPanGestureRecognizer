//
//  SCCellPanRotateGesture.m
//  WeTime
//
//  Created by Aevit on 15/3/27.
//  Copyright (c) 2015年 Aevit. All rights reserved.
//

#import "SCCellPanRotateGesture.h"

#define LEFT_RIGHT_MOVE_LENGTH      60

@interface SCCellPanRotateGesture ()

@end

@implementation SCCellPanRotateGesture

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
    
    self.copiedCell = [SCCellPanRotateGesture copyAView:self.currCell];
    self.copiedCell.center = self.currCell.center;
    self.copiedCell.layer.shadowRadius = 4;
    self.copiedCell.layer.shadowColor = [UIColor blackColor].CGColor;
    self.copiedCell.layer.shadowOpacity = 0.4;
    self.copiedCell.layer.shadowOffset = CGSizeMake(1, 1);
    [self.tableView addSubview:self.copiedCell];
    
    self.currCell.hidden = YES;
    
    self.leftView.frame = (CGRect){.origin.x = -self.leftView.frame.size.width, .origin.y = self.copiedCell.frame.origin.y + (self.copiedCell.frame.size.height - self.leftView.frame.size.height) / 2, .size = self.leftView.frame.size};
    [self.copiedCell.superview addSubview:self.leftView];
    
    self.rightView.frame = (CGRect){.origin.x = self.copiedCell.frame.size.width, .origin.y = self.copiedCell.frame.origin.y +  (self.copiedCell.frame.size.height - self.rightView.frame.size.height) / 2, .size = self.rightView.frame.size};
    [self.copiedCell.superview addSubview:self.rightView];
}

- (void)handlePanChanged:(UIPanGestureRecognizer *)gesture {
    
    CGAffineTransform translationT = CGAffineTransformMakeTranslation(self.translationPoint.x, 0);
    
    CGFloat angle = ((self.translationPoint.x / self.tableView.frame.size.width) * 15) * (M_PI / 180.0);
    CGAffineTransform rotationT = CGAffineTransformMakeRotation(angle);
    self.copiedCell.transform = CGAffineTransformConcat(rotationT, translationT);
    
    CGAffineTransform rotationT1 = CGAffineTransformMakeRotation(M_PI / 180 * MIN(self.translationPoint.x - LEFT_RIGHT_MOVE_LENGTH, 0));
    self.leftView.transform = CGAffineTransformConcat(rotationT1, translationT);
    self.leftView.alpha = MIN(self.translationPoint.x / LEFT_RIGHT_MOVE_LENGTH , 1);
    
    CGAffineTransform rotationT2 = CGAffineTransformMakeRotation(M_PI / 180 * MAX(LEFT_RIGHT_MOVE_LENGTH + self.translationPoint.x, 0));
    self.rightView.transform = CGAffineTransformConcat(rotationT2, translationT);
    self.rightView.alpha = MIN(-self.translationPoint.x / LEFT_RIGHT_MOVE_LENGTH , 1);
}

- (void)handlePanEndedOrCancelled:(UIPanGestureRecognizer *)gesture {
    
    if (self.translationPoint.x > 0 && self.translationPoint.x > LEFT_RIGHT_MOVE_LENGTH) {
        // left
        self.scCellPanResultBlock((UITableViewCell*)self.copiedCell.superview, YES);
    }
    
    if (self.translationPoint.x < 0 && self.translationPoint.x < LEFT_RIGHT_MOVE_LENGTH) {
        // right
        self.scCellPanResultBlock((UITableViewCell*)self.copiedCell.superview, NO);
    }
    [super handlePanEndedOrCancelled:gesture];
}

- (void)movingToOriginCenter {
    
    self.copiedCell.transform = CGAffineTransformIdentity;
    self.leftView.transform = self.copiedCell.transform;
    self.rightView.transform = self.copiedCell.transform;
}

- (void)didMoveToOriginCenter {
    
    [self.leftView removeFromSuperview];
    [self.rightView removeFromSuperview];
    
    [self.copiedCell removeFromSuperview];
    self.copiedCell = nil;
    self.currCell.hidden = NO;
}

#pragma mark - Utils
/**
 *  capture a image
 *
 *  @param aView would be caputred
 *
 *  @return a image
 */
+ (UIImage*)captureAImage:(UIView*)aView {
    if(UIGraphicsBeginImageContextWithOptions != NULL) {
        UIGraphicsBeginImageContextWithOptions(aView.frame.size, NO, 0.0);
    } else {
        UIGraphicsBeginImageContext(aView.frame.size);
    }
    [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  copy a view
 *
 *  @param aView the view will be copied
 *
 *  @return the copied view
 */
+ (UIView*)copyAView:(UIView*)aView {
    UIView *aCopidView = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
        aCopidView = [aView snapshotViewAfterScreenUpdates:YES];
    } else {
        aCopidView = [[UIImageView alloc] initWithImage:[SCCellPanRotateGesture captureAImage:aView]];
        aCopidView.frame = aView.frame;
    }
    return aCopidView;
}

@end
