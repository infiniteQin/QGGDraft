//
//  QGGSecondHideBarViewController.m
//  QGGDraft
//
//  Created by taizi on 16/4/22.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "QGGSecondHideBarViewController.h"
#import "QGGShowBarViewController.h"

@interface QGGSecondHideBarViewController ()

@end

@implementation QGGSecondHideBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 80, 40)];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(pushToNextVC) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)pushToNextVC {
     UIViewController *vc = [[QGGShowBarViewController alloc] init];
    vc.title = @"111111";
    [self.navigationController pushViewController:vc animated:YES];
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
