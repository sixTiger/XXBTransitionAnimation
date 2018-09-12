//
//  TransitionModel.h
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing5 on 2018/9/12.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXBTransitionModel : NSObject

/**
 标题
 */
@property(nonatomic, copy) NSString     *title;

/**
 转场动画的类
 */
@property(nonatomic, strong) Class      transition;

@end
