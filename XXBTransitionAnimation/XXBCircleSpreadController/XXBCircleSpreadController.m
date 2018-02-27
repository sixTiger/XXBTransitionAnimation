//
//  XXBCircleSpreadController.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing on 2018/2/27.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBCircleSpreadController.h"
#import "XXBCircleSpreadPresentedController.h"

@interface XXBCircleSpreadController ()

@property (nonatomic, weak) UIButton        *button;
@end

@implementation XXBCircleSpreadController

- (void)dealloc{
    NSLog(@"XXB | %s [Line %d] %@",__func__,__LINE__,[NSThread currentThread]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic2.jpeg"]];
    [self.view addSubview:imageView];
    imageView.frame = self.view.frame;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button = button;
    [button setTitle:@"点击或\n拖动我" forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.textAlignment = 1;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor grayColor];
    button.layer.cornerRadius = 20;
    button.layer.masksToBounds = YES;
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 100, 44, 44);
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [button addGestureRecognizer:pan];
}

- (void)present {
    XXBCircleSpreadPresentedController *presentVC = [XXBCircleSpreadPresentedController new];
    [self presentViewController:presentVC animated:YES completion:nil];
}

- (CGRect)buttonFrame {
    return _button.frame;
}

- (void)pan:(UIPanGestureRecognizer *)panGesture {
    UIView *button = panGesture.view;
    CGPoint newCenter = CGPointMake([panGesture translationInView:panGesture.view].x + button.center.x , [panGesture translationInView:panGesture.view].y + button.center.y);
    button.center = newCenter;
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
}
@end
