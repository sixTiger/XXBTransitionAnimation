//
//  XXBTransitionListController.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing5 on 2018/9/12.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBTransitionListController.h"
#import "XXBTransitionModel.h"
#import "XXBTransitionCell.h"
#import "XXBTransitionToController.h"
#import "XXBTransitionManager.h"
#import "XXBScaleTransition.h"
#import "XXBPushTransition.h"

static NSString *transitionCellID = @"transitionCellID";

@interface XXBTransitionListController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak) UITableView                  *tableView;
@property(nonatomic, strong) NSMutableArray             *dataSourceArray;
@property(nonatomic, strong) XXBTransitionManager       *transitionManager;

@end

@implementation XXBTransitionListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Push 转成动效";
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView {
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:0.5];
    _transitionManager = [[XXBTransitionManager alloc] init];
    self.navigationController.delegate = self.transitionManager;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    _tableView = tableView;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.autoresizingMask = (1 << 6) - 1;
    tableView.rowHeight = 60;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[XXBTransitionCell class] forCellReuseIdentifier:transitionCellID];
}

- (void)initData {
    _dataSourceArray = [NSMutableArray array];
    XXBTransitionModel *transitionModel0 = [[XXBTransitionModel alloc] init];
    transitionModel0.title = @"默认的push动画";
    transitionModel0.transition = nil;
    
    XXBTransitionModel *transitionModel1 = [[XXBTransitionModel alloc] init];
    transitionModel1.title = @"动画-XXBScaleTransition";
    transitionModel1.transition = [XXBScaleTransition class];
    
    XXBTransitionModel *transitionModel2 = [[XXBTransitionModel alloc] init];
    transitionModel2.title = @"动画-XXBPushTransition";
    transitionModel2.transition = [XXBPushTransition class];

    [self.dataSourceArray addObject:transitionModel0];
    [self.dataSourceArray addObject:transitionModel1];
    [self.dataSourceArray addObject:transitionModel2];
    
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XXBTransitionToController *transitionToController = [[XXBTransitionToController alloc] init];
    self.transitionManager.transitionModel = self.dataSourceArray[indexPath.row];
    transitionToController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:transitionToController animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XXBTransitionCell *cell = (XXBTransitionCell *)[tableView dequeueReusableCellWithIdentifier:transitionCellID];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:0.5];
    cell.transitionModel = self.dataSourceArray[indexPath.row];
    return cell;
}

@end
