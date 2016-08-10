//
//  QGGWaterLoadingView.m
//  QGGDraft
//
//  Created by taizi on 16/4/5.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "QGGWaterLoadingView.h"

@interface QGGWaterLoadingView()
{
    CALayer *coverLayer;
}
@property (nonatomic, strong) CAShapeLayer *waveLayer;

@end

@implementation QGGWaterLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CALayer *canvasLayer = [CALayer layer];
        canvasLayer.frame = self.bounds;
        canvasLayer.backgroundColor = [UIColor colorWithRed:0.26 green:0.72 blue:0.99 alpha:1].CGColor;
        [self.layer addSublayer:canvasLayer];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [self customShapePath].CGPath;
        canvasLayer.mask = shapeLayer;
        
        coverLayer = [CALayer layer];
        coverLayer.frame = self.bounds;
        coverLayer.position = CGPointMake(0, CGRectGetHeight(frame));
        coverLayer.anchorPoint = CGPointMake(0, 1);
        coverLayer.backgroundColor = [UIColor clearColor].CGColor;
        [canvasLayer addSublayer:coverLayer];
        
        self.waveLayer = [CAShapeLayer layer];
        self.waveLayer.frame = coverLayer.bounds;
        //设定mask为waveLayer
        self.layer.mask = self.waveLayer;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds.size.height"];
        animation.fromValue = @(0);
        animation.toValue = @(frame.size.height);
        animation.duration = 5;
        animation.repeatCount = HUGE;
        animation.removedOnCompletion = YES;
        [coverLayer addAnimation:animation forKey:nil];

        CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        
        //获得结束时的position.y值
        CGPoint position = CGPointZero;
        position.y =  frame.size.height+30;
        CABasicAnimation *panimation = [CABasicAnimation animationWithKeyPath:@"position"];
        panimation.fromValue = [NSValue valueWithCGPoint:position];
//        panimation.toValue = [NSValue valueWithCGPoint:CGPointZero];
        panimation.duration = 5.0;
        panimation.repeatCount = HUGE_VALF;
        panimation.removedOnCompletion = YES;
        [self.waveLayer addAnimation:animation forKey:nil];
        
    }
    return self;
}

- (UIBezierPath*)customShapePath {
    // W:H = 70:120
    // oval frame {1,1,52,94}
//    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    UIBezierPath* ovalPath = [UIBezierPath bezierPath];
    [ovalPath moveToPoint: CGPointMake(51, 30.53)];
    [ovalPath addCurveToPoint: CGPointMake(27, 95) controlPoint1: CGPointMake(51, 46.83) controlPoint2: CGPointMake(41.36, 95)];
    [ovalPath addCurveToPoint: CGPointMake(1, 30.53) controlPoint1: CGPointMake(12.64, 95) controlPoint2: CGPointMake(1, 46.83)];
    [ovalPath addCurveToPoint: CGPointMake(27, 1) controlPoint1: CGPointMake(1, 14.22) controlPoint2: CGPointMake(12.64, 1)];
    [ovalPath addCurveToPoint: CGPointMake(51, 30.53) controlPoint1: CGPointMake(41.36, 1) controlPoint2: CGPointMake(51, 14.22)];
    [ovalPath closePath];
    return ovalPath;
}

static CGFloat phase = 0;
static CGFloat phaseShift = 0.2;
- (void)update {
    CGRect frame = self.frame;
    
    phase += phaseShift;
    UIGraphicsBeginImageContext(frame.size);
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    //用UIBezierPath画一个闭合的路径
    CGFloat endX = 0;
    for(CGFloat x = 0; x < frame.size.width ; x += 1) {
        endX=x;
        //正弦函数，求y值
        CGFloat y = 5 * sinf(2 * M_PI *(x / frame.size.width)  + phase)+5;
        if (x==0) {
            [wavePath moveToPoint:CGPointMake(x, y)];
        }else {
            [wavePath addLineToPoint:CGPointMake(x, y)];
        }
    }
    CGFloat endY = CGRectGetHeight(frame);
    [wavePath addLineToPoint:CGPointMake(endX, endY)];
    [wavePath addLineToPoint:CGPointMake(0, endY)];
    //修改每桢的wavelayer.path
    self.waveLayer.path = [wavePath CGPath];
    UIGraphicsEndImageContext();
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
