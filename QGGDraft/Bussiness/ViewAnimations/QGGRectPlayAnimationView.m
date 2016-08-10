//
//  QGGRectPlayAnimationView.m
//  QGGDraft
//
//  Created by taizi on 16/2/28.
//  Copyright © 2016年 Qingg. All rights reserved.
//


#import "QGGRectPlayAnimationView.h"

static NSUInteger const kInstanceCount = 5;
static CGFloat    const kInterval = 10.;

@implementation QGGRectPlayAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat instanceWidth = (CGRectGetWidth(frame)-(kInstanceCount-1)*kInterval)/kInstanceCount;
        CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
        replicatorLayer.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        replicatorLayer.masksToBounds = YES;
        replicatorLayer.instanceCount = kInstanceCount;
        replicatorLayer.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, instanceWidth+kInterval, 0, 0);
        replicatorLayer.instanceGreenOffset = 0.3;
        replicatorLayer.instanceRedOffset = 0.2;
//        replicatorLayer.instanceBlueOffset = 0.1;
//        replicatorLayer.instanceAlphaOffset = 1.;
        replicatorLayer.instanceColor = [UIColor colorWithRed:0.2 green:0.5 blue:0.1 alpha:1].CGColor;
        replicatorLayer.instanceDelay = 0.1;
        [self.layer addSublayer:replicatorLayer];
        
        CALayer *rectLayer = [CALayer layer];
        rectLayer.bounds = CGRectMake(0, 10, instanceWidth, CGRectGetHeight(frame)-10);
        rectLayer.position = CGPointMake(0, CGRectGetHeight(frame)-30);
        rectLayer.backgroundColor = [UIColor whiteColor].CGColor;
        rectLayer.anchorPoint = CGPointMake(0, 0);
        [replicatorLayer addSublayer:rectLayer];
        
        CABasicAnimation *rectMoveAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
        rectMoveAnimation.toValue = @(10);
        rectMoveAnimation.repeatCount = HUGE;
        rectMoveAnimation.autoreverses = YES;
        [rectLayer addAnimation:rectMoveAnimation forKey:@"RectMoveAnimation"];
        
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
