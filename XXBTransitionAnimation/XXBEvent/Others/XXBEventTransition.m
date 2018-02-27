//
//  XXBEventTransition.m
//  XXBEventList
//
//  Created by baidu on 16/7/27.
//  Copyright © 2016年 com.baidu. All rights reserved.
//

#import "XXBEventTransition.h"
#import "XXBEventCell.h"
#import <XXBLibs.h>

@interface XXBEventTransition ()

@property(nonatomic ,strong) XXBEventCell                           *selectCell;
@property(nonatomic ,strong) NSArray                                *visibleCells;
@property(nonatomic ,assign) CGRect                                 originFrame;
@property(nonatomic ,assign) CGRect                                 finalFrame;
@property(nonatomic ,strong) UIViewController                       *panViewController;
@property(nonatomic ,strong) UIViewController                       *listViewController;
@property(nonatomic ,strong) UIPercentDrivenInteractiveTransition   *interactionController;


@property(nonatomic ,assign) BOOL present;
@end

@implementation XXBEventTransition

- (void)eventTransitionWithSelectCell:(UICollectionViewCell *)selectCell visiableCell:(NSArray *)visibleCells originFrame:(CGRect)originFrame finalFrame:(CGRect)finalFrame panController:(UIViewController *)panController listViewController:(UIViewController *)listViewController {
    self.selectCell = (XXBEventCell *)selectCell;
    self.visibleCells = visibleCells;
    self.originFrame = originFrame;
    self.finalFrame = finalFrame;
    self.panViewController = panController;
    self.listViewController = listViewController;
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    pan.edges = UIRectEdgeLeft;
    [self.panViewController.view addGestureRecognizer:pan];
    self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
}



- (void)handlePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer {
    UIView *view = self.panViewController.view;
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self.panViewController dismissViewControllerAnimated:YES completion:^{
            
            }];
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
        {
            CGPoint translation = [recognizer translationInView:view];
            if (translation.x > 0) {
                [self finishInteractive];
            } else {
                [self.interactionController cancelInteractiveTransition];
                [self.listViewController presentViewController:self.panViewController animated:NO completion:^{
                    if(self.selectCell) {
                        self.selectCell.frame = self.finalFrame ;
                        [self.selectCell layoutIfNeeded];
                    }
                }];
            }
            self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
            break;
        }
            
        default:
            break;
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *nextVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.selectCell.frame = self.present ? self.originFrame : self.finalFrame;
    UIView *addView = nextVC.view;
    addView.hidden = self.present ? YES : NO;
    [[transitionContext containerView] addSubview:addView];
    [self.selectCell.messageLabel sizeToFit];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        for (UICollectionViewCell *visibleCell in self.visibleCells) {
            if (visibleCell != self.selectCell) {
                CGRect frame = visibleCell.frame;
                if (visibleCell.tag < self.selectCell.tag) {
                    CGFloat yDistance = self.originFrame.origin.y - self.finalFrame.origin.y + 30;
                    CGFloat yUpdate = self.present ? yDistance : -yDistance;
                    frame.origin.y -= yUpdate;
                }else if (visibleCell.tag > self.selectCell.tag){
                    CGFloat yDistance = CGRectGetMaxY(self.finalFrame) - CGRectGetMaxY(self.originFrame) + 30;
                    CGFloat yUpdate = self.present ? yDistance : -yDistance;
                    frame.origin.y += yUpdate;
                }
                visibleCell.frame = frame;
                visibleCell.transform = self.present ? CGAffineTransformMakeScale(0.8, 1.0):CGAffineTransformIdentity;
            }
        }
        self.selectCell.messageLabel.xxb_centerX = self.present ? self.selectCell.contentView.xxb_width * 0.5 : self.selectCell.messageLabel.xxb_width * 0.5;
        self.selectCell.messageLabel.xxb_y = 5;
        self.selectCell.messageLabel.xxb_height = self.selectCell.messageLabel.xxb_height;
        self.selectCell.frame = self.present ? self.finalFrame : self.originFrame;
        [self.selectCell layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        addView.hidden = NO;
        [transitionContext completeTransition:YES];
    }];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.present = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.present = NO;
    return self;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.interactionController;
}


- (void) finishInteractive {
    [self.interactionController finishInteractiveTransition];
//    selectCell.textView.scrollEnabled = true
}
@end
