//
//  XXBScaleTransition.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing5 on 2018/9/12.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBScaleTransition.h"

@implementation XXBScaleTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
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
            
            [[transitionContext containerView] bringSubviewToFront:fromView];
            
            NSTimeInterval duration = [self transitionDuration:transitionContext];
            toView.alpha = 0.0;
            [UIView animateWithDuration:duration animations:^{
                fromView.alpha = 0.0;
                fromView.transform = CGAffineTransformMakeScale(0.2, 0.2);
                toView.alpha = 1.0;
                toView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                fromView.transform = CGAffineTransformIdentity;
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
            [containerView addSubview:fromView];
            [containerView addSubview:toView];
            [[transitionContext containerView] bringSubviewToFront:toView];
            toView.alpha = 0.0;
            toView.transform = CGAffineTransformMakeScale(0.2, 0.2);
            NSTimeInterval duration = [self transitionDuration:transitionContext];
            [UIView animateWithDuration:duration animations:^{
                fromView.alpha = 0.0;
                toView.alpha = 1.0;
                toView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                fromView.alpha = 1.0;
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
