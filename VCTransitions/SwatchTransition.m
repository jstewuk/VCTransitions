//
//  SwatchTransition.m
//  VCTransitions
//
//  Created by James Stewart on 9/28/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import "SwatchTransition.h"

const CGFloat kSwatchPresentDuration = 1.5;
const CGFloat kSwatchDismissDuration = 0.25;

@implementation SwatchTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.mode == SwatchTransitionModePresent)
        return kSwatchPresentDuration;
    else
        return kSwatchDismissDuration;
}


// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect sourceRect = [transitionContext initialFrameForViewController:fromVC];
    
    CGAffineTransform rotation = CGAffineTransformMakeRotation(- M_PI / 2);
    
    UIView *container = [transitionContext containerView];
    
    if (self.mode == SwatchTransitionModePresent) {
        toVC.view.layer.anchorPoint = CGPointZero;
        toVC.view.frame = sourceRect;
        toVC.view.transform = rotation;

        [container addSubview:toVC.view];
        [UIView
         animateWithDuration:kSwatchPresentDuration
         delay:0
         usingSpringWithDamping:0.25
         initialSpringVelocity:3
         options:UIViewAnimationOptionCurveEaseIn
         animations:^{
             toVC.view.transform = CGAffineTransformIdentity;
         } completion:^(BOOL finished) {
             [transitionContext completeTransition:YES];
         }];
    } else if (self.mode == SwatchTransitionModeDismiss) {
        [UIView
         animateWithDuration:kSwatchDismissDuration
         delay:0
         options:UIViewAnimationOptionCurveEaseIn
         animations:^{
             fromVC.view.transform = rotation;
         } completion:^(BOOL finished) {
             [fromVC.view removeFromSuperview];
             [transitionContext completeTransition:YES];
         }];
    }
}


@end
