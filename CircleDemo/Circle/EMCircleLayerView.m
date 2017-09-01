//
//  EMCircleLayerView.m
//  Emucoo
//
//  Created by kuroky on 2017/7/26.
//  Copyright © 2017年 Emucoo. All rights reserved.
//

#import "EMCircleLayerView.h"
#import "EMTool.h"

static CGFloat const kDefautlDuration = 5.0;

@interface EMCircleLayerView () <CAAnimationDelegate> {
    
    NSTimer *_timer;
}

@property (nonatomic, strong) UIBezierPath *circlePath;
@property (nonatomic, strong) CAShapeLayer *progressLayer; // 进度条
@property (strong, nonatomic) CAGradientLayer *gradientLayer; // 渐变色
@property (nonatomic, assign) CGFloat strokeWidth; // 进度条宽度
@property (strong, nonatomic) UIImageView *dotImageView; // 小圆点
@property (assign, nonatomic) CGFloat circleRadius; // 弧度半径
@property (assign, nonatomic, readwrite) BOOL isAnimation;
@property (assign, nonatomic) CGFloat startAngle; // 起始度数
@property (assign, nonatomic) CGPoint arcCenter;
@property (assign, nonatomic) CGFloat lastAngle; // 最后一次度数
@property (assign, nonatomic) CGFloat deltaAngle; // 相差度数

@end

@implementation EMCircleLayerView

- (instancetype)initWithFrame:(CGRect)frame
                  strokeWidth:(CGFloat)strokeWidth
                   startAngle:(CGFloat)startAngle
                  rotateAngle:(CGFloat)rotateAngle {
    if (self = [super initWithFrame:frame]) {
        self.strokeWidth = strokeWidth;
        CGFloat start = M_PI_2 + startAngle / 180.0 * M_PI;
        CGFloat rotate = (rotateAngle/ 180.0) * M_PI + start;
        self.lastAngle = startAngle;
        self.startAngle = startAngle;
        self.deltaAngle = rotateAngle;
        self.arcCenter = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
        self.circleRadius = CGRectGetMidX(self.bounds) - strokeWidth * 0.5;
        self.circlePath = [UIBezierPath bezierPathWithArcCenter:self.arcCenter
                                                         radius:self.circleRadius
                                                     startAngle:start
                                                       endAngle:rotate
                                                      clockwise:YES];
        [self addProgressLayer];
    }
    return self;
}

- (void)strokeCircle:(CGFloat)progress {
    self.isAnimation = YES;
    if (self.startColor && self.strokeColor) {
        if (!self.gradientLayer) {
            self.gradientLayer = [CAGradientLayer layer];
            self.gradientLayer.startPoint = CGPointMake(0, 1);
            self.gradientLayer.endPoint = CGPointMake(1, 1);
            self.gradientLayer.frame = self.bounds;
            NSArray *colors = @[(id)self.startColor.CGColor, (id)self.strokeColor.CGColor];
            self.gradientLayer.colors = colors;            
            [self.gradientLayer setMask:self.progressLayer];
            [self.layer addSublayer:self.gradientLayer];
        }
    }
    if (progress == 0) {
        progress = 0.001;
    }
    
    if (progress > 1) {
        progress = 1;
    }
    
    CGFloat duration = self.duration > 0 ? self.duration : kDefautlDuration;
    CGFloat newAngle = progress * self.deltaAngle;
    CGFloat delta = fabs(newAngle + self.startAngle - self.lastAngle) / self.deltaAngle;
    CABasicAnimation *strokeEndAnimation = nil;
    strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = duration * delta;
    strokeEndAnimation.fromValue = @(self.progressLayer.strokeEnd);
    strokeEndAnimation.toValue = @(progress);
    strokeEndAnimation.delegate = self;
    strokeEndAnimation.autoreverses = NO;
    strokeEndAnimation.repeatCount = 0.f;
    self.progressLayer.strokeEnd = progress;
    [self.progressLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation"];
    [self bringSubviewToFront:self.dotImageView];
    [self dotImageAnimation:newAngle
              totalDuration:duration * delta];
}

- (void)dotImageAnimation:(CGFloat)newAngle
            totalDuration:(CGFloat)duration {
    BOOL clockwise = YES;
    if (newAngle + self.startAngle > self.lastAngle) {
        clockwise = YES;
    }
    else {
        clockwise = NO;
    }
    CGFloat start = M_PI_2 + self.lastAngle / 180.0 * M_PI;
    CGFloat endAngle = ((newAngle + self.startAngle)/ 180.0) * M_PI + M_PI_2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter
                                                        radius:self.circleRadius
                                                    startAngle:start
                                                      endAngle:endAngle
                                                     clockwise:clockwise];
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = path.CGPath;
    moveAnim.duration = duration;
    moveAnim.fillMode = kCAFillModeForwards;
    moveAnim.calculationMode = kCAAnimationPaced;
    moveAnim.removedOnCompletion = NO;
    moveAnim.delegate = self;
    [self.dotImageView.layer addAnimation:moveAnim forKey:nil];
    
    self.lastAngle = newAngle + self.startAngle;
}

- (void)stopCircleAnimation {
    [self.progressLayer removeAllAnimations];
}

#pragma mark - progressLayer
- (void)addProgressLayer {
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.path = self.circlePath.CGPath;
    self.progressLayer.strokeColor = [[UIColor whiteColor] CGColor];
    self.progressLayer.fillColor = [[UIColor clearColor] CGColor];
    self.progressLayer.lineWidth = self.strokeWidth;
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.strokeEnd = 0.001f;
    self.progressLayer.shadowColor = [UIColor blackColor].CGColor;
    self.progressLayer.shadowRadius = 1.0;
    self.progressLayer.shadowOffset = CGSizeMake(2, 2);
    self.progressLayer.shadowOpacity = 0.08;
    
    [self.layer addSublayer:self.progressLayer];
}

- (void)setDotImageName:(NSString *)dotImageName {
    if (!dotImageName) {
        return;
    }
    
    UIImage *image = [UIImage imageNamed:dotImageName];
    if (!image) {
        return;
    }
    self.dotImageView = [[UIImageView alloc] init];
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    self.dotImageView.frame = rect;
    self.dotImageView.image = image;
    [self addSubview:self.dotImageView];
    
    CGFloat start = self.startAngle;
    if (start <= 180) {
        start = -start;
    }
    else {
        start = 360 - start;
    }
    self.dotImageView.center = [EMTool em_coordinateWithCenter:self.arcCenter
                                                withStartAngle:start
                                                  andWithAngle:0
                                                 andWithRadius:self.circleRadius
                                                     clockwise:YES];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
}

@end
