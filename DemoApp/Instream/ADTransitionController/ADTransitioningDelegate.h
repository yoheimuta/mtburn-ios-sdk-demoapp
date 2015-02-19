//
//  ADTransitioningDelegate.h
//  ADTransitionController
//
//  Created by Patrick Nollet on 09/10/13.
//  Copyright (c) 2013 Applidium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADTransition.h"

// Our container view must be backed by a CATransformLayer
@interface ADTransitionView : UIView
@end

@interface ADTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning, ADTransitionDelegate>
@property (nonatomic, retain) ADTransition * transition;
- (id)initWithTransition:(ADTransition *)transition;
@end
