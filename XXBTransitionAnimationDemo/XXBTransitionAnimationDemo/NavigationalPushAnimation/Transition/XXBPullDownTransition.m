//
//  XXBPullDownTransition.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing5 on 2018/12/12.
//  Copyright © 2018 xiaobing. All rights reserved.
//

#import "XXBPullDownTransition.h"

@implementation XXBPullDownTransition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
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
            toView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(fromView.frame));
            [UIView animateWithDuration:duration animations:^{
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
            toView.transform = CGAffineTransformMakeTranslation(0, 0);
            [UIView animateWithDuration:duration animations:^{
                fromView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(fromView.frame));
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
