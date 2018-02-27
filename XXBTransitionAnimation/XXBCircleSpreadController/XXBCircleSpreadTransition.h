//
//  XXBCircleSpreadTransition.h
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing on 2018/2/27.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XXBCircleSpreadTransitionType) {
    XXBCircleSpreadTransitionTypePresent = 0,
    XXBCircleSpreadTransitionTypeDismiss
};

@interface XXBCircleSpreadTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) XXBCircleSpreadTransitionType type;

+ (instancetype)transitionWithTransitionType:(XXBCircleSpreadTransitionType)type;

- (instancetype)initWithTransitionType:(XXBCircleSpreadTransitionType)type;
@end
