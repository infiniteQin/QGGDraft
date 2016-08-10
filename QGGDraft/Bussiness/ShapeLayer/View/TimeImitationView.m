//
//  TimeImitationView.m
//  QGGDraft
//
//  Created by taizi on 16/4/11.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "TimeImitationView.h"

@interface TimeImitationView ()
@property (nonatomic, strong) CAShapeLayer *footerLayer;
@property (nonatomic, strong) UIButton *buyBtn;
@property (nonatomic, strong) UILabel  *label;
@end

@implementation TimeImitationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupContainers];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContainers];
    }
    return self;
}

-(void)awakeFromNib {
    [self setupContainers];
}

- (void)setupContainers{
    [self setUpBlurView];
    [self setUpFooterLayer];
    [self setUpBuyButton];
    [self setUpLabel];
}

- (void)setUpFooterLayer {
    _footerLayer = [CAShapeLayer layer];
    _footerLayer.path = [self shapePath].CGPath;
    
    [self.layer addSublayer:_footerLayer];
}

- (void)setUpBuyButton {
    _buyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    _buyBtn.backgroundColor = [UIColor orangeColor];
    _buyBtn.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    [_buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    _buyBtn.layer.cornerRadius = 15;
    [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_buyBtn];
    
}

- (void)setUpBlurView {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = self.bounds;
    [self addSubview:effectView];
}

- (void)setUpLabel {
    _label = [UILabel new];
    _label.text = @"默认叔叔的车别乱坐";
    _label.textColor = [UIColor orangeColor];
    _label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    [self addSubview:_label];
}



-(void)layoutSublayersOfLayer:(CALayer *)layer {
    self.footerLayer.path = [self shapePath].CGPath;
    self.footerLayer.fillColor = self.footerBackgroundColor.CGColor;
    
    [super layoutSublayersOfLayer:layer];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.buyBtn.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)-self.footerLayerHeight-20);
    [self.label sizeToFit];
    self.label.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetMaxY(self.buyBtn.frame)+CGRectGetHeight(self.buyBtn.frame)/2);
}

- (UIBezierPath*)shapePath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, CGRectGetHeight(self.bounds)-self.footerLayerHeight)];
    [path addLineToPoint:CGPointMake(0, CGRectGetHeight(self.bounds))];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-self.footerLayerHeight)];
    [path addQuadCurveToPoint:CGPointMake(0, CGRectGetHeight(self.bounds)-self.footerLayerHeight)
                 controlPoint:CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)-self.footerLayerHeight-40)];
    return path;
}

@end
