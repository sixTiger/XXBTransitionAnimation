//
//  XXBPushTransition.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing5 on 2018/9/12.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBPushTransition.h"

#define XXBPushTransitionScalSize 0.9

@implementation XXBPushTransition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    switch (self.operation) {
        case UINavigationControllerOperationPush:
        {
            UIViewController *toVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
            UIViewController *fromVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
            UIView * containerView = [transitionContext containerView];
            UIView * fromView = fromVC.view;
            UIView * toView = toVC.view;
            [containerView addSubview:fromView];
            [containerView addSubview:toView];
            NSTimeInterval duration = [self transitionDuration:transitionContext];
            fromView.transform = CGAffineTransformIdentity;
            toView.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(toView.bounds), 0);
            [UIView animateWithDuration:duration animations:^{
                fromView.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(- CGRectGetWidth(fromView.bounds) * (1 - XXBPushTransitionScalSize) * 0.5, 0), XXBPushTransitionScalSize, XXBPushTransitionScalSize);
                toView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                fromView.transform = CGAffineTransformIdentity;
                toView.transform = CGAffineTransformIdentity;
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
            break;
        }
        case UINavigationControllerOperationPop:
        {
            UIViewController *toVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
            UIViewController *fromVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
            UIView * containerView = [transitionContext containerView];
            UIView * fromView = fromVC.view;
            UIView * toView = toVC.view;
            [containerView addSubview:toView];
            [containerView addSubview:fromView];
            
            NSTimeInterval duration = [self transitionDuration:transitionContext];
            toView.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(- CGRectGetWidth(toView.bounds) * (1 - XXBPushTransitionScalSize) * 0.5, 0), XXBPushTransitionScalSize, XXBPushTransitionScalSize);
            [UIView animateWithDuration:duration animations:^{
                fromView.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(toView.bounds), 0);
                toView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                fromView.transform = CGAffineTransformIdentity;
                toView.transform = CGAffineTransformIdentity;
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
            
            break;
        }
            
        default:
            break;
    }
}

@end
