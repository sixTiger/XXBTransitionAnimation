//
//  XXBTransitionManager.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing5 on 2018/9/12.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBTransitionManager.h"
#import "XXBBaseTransition.h"

@interface XXBTransitionManager()<UIGestureRecognizerDelegate>

@property(nonatomic, strong) UIPanGestureRecognizer                 *panGestureRecognizer;
@property(nonatomic, weak) UIViewController                         *fromVC;
@property(nonatomic, weak) UIViewController                         *toVC;
@property(nonatomic ,strong) UIPercentDrivenInteractiveTransition   *interactionController;
@end

@implementation XXBTransitionManager
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if(self.transitionModel) {
        if (operation == UINavigationControllerOperationPush) {
            self.fromVC = fromVC;
            self.toVC = toVC;
            [self addPanGester];
        }
        XXBBaseTransition *baseTransition = [self.transitionModel.transition new];
        baseTransition.operation = operation;
        return baseTransition;
    }
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.interactionController;
}

//处理手势
- (void)addPanGester {
    UIScreenEdgePanGestureRecognizer *panGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGestureRecognizer.delegate = self;
    [self.toVC.view addGestureRecognizer:panGestureRecognizer];
    panGestureRecognizer.edges = UIRectEdgeLeft;
    _panGestureRecognizer = panGestureRecognizer;
}


- (void)handlePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer {
    UIView *view = self.toVC.view;
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self.toVC.navigationController popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:view];
            CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
            [self.interactionController updateInteractiveTransition:d];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            CGPoint translation = [recognizer translationInView:view];
            CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
            if (d > 0.3) {
                [self.interactionController finishInteractiveTransition];
            } else {
                [self.interactionController cancelInteractiveTransition];
            }
            self.interactionController = nil;
            break;
        }
            
        default:
            break;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.panGestureRecognizer) {
        //应该控制一下手势
        return YES;
    } else {
        return YES;
    }
}
- (void)dealloc {
    NSLog(@"XXB | %s [Line %d] %@",__func__,__LINE__,[NSThread currentThread]);
}
@end
