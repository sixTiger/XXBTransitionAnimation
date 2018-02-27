//
//  ViewController.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing on 2018/2/27.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "ViewController.h"
#import "XXBTransitionAnimationModel.h"
#import "XXBTransitionAnimationCell.h"
#import "XXBEventViewController.h"
#import "XXBCircleSpreadController.h"
#import "XXBPushViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, weak) UITableView          *tableView;
@property(nonatomic, strong) NSMutableArray     *dataArray;
@end

@implementation ViewController

static NSString *transitionAnimationCellID = @"XXBTransitionAnimationCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initNavi];
    [self initData];
    [self initView];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNavi {
    self.title = @"转场动画效果";
}

- (void)initData {
    _dataArray = [NSMutableArray array];
    XXBTransitionAnimationModel *eventModel = [[XXBTransitionAnimationModel alloc] init];
    eventModel.titel = @"印象笔记效果";
    eventModel.contrlollerClass = [XXBEventViewController class];
    
    XXBTransitionAnimationModel *circleSpreadModel = [[XXBTransitionAnimationModel alloc] init];
    circleSpreadModel.titel = @"圆形 controller";
    circleSpreadModel.contrlollerClass = [XXBCircleSpreadController class];
    
    XXBTransitionAnimationModel *pushModel = [[XXBTransitionAnimationModel alloc] init];
    pushModel.titel = @"push controller";
    pushModel.contrlollerClass = [XXBPushViewController class];
    
    [_dataArray addObject:eventModel];
    [_dataArray addObject:circleSpreadModel];
    [_dataArray addObject:pushModel];
}

- (void)initView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.autoresizingMask = (1 << 6) - 1;
    tableView.rowHeight = 60;
    [tableView registerClass:[XXBTransitionAnimationCell class] forCellReuseIdentifier:transitionAnimationCellID];
    [self.view addSubview:tableView];
    _tableView = tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XXBTransitionAnimationCell *cell = [tableView dequeueReusableCellWithIdentifier:transitionAnimationCellID];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XXBTransitionAnimationCell *cell = (XXBTransitionAnimationCell *)[tableView cellForRowAtIndexPath:indexPath];
    XXBTransitionAnimationModel *model = cell.model;
    UIViewController *controller = [[model.contrlollerClass alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
