//
//  SwatchTransition.h
//  VCTransitions
//
//  Created by James Stewart on 9/28/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SwatchTransitionMode) {
    SwatchTransitionModePresent = 0,
    SwatchTransitionModeDismiss
};

@interface SwatchTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) SwatchTransitionMode mode;

@end
