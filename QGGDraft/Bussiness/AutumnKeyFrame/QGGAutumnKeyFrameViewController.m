//
//  ViewController.m
//  QGGDraft
//
//  Created by taizi on 16/2/21.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "QGGAutumnKeyFrameViewController.h"

@interface QGGAutumnKeyFrameViewController ()

@property (nonatomic, strong) UILabel *summerLabel;
@property (nonatomic, strong) UILabel *autumnLabel;

@property (nonatomic, strong) UIImageView *leafImageView;

@end

@implementation QGGAutumnKeyFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self p_setUpViews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startLabelAnimation];
    [self startLeafAnimation];
}

- (void)p_setUpViews {
    UIImage *bgTreeImage = [UIImage imageNamed:@"bg_tree"];
 
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImageView.contentMode = UIViewContentModeScaleAspectFit;
    backImageView.image = bgTreeImage;
    [self.view addSubview:backImageView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.summerLabel = [[UILabel alloc] init];
    self.summerLabel.textColor = [UIColor colorWithRed:0.58 green:0.6 blue:0.29 alpha:1];
    self.summerLabel.font = [UIFont boldSystemFontOfSize:20.];
    self.summerLabel.text = @"Summer";
    [self.summerLabel sizeToFit];
    self.summerLabel.center = CGPointMake(CGRectGetWidth(self.view.bounds)/4., 400);
    
    [self.view addSubview:self.summerLabel];
    
    self.autumnLabel = [[UILabel alloc] init];
    self.autumnLabel.textColor = [UIColor colorWithRed:0.94 green:0.47 blue:0 alpha:1];
    self.autumnLabel.font = [UIFont boldSystemFontOfSize:20.];
    self.autumnLabel.text = @"Autumn";
    [self.autumnLabel sizeToFit];
    self.autumnLabel.center = self.summerLabel.center;
    self.autumnLabel.alpha = 0;
    [self.view addSubview:self.autumnLabel];
    
    self.leafImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leaf"]];
    self.leafImageView.center = CGPointMake(60, 120);
    [self.view addSubview:self.leafImageView];
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
//    view.backgroundColor = [UIColor redColor];
//    CAShapeLayer *circleLayer = [CAShapeLayer layer];
//    circleLayer.frame = CGRectMake(0, 0, 100, 100);
//    circleLayer.fillColor = [UIColor clearColor].CGColor;
//    circleLayer.strokeColor = [UIColor redColor].CGColor;
//    CALayer *layer = [CALayer layer];
//    layer.bounds = CGRectMake(0, 0, 100, 100);
//    layer.mask = circleLayer;
//    [view.layer addSublayer:layer];
    [self.view addSubview:view];
    
    CGRect myRect =CGRectMake(100,100,200, 200);
    
    int radius = myRect.size.width/2.0;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0,0, view.bounds.size.width, view.bounds.size.height) cornerRadius:0];
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100,100,2.0*radius,2.0*radius)cornerRadius:radius];
    
    [path appendPath:circlePath];
    
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    
    fillLayer.path = path.CGPath;
    
    fillLayer.fillRule =kCAFillRuleEvenOdd;
    
    fillLayer.fillColor = [UIColor grayColor].CGColor;
    
    fillLayer.opacity =0.5;
    
    [view.layer addSublayer:fillLayer];
}

- (void)startLabelAnimation {
    CGFloat offsetY = CGRectGetHeight(self.autumnLabel.bounds)/2.;
    CGAffineTransform autumnLabelTranslation = CGAffineTransformMakeTranslation(0, -offsetY);
    CGAffineTransform autumnLabelScale = CGAffineTransformMakeScale(1, 0);
    self.autumnLabel.transform = CGAffineTransformConcat(autumnLabelTranslation, autumnLabelScale);
    self.autumnLabel.alpha = 0;
    CGAffineTransform summerLabelTargetTransform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 0.1),CGAffineTransformMakeTranslation(0, offsetY));
    self.summerLabel.alpha = 1;
    [UIView animateWithDuration:3 delay:0.5 options:UIViewAnimationOptionRepeat animations:^{
        self.autumnLabel.transform = CGAffineTransformIdentity;
        self.autumnLabel.alpha = 1;
        
        self.summerLabel.transform = summerLabelTargetTransform;
        self.summerLabel.alpha = 0;

    } completion:^(BOOL finished) {
        
    }];
 
}

- (void)startLeafAnimation {
    __block CGPoint leafCenter = self.leafImageView.center;
    [UIView animateKeyframesWithDuration:3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic|UIViewKeyframeAnimationOptionRepeat animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.25 animations:^{
            self.leafImageView.center = CGPointMake(leafCenter.x+30, leafCenter.y+80);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.25 animations:^{
            self.leafImageView.center = CGPointMake(leafCenter.x+80, leafCenter.y+180);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.50 relativeDuration:0.25 animations:^{
            self.leafImageView.center = CGPointMake(leafCenter.x+180, leafCenter.y+300);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
            self.leafImageView.center = CGPointMake(leafCenter.x+270, leafCenter.y+400);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 animations:^{
           self.leafImageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
