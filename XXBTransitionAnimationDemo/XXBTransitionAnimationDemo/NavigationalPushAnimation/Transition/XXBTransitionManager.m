//
//  XXBTransitionManager.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing5 on 2018/9/12.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBTransitionManager.h"
#import "XXBBaseTransition.h"
#import "XXBPullDownTransition.h"

typedef enum : NSUInteger {
    XXBTransitionActionGesterNone,
    XXBTransitionActionGesterLeftPangester,
    XXBTransitionActionGesterPullDown,
} XXBTransitionActionGester;

@interface XXBTransitionManager()<UIGestureRecognizerDelegate>

/**
 策划关闭手势
 */
@property(nonatomic, strong) UIPanGestureRecognizer                 *panGestureRecognizer;
@property(nonatomic, weak) UIViewController                         *fromVC;
@property(nonatomic, weak) UIViewController                         *toVC;
@property(nonatomic ,strong) UIPercentDrivenInteractiveTransition   *interactionController;

/**
 下拉关闭手势
 */
@property(nonatomic ,strong) UIPanGestureRecognizer                 *pullDownGesture;

@property(nonatomic, assign) XXBTransitionActionGester       currentActionGester;

@end

@implementation XXBTransitionManager
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if(self.transitionModel) {
        XXBBaseTransition *baseTransition = nil;
        self.fromVC = fromVC;
        self.toVC = toVC;
        switch (operation) {
            case UINavigationControllerOperationPush:
            {
                if (self.transitionModel.enablePullDownGesture ) {
                    [self addPullDownGesture];
                }
                [self addPanGester];
                baseTransition = [self.transitionModel.transition new];
                baseTransition.operation = operation;
                break;
            }
            case UINavigationControllerOperationPop:
            {
                if (self.transitionModel.enablePullDownGesture ) {
                    switch (self.currentActionGester) {
                        case XXBTransitionActionGesterPullDown:
                        {
                            baseTransition = [XXBPullDownTransition new];
                            break;
                        }
                        case XXBTransitionActionGesterLeftPangester:
                        {
                            baseTransition = [self.transitionModel.transition new];
                            break;
                        }
                            
                        default:
                            break;
                    }
                    baseTransition.operation = operation;
                } else {
                    baseTransition = [self.transitionModel.transition new];
                }
                baseTransition.operation = operation;
                break;
            }
                
            default:
                break;
        }
        
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

- (void)addPullDownGesture {
    UIPanGestureRecognizer *pullDownGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlerPullDownGester:)];
    pullDownGesture.delegate = self;
    [self.toVC.view addGestureRecognizer:pullDownGesture];
    _pullDownGesture = pullDownGesture;
}

- (void)handlePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer {
    UIView *view = self.toVC.view;
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.currentActionGester = XXBTransitionActionGesterLeftPangester;
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
            self.currentActionGester = XXBTransitionActionGesterNone;
            break;
        }
            
        default:
            break;
    }
}

- (void)handlerPullDownGester:(UIPanGestureRecognizer *)pullDownGester {
    UIView *view = self.toVC.view;
    switch (pullDownGester.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.currentActionGester = XXBTransitionActionGesterPullDown;
            self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self.toVC.navigationController popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [pullDownGester translationInView:view];
            CGFloat d = MAX(0, translation.y / CGRectGetWidth(view.bounds));
            [self.interactionController updateInteractiveTransition:d];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            CGPoint translation = [pullDownGester translationInView:view];
            CGFloat d = MAX(0, translation.y / CGRectGetWidth(view.bounds)) ;
            if (d > 0.3) {
                [self.interactionController finishInteractiveTransition];
            } else {
                [self.interactionController cancelInteractiveTransition];
            }
            self.interactionController = nil;
            self.currentActionGester = XXBTransitionActionGesterNone;
            break;
        }
        default:
            break;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.panGestureRecognizer) {
        return YES;
    } else if (gestureRecognizer == self.pullDownGesture) {
        UIView *view = self.toVC.view;
        
        CGPoint translation = [gestureRecognizer locationInView:view];
        if (translation.x < 50) {
            return NO;
        } else {
            return YES;
        }
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}

- (void)dealloc {
    NSLog(@"XXB | %s [Line %d] %@",__func__,__LINE__,[NSThread currentThread]);
}
@end
