//
//  QGGLoadingView.m
//  QGGDraft
//
//  Created by taizi on 16/2/23.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "QGGLoadingView.h"

#define kStockEndAnimation @"StockEndAnimatioin"
#define kZRotationAnimation @"ZRotationAnimation"
@implementation QGGLoadingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(frame)/2., CGRectGetHeight(frame)/2.);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:CGRectGetWidth(frame)/2 startAngle:0 endAngle:2*M_PI clockwise:YES];
        shapeLayer.path = path.CGPath;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        
        shapeLayer.strokeColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1].CGColor;
        shapeLayer.lineWidth = 5;
        [self.layer addSublayer:shapeLayer];
       
        
        CABasicAnimation *stockEndAnimatioin = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        stockEndAnimatioin.fromValue = @(0.);
        stockEndAnimatioin.toValue = @(1.);
        stockEndAnimatioin.duration = 3;
        stockEndAnimatioin.autoreverses = YES;
        stockEndAnimatioin.repeatCount = MAXFLOAT;
        stockEndAnimatioin.timingFunction = UIViewAnimationOptionCurveEaseInOut;
        [shapeLayer addAnimation:stockEndAnimatioin forKey:kStockEndAnimation];
//
        CABasicAnimation *zRotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//        stockEndAnimatioin.fromValue = @(0.);
        zRotationAnimation.toValue = @(-M_PI*2);
        zRotationAnimation.duration = 1.;
        zRotationAnimation.repeatCount = MAXFLOAT;
        zRotationAnimation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
        [self.layer addAnimation:zRotationAnimation forKey:kZRotationAnimation];
    }
    return self;
}

@end
