//
//  XXBBaseTransition.h
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing5 on 2018/9/12.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XXBBaseTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic, assign) UINavigationControllerOperation    operation;
@end
