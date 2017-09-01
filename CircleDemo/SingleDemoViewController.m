//
//  SingleDemoViewController.m
//  CircleDemo
//
//  Created by kuroky on 2017/9/1.
//  Copyright © 2017年 kuroky. All rights reserved.
//

#import "SingleDemoViewController.h"
#import "EMCircleLayerView.h"

@interface SingleDemoViewController ()

@property (strong, nonatomic) EMCircleLayerView *circleView;

@end

@implementation SingleDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.navigationItem.title = @"Demo1";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = self.view.frame.size.width - 60;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(30, 100, width, width)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, CGRectGetMaxY(view.frame) + 40, width - 100, 40);
    [btn setTitle:@"继续" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, CGRectGetMaxY(view.frame) + 100, width - 100, 40);
    [btn setTitle:@"还原" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(didClickBtn1) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect circleRect = view.bounds;
    self.circleView = [[EMCircleLayerView alloc] initWithFrame:circleRect
                                                   strokeWidth:8.0
                                                    startAngle:45
                                                   rotateAngle:270];
    self.circleView.duration = 5.0;
    self.circleView.startColor = [UIColor redColor];
    self.circleView.strokeColor = [UIColor greenColor];
    self.circleView.dotImageName = @"task_progressDot";
    [view addSubview:self.circleView];
}

#pragma mark - Action
- (void)didClickBtn {
    NSInteger rate = (arc4random() % 80) + 20;
    [self.circleView strokeCircle:rate * 0.01];
}

- (void)didClickBtn1 {
    [self.circleView strokeCircle:0.001];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
