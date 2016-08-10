//
//  UIView+QGGDrag.m
//  QGGDraft
//
//  Created by taizi on 16/3/28.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "UIView+QGGDrag.h"
#import <objc/runtime.h>

#define QGG_RADIUS (MIN(CGRectGetWidth(self.bounds),CGRectGetHeight(self.bounds))/2.)

static  char * const kQggDragMaxDistanceAssKey;
static  char * const kQggShapeLayerAssKey;
static  char * const kQggSmallViewWidthAssKey;
static  char * const kQggSmallCircleViewAssKey;
static  char * const kQggDidEndPanGesAssKey;

@implementation UIView (QGGDrag)

-(void)setQggDrag_maxDistance:(CGFloat)qggDrag_maxDistance {
    objc_setAssociatedObject(self, &kQggDragMaxDistanceAssKey, @(qggDrag_maxDistance), OBJC_ASSOCIATION_ASSIGN);
}

-(CGFloat)qggDrag_maxDistance {
    return [objc_getAssociatedObject(self, &kQggDragMaxDistanceAssKey) floatValue];
}

- (void)setQgg_didEndPanGesBlock:(QGGDragDidEndPanGesBlock)qgg_didEndPanGesBlock {
    objc_setAssociatedObject(self, &kQggDidEndPanGesAssKey, qgg_didEndPanGesBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(QGGDragDidEndPanGesBlock)qgg_didEndPanGesBlock {
    return objc_getAssociatedObject(self, &kQggDidEndPanGesAssKey);
}

-(void)setQgg_smallViewWidth:(CGFloat)qgg_smallViewWidth {
    objc_setAssociatedObject(self, &kQggSmallViewWidthAssKey, @(qgg_smallViewWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)qgg_smallViewWidth {
    return [objc_getAssociatedObject(self, &kQggSmallViewWidthAssKey) floatValue];
}

- (CAShapeLayer *)qgg_shapeLayer
{
    CAShapeLayer *_qgg_shapeLayer = objc_getAssociatedObject(self,&kQggShapeLayerAssKey);
    if (!_qgg_shapeLayer) {
        _qgg_shapeLayer = [CAShapeLayer layer];
        
        objc_setAssociatedObject(self, &kQggShapeLayerAssKey, _qgg_shapeLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return _qgg_shapeLayer;
}


- (void)qgg_setUp {
    CGFloat radius = QGG_RADIUS;
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    [self qgg_smallCircleView].center = self.center;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(qgg_pan:)];
    [self addGestureRecognizer:pan];
    
}

- (void)qgg_pan:(UIPanGestureRecognizer*)panGes {
    
    if (![self.superview.subviews containsObject:self.qgg_smallCircleView]) {
        [self.superview insertSubview:self.qgg_smallCircleView belowSubview:self];
    }
    if (!self.qgg_smallCircleView.hidden && ![self.superview.layer.sublayers containsObject:self.qgg_shapeLayer]) {
        self.qgg_shapeLayer.fillColor = self.backgroundColor.CGColor;
        [self.superview.layer insertSublayer:self.qgg_shapeLayer below:self.layer];
    }
    
    //移动视图
    CGPoint panPoint = [panGes translationInView:self];
    CGPoint changeCenter = self.center;
    changeCenter.x += panPoint.x;
    changeCenter.y += panPoint.y;
    self.center = changeCenter;
    
    [panGes setTranslation:CGPointZero inView:self];
    
    //两个圆中心点之间的距离
    CGFloat dist = [self qgg_distanceWithPointA:self.center toPointB:self.qgg_smallCircleView.center];
    
    if (dist > 0 && dist < self.qggDrag_maxDistance) {//
        if (!self.qgg_smallCircleView.hidden) {
            //缩放smallview
 
            CGFloat cornerRadius = (QGG_RADIUS);
            CGFloat samllCrecleRadius = cornerRadius - dist / 20;
            self.qgg_smallCircleView.bounds = CGRectMake(0, 0, samllCrecleRadius * (2 - 0.5), samllCrecleRadius * (2 - 0.5));
            self.qgg_smallCircleView.layer.cornerRadius = self.qgg_smallCircleView.bounds.size.width / 2;
            if (!self.qgg_smallCircleView.hidden) {
                
                self.qgg_shapeLayer.path = [self qgg_pathWithBigCirCleView:self smallCirCleView:self.qgg_smallCircleView].CGPath;
                
            }
        }
    }else {
        [self.qgg_shapeLayer removeFromSuperlayer];
        self.qgg_smallCircleView.hidden = YES;
    }
    
    if (panGes.state == UIGestureRecognizerStateEnded) {
        
        if (dist > self.qggDrag_maxDistance) {
            
            //播放销毁动画
            //                [self startDestroyAnimations];
            //                //销毁全部控件
//            [self releaseAll];
            [self.qgg_smallCircleView removeFromSuperview];
            [self.qgg_shapeLayer removeFromSuperlayer];
            if (self.qgg_didEndPanGesBlock) {
                self.qgg_didEndPanGesBlock();
            }
            //
        } else {
//            self.qgg_shapeLayer.hidden = YES;
            
            
            [self.qgg_shapeLayer removeFromSuperlayer];
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.center = self.qgg_smallCircleView.center;
            } completion:^(BOOL finished) {
                
                self.qgg_smallCircleView.hidden = NO;
            }];
        }
    }

}

#pragma mark - 不规则路径
- (UIBezierPath *)qgg_pathWithBigCirCleView:(UIView *)bigCirCleView  smallCirCleView:(UIView *)smallCirCleView
{
    CGPoint bigCenter = bigCirCleView.center;
    CGFloat x2 = bigCenter.x;
    CGFloat y2 = bigCenter.y;
    CGFloat r2 = bigCirCleView.bounds.size.width / 2;
    
    CGPoint smallCenter = smallCirCleView.center;
    CGFloat x1 = smallCenter.x;
    CGFloat y1 = smallCenter.y;
    CGFloat r1 = smallCirCleView.bounds.size.width / 2;
    
    // 获取圆心距离
    CGFloat d = [self qgg_distanceWithPointA:self.qgg_smallCircleView.center toPointB:self.center];
    CGFloat sinθ = (x2 - x1) / d;
    CGFloat cosθ = (y2 - y1) / d;
    
    // 坐标系基于父控件
    CGPoint pointA = CGPointMake(x1 - r1 * cosθ , y1 + r1 * sinθ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosθ , y1 - r1 * sinθ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosθ , y2 - r2 * sinθ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosθ , y2 + r2 * sinθ);
    CGPoint pointO = CGPointMake(pointA.x + d / 2 * sinθ , pointA.y + d / 2 * cosθ);
    CGPoint pointP = CGPointMake(pointB.x + d / 2 * sinθ , pointB.y + d / 2 * cosθ);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    // A
    [path moveToPoint:pointA];
    // AB
    [path addLineToPoint:pointB];
    // 绘制BC曲线
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    // CD
    [path addLineToPoint:pointD];
    // 绘制DA曲线
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    
    return path;
}


/**
 *  两点间的距离
 *
 *  @param pointA
 *  @param pointB
 *
 *  @return
 */
- (CGFloat)qgg_distanceWithPointA:(CGPoint)pointA toPointB:(CGPoint)pointB{
    CGFloat offestX = pointA.x - pointB.x;
    CGFloat offestY = pointA.y - pointB.y;
    CGFloat distance = sqrtf(offestX * offestX + offestY * offestY);
    
    return distance;
}


- (UIView *)qgg_smallCircleView {
    UIView *_qgg_smallCircleView = objc_getAssociatedObject(self,&kQggSmallCircleViewAssKey);
    if (!_qgg_smallCircleView || ![_qgg_smallCircleView isKindOfClass:[UIView class]]) {
        _qgg_smallCircleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.qgg_smallViewWidth, self.qgg_smallViewWidth)];
        _qgg_smallCircleView.layer.masksToBounds = YES;
        _qgg_smallCircleView.layer.cornerRadius = self.qgg_smallViewWidth/2.;
        _qgg_smallCircleView.backgroundColor = self.backgroundColor;
        objc_setAssociatedObject(self, &kQggSmallCircleViewAssKey, _qgg_smallCircleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _qgg_smallCircleView;
}


@end
