//
//  TransitionListViewController.m
//  VCTransitions
//
//  Created by James Stewart on 9/28/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import "TransitionListViewController.h"
#import "ColorViewController.h"
#import "ColorViewControllerDelegate.h"
#import "SwatchTransition.h"
#import "InteractiveSwipe.h"

typedef NS_ENUM(NSInteger, TransitionType) {
    TransitionTypeSwatch = 0
};

@interface TransitionListViewController () <ColorViewControllerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) InteractiveSwipe *interactiveSwipe;

@end

@implementation TransitionListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case TransitionTypeSwatch:
            cell.textLabel.text = @"Swatch";
            break;
            
        default:
            break;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ColorViewController *colorVC = [[ColorViewController alloc] initWithDelegate:self color:[UIColor redColor]];
    colorVC.transitioningDelegate = self;
    
    [self presentViewController:colorVC animated:YES completion:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];    
}

- (void)viewControllerWasDismissed:(UIViewController *)viewController {
    //[viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    SwatchTransition *transition = [[SwatchTransition alloc] init];
    transition.mode = SwatchTransitionModePresent;
    return transition;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    SwatchTransition *transition = [[SwatchTransition alloc] init];
    transition.mode = SwatchTransitionModeDismiss;
    return transition;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    if (!self.interactiveSwipe) {
        self.interactiveSwipe = [[InteractiveSwipe alloc] init];
    }
    return self.interactiveSwipe;
}

@end
