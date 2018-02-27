//
//  XXBEventViewController.m
//  XXBEventList
//
//  Created by baidu on 16/7/27.
//  Copyright © 2016年 com.baidu. All rights reserved.
//

#import "XXBEventViewController.h"
#import "XXBEventLayout.h"
#import "XXBEventCell.h"
#import <XXBLibs.h>
#import "XXBEventTransition.h"
#import "XXBDescribeViewController.h"

@interface XXBEventViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    XXBEventLayout         *eventLayout;
    UICollectionView       *eventCollectionView;
}
@property(nonatomic ,strong) XXBEventTransition *eventTransition;
@end

@implementation XXBEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initCollectionView {
    self.view.backgroundColor = [UIColor myRandomColor];
    eventLayout = [[XXBEventLayout alloc] init];
    eventCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:eventLayout];
    [self.view addSubview:eventCollectionView];
    eventCollectionView.autoresizingMask = (1 << 6) - 1;
    eventCollectionView.delegate = self;
    eventCollectionView.dataSource = self;
    [eventCollectionView registerClass:[XXBEventCell class] forCellWithReuseIdentifier:@"XXBEventCell"];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 20;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XXBEventCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XXBEventCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor myRandomColor];
    cell.messageLabel.text = [NSString stringWithFormat:@"node > %@",@(indexPath.section)];
    cell.tag = indexPath.section;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XXBEventCell *cell = (XXBEventCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSArray *visibleCells = [collectionView visibleCells];
    XXBDescribeViewController *viewController = [[XXBDescribeViewController alloc] init];
    viewController.titleLabel.text = cell.messageLabel.text;
    
    CGRect finalFrame = CGRectMake(10, collectionView.contentOffset.y + 10, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.height - 40);
    [self.eventTransition eventTransitionWithSelectCell:cell visiableCell:visibleCells originFrame:cell.frame finalFrame:finalFrame panController:viewController listViewController:self];
    viewController.transitioningDelegate = self.eventTransition;
    [self presentViewController:viewController animated:YES completion:^{
        
    }];
}



#pragma mark - layzLoad

- (XXBEventTransition *)eventTransition {
    if (_eventTransition == nil) {
        _eventTransition = [[XXBEventTransition alloc] init];
    }
    return _eventTransition;
}
@end
