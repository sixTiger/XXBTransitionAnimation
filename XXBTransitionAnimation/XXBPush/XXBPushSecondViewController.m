//
//  XXBPushSecondViewController.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing on 2018/2/27.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBPushSecondViewController.h"
#import "XXBPhotoShowView.h"

@interface XXBPushSecondViewController ()

@property(nonatomic, weak) XXBPhotoShowView             *photoShowView;
@property(nonatomic, weak) UIView                       *realBGView;
@property(nonatomic, strong) UIPanGestureRecognizer     *panGesture;
@property(nonatomic, assign) CGPoint                    panStartPoint;
@end

@implementation XXBPushSecondViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self addPanGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView {
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    [self initBGView];
    
    UIView *realBGView = [[UIView alloc] initWithFrame:self.view.bounds];
    realBGView.backgroundColor = [UIColor blackColor];
    realBGView.autoresizingMask = (1 << 6) - 1;
    [self.view addSubview:realBGView];
    _realBGView = realBGView;
    
    XXBPhotoShowView *photoShowView = [[XXBPhotoShowView alloc] initWithFrame:self.view.bounds];
    photoShowView.autoresizingMask = (1 << 6) - 1;
    photoShowView.image = [UIImage imageNamed:@"test"];
    [self.view addSubview:photoShowView];
    _photoShowView = photoShowView;
}

- (void)initBGView {
    if (self.bgView) {
        [self.view insertSubview:self.bgView atIndex:0];
    }
}

- (void)addPanGesture {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:panGesture];
    _panGesture = panGesture;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer {
    UIView *view = self.view;
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint panGestureStartPoint = [recognizer translationInView:view];
            self.panStartPoint = panGestureStartPoint;
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint panGesturePoint = [recognizer translationInView:view];
            CGFloat move_x = panGesturePoint.x - self.panStartPoint.x;
            CGFloat move_Y = panGesturePoint.y - self.panStartPoint.y;
            CGPoint newCenter = CGPointMake(self.view.center.x + move_x , self.view.center.y + move_Y);
            self.photoShowView.center = newCenter;
            CGFloat alpha = 1 - fabs(move_Y) / (CGRectGetHeight(self.view.bounds) * 0.5);
            self.realBGView.alpha = alpha;
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            CGPoint panGesturePoint = [recognizer translationInView:view];
            CGFloat move_x = panGesturePoint.x - self.panStartPoint.x;
            CGFloat move_Y = panGesturePoint.y - self.panStartPoint.y;
            CGPoint newCenter = CGPointMake(self.view.center.x + move_x , self.view.center.y + move_Y);
            self.photoShowView.center = newCenter;
            CGFloat alpha = 1 - fabs(move_Y) / (CGRectGetHeight(self.view.bounds) * 0.5);
            self.realBGView.alpha = alpha;
            if (alpha < 0.6) {
                [self dismissSelf];
            } else {
                [self setToDefault];
            }
            break;
        }
            
        default:
            break;
    }
}

- (void)dismissSelf {
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.photoShowView.center = self.view.center;
        self.realBGView.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled = YES;
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

- (void)setToDefault {
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.photoShowView.center = self.view.center;
        self.realBGView.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled = YES;
    }];
}
@end
