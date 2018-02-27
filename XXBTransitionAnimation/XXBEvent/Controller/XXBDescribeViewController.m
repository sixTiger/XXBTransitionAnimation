//
//  XXBDescribeViewController.m
//  XXBEventList
//
//  Created by baidu on 16/7/27.
//  Copyright © 2016年 com.baidu. All rights reserved.
//

#import "XXBDescribeViewController.h"
#import "XXBLibs.h"

@interface XXBDescribeViewController ()

@end

@implementation XXBDescribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    NSLog(@"++++");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (_titleLabel) {
        [self.titleLabel sizeToFit];
        self.titleLabel.xxb_centerX = self.view.xxb_width * 0.5;
        self.titleLabel.xxb_y = 5;
    }
}

- (void)initView {
    self.view.backgroundColor = [UIColor myRandomColor];
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [self.view addSubview:titleLabel];
        titleLabel.backgroundColor = [UIColor redColor];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
}

@end
