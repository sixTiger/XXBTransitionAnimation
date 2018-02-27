//
//  XXBCircleSpreadPresentedController.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing on 2018/2/27.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBCircleSpreadPresentedController.h"
#import "XXBCircleSpreadController.h"
#import "XXBCircleSpreadTransition.h"
#import "XXBInteractiveTransition.h"

@interface XXBCircleSpreadPresentedController ()

@property (nonatomic, strong) XXBInteractiveTransition *interactiveTransition;
@end

@implementation XXBCircleSpreadPresentedController

- (void)dealloc{
    NSLog(@"销毁了");
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic1.jpg"]];
    [self.view addSubview:imageView];
    imageView.frame = self.view.frame;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或向下滑动dismiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 50, self.view.frame.size.width, 50);
    [self.view addSubview:button];
    self.interactiveTransition = [XXBInteractiveTransition interactiveTransitionWithTransitionType:XXBInteractiveTransitionTypeDismiss GestureDirection:XXBInteractiveTransitionGestureDirectionDown];
    [self.interactiveTransition addPanGestureForViewController:self];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [XXBCircleSpreadTransition transitionWithTransitionType:XXBCircleSpreadTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [XXBCircleSpreadTransition transitionWithTransitionType:XXBCircleSpreadTransitionTypeDismiss];
}



- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interactiveTransition.interation ? _interactiveTransition : nil;
}

@end
