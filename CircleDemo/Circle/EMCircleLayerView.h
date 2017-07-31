//
//  EMCircleLayerView.h
//  Emucoo
//
//  Created by kuroky on 2017/7/26.
//  Copyright © 2017年 Emucoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMCircleLayerView : UIView

/**
 起始渐变色
 */
@property (strong, nonatomic) UIColor *startColor;

/**
 结束渐变色
 */
@property (strong, nonatomic) UIColor *strokeColor;

/**
 白点图片名称
 */
@property (copy, nonatomic) NSString *dotImageName;

/**
 动画时长
 */
@property (assign, nonatomic) CGFloat duration;

/**
 动画状态
 */
@property (assign, nonatomic, readonly) BOOL isAnimation;

/**
 EMCircleLayerView

 @param frame frame 顺时针进度圆
 @param strokeWidth 圆环宽度
 @param startAngle 起始度数 (0-360, y轴下起始0/360, x轴左90, y轴上180, x轴右270)
 @param rotateAngle 旋转度数(0-360)
 @return EMCircleLayerView
 */
- (instancetype)initWithFrame:(CGRect)frame
                  strokeWidth:(CGFloat)strokeWidth
                   startAngle:(CGFloat)startAngle
                  rotateAngle:(CGFloat)rotateAngle;

/**
 开始绘图
 */
- (void)strokeCircle:(CGFloat)progress;

/**
 结束动画
 */
- (void)stopCircleAnimation;

@end
