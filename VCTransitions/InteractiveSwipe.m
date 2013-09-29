//
//  InteractiveSwipe.m
//  VCTransitions
//
//  Created by James Stewart on 9/28/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import "InteractiveSwipe.h"

@interface InteractiveSwipe ()
@property (nonatomic, assign) BOOL shouldComplete;

@end

@implementation InteractiveSwipe

- (void)attachToViewController:(UIViewController *)viewController {
    self.viewController = viewController;
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    [self.viewController.view addGestureRecognizer:self.pan];
}

- (void)onPan:(UIPanGestureRecognizer *)pan {
    NSAssert(self.viewController != nil, @"view controller was not set");
    
    CGPoint translation = [pan translationInView:pan.view.superview];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            [self.viewController dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged: {
            const CGFloat kDragAmount = 200;
            const CGFloat kThreshold = 0.5;
            CGFloat percent = translation.x / kDragAmount;
            percent = fmaxf(percent, 0.0);
            percent = fminf(percent, 1.0);
            [self updateInteractiveTransition:percent];
            self.shouldComplete = percent >= kThreshold;
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            if (pan.state == UIGestureRecognizerStateCancelled || ! self.shouldComplete) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

- (CGFloat)completionSpeed {
    return 1 - self.percentComplete;
}

@end
