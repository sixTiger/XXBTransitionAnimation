//
//  XXBTransitionToController.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing5 on 2018/9/12.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBTransitionToController.h"


@interface XXBTransitionToController ()
@property(nonatomic, weak) UIImageView  *imageView;

@end

@implementation XXBTransitionToController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageView];
    _imageView = imageView;
    imageView.autoresizingMask = (1 << 6) - 1;
    imageView.image = [UIImage imageNamed:@"pic1.jpg"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.clipsToBounds = YES;
}

- (void)dealloc {
    NSLog(@"XXB | %s [Line %d] %@",__func__,__LINE__,[NSThread currentThread]);
}
@end
