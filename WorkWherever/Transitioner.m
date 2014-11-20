//
//  Transitioner.m
//  WorkWherever
//
//  Created by Joshua Winskill on 11/20/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

#import "Transitioner.h"

@implementation Transitioner

// Animate a change from one view controller to another
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // Get a reference to the to view, from view, and container view to perform the transition in
    UIView *container = [transitionContext containerView];
    UIView *fromView  = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView    = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    // set up from 2D transforms that we'll use in the animation
    CGAffineTransform offScreenRotateIn = CGAffineTransformMakeTranslation(0, self.rotatePointY);
    CGAffineTransform offScreenRotateOut = CGAffineTransformMakeTranslation(0, self.rotatePointY);
    
    offScreenRotateIn = CGAffineTransformRotate(offScreenRotateIn, self.rotateAngleIn);
    offScreenRotateOut = CGAffineTransformRotate(offScreenRotateOut, self.rotateAngleOut);
    
    offScreenRotateIn = CGAffineTransformTranslate(offScreenRotateIn, 0, -self.rotatePointY);
    offScreenRotateOut = CGAffineTransformTranslate(offScreenRotateOut, 0, -self.rotatePointY);
    
    
    // start the toView location based on which controller is being presented
    //    toView.transform = offScreenRight;
    if (self.presenting == YES) {
        toView.transform = offScreenRotateIn;
    } else {
        toView.transform = offScreenRotateOut;
    }
    
    // Set the anchor point
    toView.layer.anchorPoint = CGPointMake(0, 0);
    fromView.layer.anchorPoint = CGPointMake(0, 0);
    
    // updating the anchor point also moves the position to we have to move the center position to the top-left to compensate
    toView.layer.position = CGPointMake(0, 0);
    fromView.layer.position = CGPointMake(0, 0);
    
    // Add both views to our view controller
    [container addSubview:toView];
    [container addSubview:fromView];
    
    // get the duration of the animation
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // Perform the animation
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.68 initialSpringVelocity:0.5 options:0 animations:^{
        if (self.presenting == YES) {
            fromView.transform = offScreenRotateIn;
        } else if (self.presenting == NO) {
            fromView.transform = offScreenRotateOut;
        }
        toView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.8;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.presenting = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.presenting = NO;
    return self;
}


@end
