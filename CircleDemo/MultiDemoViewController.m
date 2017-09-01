//
//  MultiDemoViewController.m
//  CircleDemo
//
//  Created by kuroky on 2017/9/1.
//  Copyright © 2017年 kuroky. All rights reserved.
//

#import "MultiDemoViewController.h"
#import "EMCircleLayerView.h"

@interface MultiDemoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel; // 指数
@property (weak, nonatomic) IBOutlet UIImageView *dot1ContainerView;
@property (weak, nonatomic) IBOutlet UIView *scoreContainerView;
@property (strong, nonatomic) EMCircleLayerView *scoreView;
@property (assign, nonatomic) NSInteger scoreIndex;

@property (weak, nonatomic) IBOutlet UILabel *rateLabel; // 得分率
@property (weak, nonatomic) IBOutlet UIView *rateContainerView;
@property (assign, nonatomic) CGFloat scoreRate;

@property (strong, nonatomic) EMCircleLayerView *rateView;

@property (weak, nonatomic) IBOutlet UILabel *pointLabel; // 总分
@property (weak, nonatomic) IBOutlet UIImageView *totalImageView;
@property (assign, nonatomic) NSInteger scorePoint;

@end

@implementation MultiDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
    [self startAnimation];
}

- (void)setupData {
    self.scoreIndex = arc4random() % 1000;
    self.scoreRate = (arc4random() % 100 + 1);
    self.scorePoint = arc4random() % 1000;
    
    self.scoreView = [[EMCircleLayerView alloc] initWithFrame:self.scoreContainerView.bounds
                                                 strokeWidth:6.0
                                                  startAngle:45
                                                 rotateAngle:270];
    [self.scoreContainerView addSubview:self.scoreView];
    
    self.scoreView.duration = 2.0;
    self.scoreView.strokeColor = [UIColor clearColor];
    self.scoreView.startColor = [UIColor clearColor];
    self.scoreView.dotImageName = @"profile_scoreRateDot";
    
    self.rateView = [[EMCircleLayerView alloc] initWithFrame:self.rateContainerView.bounds
                                                 strokeWidth:6.0
                                                  startAngle:45
                                                 rotateAngle:270];
    [self.rateContainerView addSubview:self.rateView];
    
    self.rateView.duration = 2.0;
    self.rateView.strokeColor = [UIColor orangeColor];
    self.rateView.startColor = [UIColor redColor];
    self.rateView.dotImageName = @"profile_rateDot";
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Demo2";
}

- (void)startAnimation {
    self.scoreLabel.text = @(self.scoreIndex).stringValue;
    [self.scoreView strokeCircle:self.scoreIndex * 0.001];
    
    self.rateLabel.text = [NSString stringWithFormat:@"%.f %%", self.scoreRate];
    [self.rateView strokeCircle:self.scoreRate * 0.01];
    
    self.pointLabel.text = @(self.scorePoint).stringValue;
    [self totalViewCircleLoop];
}

- (void)totalViewCircleLoop {
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat:M_PI *2];
    animation.duration  = 1.0;                  //一次时间
    animation.autoreverses = NO;                         //是否自动回倒
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;           //设置进入后台动画不停止
    animation.repeatCount = 1;            //重复次数
    [self.totalImageView.layer addAnimation:animation forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
