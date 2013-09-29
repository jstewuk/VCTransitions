//
//  InteractiveSwipe.h
//  VCTransitions
//
//  Created by James Stewart on 9/28/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InteractiveSwipe : UIPercentDrivenInteractiveTransition

@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

- (void)attachToViewController:(UIViewController *)viewController;
@end
