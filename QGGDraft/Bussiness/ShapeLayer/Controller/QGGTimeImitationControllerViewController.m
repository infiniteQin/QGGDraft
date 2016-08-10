//
//  QGGTimeImitationControllerViewController.m
//  QGGDraft
//
//  Created by taizi on 16/4/11.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "QGGTimeImitationControllerViewController.h"
#import "TimeImitationView.h"

@interface QGGTimeImitationControllerViewController ()

@end

@implementation QGGTimeImitationControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"仿时光网";
    TimeImitationView *timeImitationView = [[TimeImitationView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 300)];
    timeImitationView.footerLayerHeight = 70;
    timeImitationView.footerBackgroundColor = [UIColor whiteColor];
    timeImitationView.backgroundColor = [UIColor whiteColor];
    timeImitationView.image = [UIImage imageNamed:@"bg_tree"];
    [self.view addSubview:timeImitationView];
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
