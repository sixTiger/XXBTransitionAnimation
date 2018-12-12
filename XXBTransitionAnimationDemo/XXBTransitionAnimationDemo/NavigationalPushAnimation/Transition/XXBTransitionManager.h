//
//  XXBTransitionManager.h
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing5 on 2018/9/12.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XXBTransitionModel.h"

@interface XXBTransitionManager : NSObject <UINavigationControllerDelegate>

@property(nonatomic, strong) XXBTransitionModel     *transitionModel;


/**
 是否允许使用下拉关闭手势
 */
@property(nonatomic, assign) BOOL                   enablePullDownGesture;
@end
