//
//  XXBInteractiveTransition.h
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing on 2018/2/27.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XXBGestureConifg)();

typedef NS_ENUM(NSUInteger, XXBInteractiveTransitionGestureDirection) {//手势的方向
    XXBInteractiveTransitionGestureDirectionLeft = 0,
    XXBInteractiveTransitionGestureDirectionRight,
    XXBInteractiveTransitionGestureDirectionUp,
    XXBInteractiveTransitionGestureDirectionDown
};

typedef NS_ENUM(NSUInteger, XXBInteractiveTransitionType) {//手势控制哪种转场
    XXBInteractiveTransitionTypePresent = 0,
    XXBInteractiveTransitionTypeDismiss,
    XXBInteractiveTransitionTypePush,
    XXBInteractiveTransitionTypePop,
};

@interface XXBInteractiveTransition : UIPercentDrivenInteractiveTransition

/**
 记录是否开始手势，判断pop操作是手势触发还是返回键触发
 */
@property (nonatomic, assign) BOOL interation;

/**
 促发手势present的时候的config，config中初始化并present需要弹出的控制器
 */
@property (nonatomic, copy) XXBGestureConifg presentConifg;

/**
 促发手势push的时候的config，config中初始化并push需要弹出的控制器
 */
@property (nonatomic, copy) XXBGestureConifg pushConifg;

+ (instancetype)interactiveTransitionWithTransitionType:(XXBInteractiveTransitionType)type GestureDirection:(XXBInteractiveTransitionGestureDirection)direction;

- (instancetype)initWithTransitionType:(XXBInteractiveTransitionType)type GestureDirection:(XXBInteractiveTransitionGestureDirection)direction;

/**
 给传入的控制器添加手势
 */
- (void)addPanGestureForViewController:(UIViewController *)viewController;
@end
