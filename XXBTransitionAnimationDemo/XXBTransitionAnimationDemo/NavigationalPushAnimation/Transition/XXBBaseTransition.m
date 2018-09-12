//
//  XXBBaseTransition.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing5 on 2018/9/12.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBBaseTransition.h"

@implementation XXBBaseTransition

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}
@end
