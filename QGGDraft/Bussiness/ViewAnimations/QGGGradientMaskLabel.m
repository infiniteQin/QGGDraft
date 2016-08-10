//
//  QGGGradientMaskLabel.m
//  QGGDraft
//
//  Created by taizi on 16/2/23.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "QGGGradientMaskLabel.h"

@implementation QGGGradientMaskLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setUpGradientMask {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    UIColor *startColor = [UIColor whiteColor];
    UIColor *endColor = [UIColor clearColor];
    gradientLayer.colors = @[(id)endColor.CGColor,(id)startColor.CGColor,(id)endColor.CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    self.layer.mask = gradientLayer;
    gradientLayer.locations = @[@0.2,@0.5,@0.8];
    
    CABasicAnimation *gradientAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
    gradientAnimation.fromValue = @[@0,@0,@0.25];
    gradientAnimation.toValue = @[@0.75,@1,@1];
    gradientAnimation.duration= 2.;
    gradientAnimation.repeatCount = HUGE;
    [gradientLayer addAnimation:gradientAnimation forKey:nil];
    
}

@end
