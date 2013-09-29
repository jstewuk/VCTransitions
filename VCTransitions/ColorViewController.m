//
//  ColorViewController.m
//  VCTransitions
//
//  Created by James Stewart on 9/28/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import "ColorViewController.h"
#import "ColorViewControllerDelegate.h"
#import "InteractiveSwipe.h"

@interface ColorViewController () <ColorViewControllerDelegate>
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, weak) id <ColorViewControllerDelegate> delegate;
@end

@implementation ColorViewController

- (id)initWithDelegate:(id)delegate color:(UIColor *)color  {
    self = [super init];
    if (self) {
        _color = color;
        _delegate = delegate;
        self.modalPresentationStyle = UIModalPresentationCustom;
        [self setupButton];
        [self setupGestureRecognizer];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = self.color;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self wireUpInteraction];
}

- (void)wireUpInteraction {
    id animator = [self.transitioningDelegate animationControllerForDismissedController:self];
    id interactor = [self.transitioningDelegate interactionControllerForDismissal:animator];
    
    if ( [interactor respondsToSelector:@selector(attachToViewController:)]) {
        [interactor attachToViewController:self];
    }
}

- (void)setupButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Dismiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismissTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[button]-10-|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:@{@"button" : button} ];
    NSArray *hConstraints = @[[NSLayoutConstraint constraintWithItem:button
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0
                                                          constant:0] ];
    
    [self.view addConstraints:vConstraints];
    [self.view addConstraints:hConstraints];
}

- (void)dismissTapped:(id)sender {
    [self.delegate viewControllerWasDismissed:self];
}

- (void)setupGestureRecognizer {
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(onTap:)];
    [self.view addGestureRecognizer:tapGR];
}

- (void)onTap:(id)sender {
    ColorViewController *nextColor = [[ColorViewController alloc] initWithDelegate:self color:[self randomColor]];
    nextColor.transitioningDelegate = self.transitioningDelegate;
    [self presentViewController:nextColor animated:YES completion:nil];
}


- (UIColor *)randomColor {
    return [UIColor colorWithRed:(arc4random() % 255) / 255.0
                           green:(arc4random() % 255) / 255.0
                            blue:(arc4random() % 255) / 255.0
                           alpha:1.0];
}

#pragma mark - ColorViewControllerDelegate 

- (void)viewControllerWasDismissed:(UIViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

@end
