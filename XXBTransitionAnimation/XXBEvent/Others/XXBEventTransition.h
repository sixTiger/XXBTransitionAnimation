//
//  XXBEventTransition.h
//  XXBEventList
//
//  Created by baidu on 16/7/27.
//  Copyright © 2016年 com.baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XXBEventTransition : NSObject<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>

- (void)eventTransitionWithSelectCell:(UICollectionViewCell *)selectCell visiableCell:(NSArray *)visibleCells originFrame:(CGRect)originFrame finalFrame:(CGRect)finalFrame panController:(UIViewController *)panController listViewController:(UIViewController *)listViewController;
@end
