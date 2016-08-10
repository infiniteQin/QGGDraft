//
//  QGGAnimationsViewController.m
//  QGGDraft
//
//  Created by taizi on 16/2/23.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "QGGAnimationsViewController.h"
#import "QGGLoadingView.h"
#import "QGGGradientMaskLabel.h"
#import "QGGRectPlayAnimationView.h"
#import "QGGCircleLoadingView.h"
#import "QGGWaterLoadingView.h"

@interface QGGAnimationsViewController ()

@end

@implementation QGGAnimationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpSubViews];
}

- (void)setUpSubViews {
    self.view.backgroundColor = [UIColor lightGrayColor];
    QGGLoadingView *loadingView = [[QGGLoadingView alloc] initWithFrame:CGRectMake(20, 100, 50, 50)];
    [self.view addSubview:loadingView];
    
    QGGGradientMaskLabel *gradientMaskLabel = [[QGGGradientMaskLabel alloc] initWithFrame:CGRectMake(80, 130, 120, 20)];
    gradientMaskLabel.textColor = [UIColor whiteColor];
    gradientMaskLabel.text = @"WERTKJHGDGFDGYUI>>";
    [gradientMaskLabel sizeToFit];
    [gradientMaskLabel setUpGradientMask];
    [self.view addSubview:gradientMaskLabel];
    
    QGGRectPlayAnimationView *rectPlayAnimationView = [[QGGRectPlayAnimationView alloc] initWithFrame:CGRectMake(20,CGRectGetMaxY(loadingView.frame) +20, 200, 100)];
    [self.view addSubview:rectPlayAnimationView];
    
    QGGCircleLoadingView *circleLoadingView = [[QGGCircleLoadingView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(rectPlayAnimationView.frame) +20, 55, 55)];
    [self.view addSubview:circleLoadingView];
    
    QGGWaterLoadingView *waterLoadingView = [[QGGWaterLoadingView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(circleLoadingView.frame)+20, CGRectGetMinY(circleLoadingView.frame), 52, 94)];
//    waterLoadingView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:waterLoadingView];
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
