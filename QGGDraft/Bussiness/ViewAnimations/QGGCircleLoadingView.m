//
//  QGGCircleLoadingView.m
//  QGGDraft
//
//  Created by taizi on 16/2/28.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "QGGCircleLoadingView.h"

static CGFloat const kCircleWidth = 8;
static NSUInteger const kNumOfCircle = 14;
static NSTimeInterval const kAnimationDuration = 1.;
@implementation QGGCircleLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
        replicatorLayer.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetWidth(frame));
        replicatorLayer.instanceCount = kNumOfCircle;
        CGFloat angle = 2*M_PI / kNumOfCircle;
        replicatorLayer.instanceTransform = CATransform3DRotate(CATransform3DIdentity, angle, 0, 0, 1);
//        replicatorLayer.instanceGreenOffset = 0.3;
//        replicatorLayer.instanceRedOffset = 0.2;
//        replicatorLayer.instanceColor = [UIColor colorWithRed:0.2 green:0.5 blue:0.1 alpha:1].CGColor;
        replicatorLayer.instanceDelay = kAnimationDuration/kNumOfCircle;
        
        [self.layer addSublayer:replicatorLayer];
        
        CALayer *circleLayer = [CALayer layer];
        circleLayer.backgroundColor = [UIColor whiteColor].CGColor;
        circleLayer.cornerRadius = kCircleWidth/2.;
        circleLayer.frame = CGRectMake(CGRectGetWidth(frame)/2., 0, kCircleWidth, kCircleWidth);
        [replicatorLayer addSublayer:circleLayer];
        circleLayer.transform = CATransform3DScale(CATransform3DIdentity, 0.01, 0.01, 0.01);
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = @(1);
        scaleAnimation.toValue = @(0.01);
        scaleAnimation.duration = kAnimationDuration;
        scaleAnimation.repeatCount = HUGE;
//        scaleAnimation.autoreverses = YES;
        scaleAnimation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
        [circleLayer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
        
//        CABasicAnimation *zRotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//        //        stockEndAnimatioin.fromValue = @(0.);
//        zRotationAnimation.toValue = @(M_PI*2);
//        zRotationAnimation.duration = kAnimationDuration*2;
//        zRotationAnimation.repeatCount = MAXFLOAT;
////        zRotationAnimation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
//        [replicatorLayer addAnimation:zRotationAnimation forKey:nil];
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
