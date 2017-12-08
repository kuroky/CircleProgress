//
//  ProgressCell.m
//  CircleDemo
//
//  Created by kuroky on 2017/12/6.
//  Copyright © 2017年 kuroky. All rights reserved.
//

#import "ProgressCell.h"

static CGFloat const kLineWidth =   12.0;

@interface ProgressCell ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation ProgressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CGFloat progressWidth = [UIScreen mainScreen].bounds.size.width - 20;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(5, kLineWidth * 0.5)];
    [path addLineToPoint:CGPointMake(progressWidth - 10, kLineWidth * 0.5)];
    
    CAShapeLayer *backLayer = [CAShapeLayer layer];
    backLayer.fillColor = [UIColor clearColor].CGColor;
    backLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    backLayer.path = path.CGPath;
    backLayer.frame = CGRectMake(0, 0, progressWidth - 10, 12);
    backLayer.lineJoin = kCALineJoinRound;
    backLayer.lineCap = kCALineCapRound;
    backLayer.lineWidth = kLineWidth;
    backLayer.strokeEnd = 1.0;
    [self.containerView.layer addSublayer:backLayer];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.path = path.CGPath;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = kLineWidth;
    backLayer.frame = CGRectMake(0, 0, (progressWidth - 10)* 0.5, 12);
    shapeLayer.strokeEnd = 0.5;
    
    UIColor *strokeColor = [UIColor redColor];
    UIColor *startColor = [UIColor yellowColor];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.frame = CGRectMake(0, 0, (progressWidth - 10) * 0.5, kLineWidth);
    UIColor *endColor = strokeColor;
    NSArray *colors = @[(id)endColor.CGColor, (id)startColor.CGColor];
    gradientLayer.colors = colors;
    
    CALayer *colorLayer = [CALayer layer];
    [colorLayer addSublayer:gradientLayer];
    colorLayer.mask = shapeLayer;
    [self.containerView.layer addSublayer:colorLayer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
