//
//  CircleCell.m
//  CircleDemo
//
//  Created by kuroky on 2017/12/6.
//  Copyright © 2017年 kuroky. All rights reserved.
//

#import "CircleCell.h"

static CGFloat const kCircleWidth   =   40;

@interface CircleCell ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation CircleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGRect circleRect = CGRectMake(0, 0, kCircleWidth, kCircleWidth);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kCircleWidth * 0.5, kCircleWidth * 0.5)
                                                 radius:kCircleWidth * 0.5 - 2.0
                                             startAngle:M_PI_4 * 3
                                               endAngle:M_PI_4
                                              clockwise:YES];
    
    CAShapeLayer *backLayer = [CAShapeLayer layer];
    backLayer.path = bezierPath.CGPath;
    backLayer.strokeColor = [[UIColor lightGrayColor] CGColor];
    backLayer.fillColor = [[UIColor clearColor] CGColor];
    backLayer.lineWidth = 2.0;
    backLayer.lineJoin = kCALineJoinRound;
    backLayer.lineCap = kCALineCapRound;
    backLayer.frame = circleRect;
    backLayer.strokeEnd = 1.0;
    [self.containerView.layer addSublayer:backLayer];
    
    UIColor *strokeColor = [UIColor redColor];
    UIColor *startColor = [UIColor yellowColor];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(0.5, 1);
    gradientLayer.endPoint = CGPointMake(0.5, 0);
    gradientLayer.frame = circleRect;
    UIColor *endColor = strokeColor;
    NSArray *colors = @[(id)endColor.CGColor, (id)startColor.CGColor];
    gradientLayer.colors = colors;
    
    CALayer *colorLayer = [CALayer layer];
    [colorLayer addSublayer:gradientLayer];
    [self.containerView.layer addSublayer:colorLayer];
    
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    progressLayer.path = bezierPath.CGPath;
    progressLayer.strokeColor = [[UIColor whiteColor] CGColor];
    progressLayer.fillColor = [[UIColor clearColor] CGColor];
    progressLayer.lineWidth = 3.0;
    progressLayer.lineJoin = kCALineJoinRound;
    progressLayer.lineCap = kCALineCapRound;
    progressLayer.strokeEnd = 0;
    progressLayer.frame = circleRect;
    colorLayer.mask = progressLayer;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        progressLayer.strokeEnd = 0.5;
    });
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
