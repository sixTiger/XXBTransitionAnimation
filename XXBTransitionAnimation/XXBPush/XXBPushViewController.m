//
//  XXBPushViewController.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing on 2018/2/27.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBPushViewController.h"
#import "XXBPushSecondViewController.h"

@interface XXBPushViewController ()

@end

@implementation XXBPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self initNavi];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initNavi {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(goToNextController)];
}

- (void)initView {
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:@"test"];
    [self.view addSubview:imageView];
    imageView.center = self.view.center;
}

- (void)goToNextController {
    UIView *snapshotView = [self.tabBarController.view snapshotViewAfterScreenUpdates:NO];
    XXBPushSecondViewController *controller = [[XXBPushSecondViewController alloc] init];
    controller.bgView = snapshotView;
    controller.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
