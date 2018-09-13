//
//  XXBDrawerTransition.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing5 on 2018/9/12.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBDrawerTransition.h"
#import "XXBTransitionShotCell.h"

#define XXBDrawerTransition_Factor_x 8
#define XXBDrawerTransition_Animation_Time 0.5

@interface XXBDrawerTransition()
{
    int totalCount;
    int flippedCount;
    NSInteger numPerRow;
    NSInteger totalNum;
    NSInteger randomPick;
    CGPoint pickedCenter;
    NSMutableArray *snapshotCells;
    NSMutableArray * flippedViews;
}
@end

@implementation XXBDrawerTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return XXBDrawerTransition_Animation_Time;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    UIView * fromView = fromVC.view;
    UIView * toView = toVC.view;
    if (self.operation == UINavigationControllerOperationPush) {
        [containerView addSubview:toView];
        [containerView addSubview:fromView];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    } else {
        [containerView addSubview:toView];
        [containerView addSubview:fromView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{

        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    
    
    
    totalCount = 0;
    flippedCount = 0;
    CGRect fromRect = fromView.bounds;
    CGSize size = toView.frame.size;
    
    snapshotCells = [NSMutableArray new];
    
    CGFloat xFactor = XXBDrawerTransition_Factor_x;
    CGFloat yFactor = xFactor * size.height / size.width;
    
    int rowNum = 0;
    totalNum = 0;
    CGFloat snapshotWidth = size.width;
    CGFloat snapshotHeight = size.height;
    CGFloat snapshotCellWidth = size.width / xFactor;
    CGFloat snapshotCellHeight = size.height / yFactor;
    
    UIView *fromViewSnapshot = [fromView snapshotViewAfterScreenUpdates:NO];
    for (CGFloat y = 0; y < size.height; y += snapshotCellHeight) {
        rowNum ++;
        for(CGFloat x = 0; x < size.width; x += snapshotCellWidth){
            totalNum ++;
            CGRect snapshotCellFrame = CGRectMake(x, y, snapshotCellWidth, snapshotCellHeight);
            CGRect snapshotFrame = CGRectMake(-x, -y, snapshotWidth, snapshotHeight);
            UIView *snapshot = [fromViewSnapshot resizableSnapshotViewFromRect:fromRect  afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
            XXBTransitionShotCell *snapshotCell = [[XXBTransitionShotCell alloc] initWithContentView:snapshot andFrame:snapshotCellFrame andContentViewFrame:snapshotFrame];
       
            snapshotCell.tag = (totalNum - 1);
            [containerView addSubview:snapshotCell];
            [snapshotCells addObject:snapshotCell];
            totalCount ++;
        }
    }
    numPerRow = totalNum/rowNum;
    [containerView sendSubviewToBack:fromView];
    flippedViews = [NSMutableArray new];
    randomPick = rand() % totalNum;
    UIView * pickedView = [snapshotCells objectAtIndex:randomPick];
    pickedCenter = pickedView.center;
    [pickedView removeFromSuperview];
    [flippedViews addObject:[NSNumber numberWithInteger:randomPick]];
    flippedCount = 1;
    [self triggerFlips];
}

- (void) triggerFlips
{
    NSMutableArray * addFlip = [NSMutableArray new];
    NSMutableSet * addedSet = [NSMutableSet new];
    for(NSNumber * flipped in flippedViews){
        NSInteger index = [flipped integerValue];
        if(index % numPerRow > 0){
            if(![flippedViews containsObject:[NSNumber numberWithInteger:(index-1)]]){
                if(![addedSet containsObject:[NSNumber numberWithInteger:(index-1)]]){
                    [addedSet addObject:[NSNumber numberWithInteger:(index-1)]];
                    [addFlip addObject:[snapshotCells objectAtIndex:index-1]];
                }
            }
        }
        if(index % numPerRow < (numPerRow - 1)){
            if(![flippedViews containsObject:[NSNumber numberWithInteger:(index+1)]]){
                if(![addedSet containsObject:[NSNumber numberWithInteger:(index+1)]]){
                    [addedSet addObject:[NSNumber numberWithInteger:(index+1)]];
                    [addFlip addObject:[snapshotCells objectAtIndex:index+1]];
                }
            }
        }
        if(index / numPerRow >= 1){
            if(![flippedViews containsObject:[NSNumber numberWithInteger:(index-numPerRow)]]){
                if(![addedSet containsObject:[NSNumber numberWithInteger:(index-numPerRow)]]){
                    [addedSet addObject:[NSNumber numberWithInteger:(index-numPerRow)]];
                    [addFlip addObject:[snapshotCells objectAtIndex:index-numPerRow]];
                }
            }
        }
        if(index < totalNum - numPerRow){
            if(![flippedViews containsObject:[NSNumber numberWithInteger:(index+numPerRow)]]){
                if(![addedSet containsObject:[NSNumber numberWithInteger:(index+numPerRow)]]){
                    [addedSet addObject:[NSNumber numberWithInteger:(index+numPerRow)]];
                    [addFlip addObject:[snapshotCells objectAtIndex:index+numPerRow]];
                }
            }
        }
    }
    for(UIView * added in addFlip){
        [self triggerFlip:added];
        [flippedViews addObject:[NSNumber numberWithInteger:added.tag]];
    }
    [self performSelector:@selector(triggerFlips) withObject:nil afterDelay:0.05f];
}

- (void) triggerFlip : (UIView *) view
{
    CGFloat margin = 1;
    CGRect frame = view.frame;
    view.frame = CGRectMake(frame.origin.x + margin, frame.origin.y + margin, frame.size.width - margin * 2, frame.size.height - margin * 2);
    [UIView animateWithDuration:XXBDrawerTransition_Animation_Time delay:0  usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
        view.transform = CGAffineTransformMakeTranslation(self->pickedCenter.x - view.center.x, self->pickedCenter.y - view.center.y);
        view.alpha = 0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        self->flippedCount ++;
        if(self->flippedCount == self->totalCount){
            [(UIView*)[self->snapshotCells objectAtIndex:self->randomPick] removeFromSuperview];
        }
    }];
}
@end
