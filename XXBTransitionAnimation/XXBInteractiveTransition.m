//
//  XXBInteractiveTransition.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing on 2018/2/27.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBInteractiveTransition.h"

@interface XXBInteractiveTransition ()


/**
 手势方向
 */
@property (nonatomic, assign) XXBInteractiveTransitionGestureDirection  direction;

/**
 手势类型
 */
@property (nonatomic, assign) XXBInteractiveTransitionType              type;
@property (nonatomic, weak) UIViewController                            *panGestureVC;
@property(nonatomic, weak)UIPanGestureRecognizer                        *panGesture;

@end
@implementation XXBInteractiveTransition

+ (instancetype)interactiveTransitionWithTransitionType:(XXBInteractiveTransitionType)type GestureDirection:(XXBInteractiveTransitionGestureDirection)direction{
    return [[self alloc] initWithTransitionType:type GestureDirection:direction];
}

- (instancetype)initWithTransitionType:(XXBInteractiveTransitionType)type GestureDirection:(XXBInteractiveTransitionGestureDirection)direction{
    self = [super init];
    if (self) {
        _direction = direction;
        _type = type;
    }
    return self;
}

- (void)addPanGestureForViewController:(UIViewController *)viewController{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    _panGesture = panGesture;
    self.panGestureVC = viewController;
    [self.panGestureVC.view addGestureRecognizer:panGesture];
}

/**
 *  手势过渡的过程
 */
- (void)handleGesture:(UIPanGestureRecognizer *)panGesture {
    if (panGesture != self.panGesture) {
        return;
    }
    //手势百分比
    CGFloat persent = 0;
    switch (_direction) {
        case XXBInteractiveTransitionGestureDirectionLeft:
        {
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
            break;
        }
        case XXBInteractiveTransitionGestureDirectionRight:
        {
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
            break;
        }
        case XXBInteractiveTransitionGestureDirectionUp:
        {
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
            break;
        }
        case XXBInteractiveTransitionGestureDirectionDown:
        {
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
            break;
        }
    }
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            //手势开始的时候标记手势状态，并开始相应的事件
            self.interation = YES;
            [self startGesture];
            break;
        }
        case UIGestureRecognizerStateChanged:{
            {
                //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
                [self updateInteractiveTransition:persent];
                break;
            }
        }
        case UIGestureRecognizerStateEnded:
        {
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            self.interation = NO;
            if (persent > 0.5) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

- (void)startGesture {
    switch (self.type) {
        case XXBInteractiveTransitionTypePresent:
        {
            if (self.presentConifg != nil) {
                self.presentConifg();
            }
            break;
        }
        case XXBInteractiveTransitionTypeDismiss:
        {
            [self.panGestureVC dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        case XXBInteractiveTransitionTypePush:
        {
            if (self.pushConifg != nil) {
                self.pushConifg();
            }
            break;
        }
        case XXBInteractiveTransitionTypePop:
        {
            [self.panGestureVC.navigationController popViewControllerAnimated:YES];
            break;
        }
    }
}
@end
