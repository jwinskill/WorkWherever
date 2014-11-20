//
//  Transitioner.h
//  WorkWherever
//
//  Created by Joshua Winskill on 11/20/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Transitioner : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

@property BOOL presenting;
@property float rotatePointY;
@property float rotateAngleIn;
@property float rotateAngleOut;

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;

@end
