//
//  XXBWindTransition.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing5 on 2018/9/13.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBWindTransition.h"
#import "XXBTransitionShotCell.h"

#define XXBWindTransition_Factor_x 4
#define XXBWindTransition_Animation_Time 0.5
@interface XXBWindTransition()
{
    CGFloat cellWidth;
    CGFloat cellHeight;
    int totalCount;
    int finishedCounter;
    id<UIViewControllerContextTransitioning> mtransitionContext;
}
@end

@implementation XXBWindTransition
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return XXBWindTransition_Animation_Time;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    mtransitionContext = transitionContext;
    UIViewController *toVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    UIView * fromView = fromVC.view;
    UIView * toView = toVC.view;
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    
    
    finishedCounter = 0;
    totalCount = 0;
    CGSize size = toView.frame.size;
    
    NSMutableArray *snapshotCells = [NSMutableArray new];
    
    CGFloat xFactor = XXBWindTransition_Factor_x;
    CGFloat yFactor = xFactor * size.height / size.width;
    cellWidth = size.width / xFactor;
    cellHeight = size.height / yFactor;
    
    NSInteger numPerRow = 0;
    NSInteger totalNum = 0;
    UIView *fromViewSnapshot = [fromView snapshotViewAfterScreenUpdates:NO];
    for (CGFloat y = 0; y < size.height; y += cellHeight) {
        numPerRow ++;
        for (CGFloat x = size.width - cellWidth; x >= 0; x -= cellWidth){
            totalNum ++;
            CGRect snapshotCellFrame = CGRectMake(x, y, cellWidth, cellHeight);
            CGRect snapshotFrame = CGRectMake(-x, -y, size.width, size.height);
            UIView *snapshot = [fromViewSnapshot resizableSnapshotViewFromRect:fromViewSnapshot.bounds  afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
            
            XXBTransitionShotCell *snapshotCell =  [[XXBTransitionShotCell alloc] initWithContentView:snapshot andFrame:snapshotCellFrame andContentViewFrame:snapshotFrame];
            

            [containerView addSubview:snapshotCell];
            [snapshotCells addObject:snapshotCell];
            snapshotCell.tag = totalCount;
            totalCount ++;
        }
    }
    
    [containerView sendSubviewToBack:fromView];
    
    for(int i = 0 ; i < numPerRow ; i ++){
        NSTimeInterval delay = i * 0.1f;
        for(int j = 0 ; j < totalNum/numPerRow ; j ++){
            [self performSelector:@selector(triggerFlip:) withObject:[snapshotCells objectAtIndex:(j + i * totalNum/numPerRow)] afterDelay:delay];
            delay += 0.1f;
        }
    }
}

- (void) triggerFlip : (UIView *) view
{
    CGFloat margin = cellWidth/10;
    CGRect frame = view.layer.frame;
    view.layer.frame = CGRectMake(frame.origin.x + margin, frame.origin.y + margin, frame.size.width - margin * 2, frame.size.height - margin * 2);
    [UIView animateWithDuration:[self transitionDuration:mtransitionContext] delay:0 options:0 animations:^{
        view.layer.transform = [self getTransForm3DWithAngle:-M_PI_2 offset : frame.origin.x];
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        self->finishedCounter ++;
        if(self->finishedCounter == self->totalCount){
            [self->mtransitionContext completeTransition:![self->mtransitionContext transitionWasCancelled]];
        }
    }];
}

-(CATransform3D)getTransForm3DWithAngle:(CGFloat)angle offset : (CGFloat) offset{
    CATransform3D move = CATransform3DMakeTranslation(0, 0, offset + cellWidth - [UIScreen mainScreen].bounds.size.width);
    CATransform3D back = CATransform3DMakeTranslation(0, 0, cellWidth);
    CATransform3D rotate = CATransform3DMakeRotation(angle, 0, 1, 0);
    CATransform3D mat = CATransform3DConcat(CATransform3DConcat(move, rotate), back);
    return CATransform3DPerspect(mat, CGPointZero, 500);
    
}

CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}


CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

@end
