//
//  XXBTransitionShotCell.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing5 on 2018/9/13.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBTransitionShotCell.h"

@implementation XXBTransitionShotCell
- (instancetype)initWithContentView:(UIView *)contentView andFrame:(CGRect)frame andContentViewFrame:(CGRect)contentFrame {
    if (self = [super init]) {
        [self addSubview:contentView];
        contentView.frame = contentFrame;
        self.clipsToBounds = YES;
        self.frame = frame;
    }
    return self;
}

@end
