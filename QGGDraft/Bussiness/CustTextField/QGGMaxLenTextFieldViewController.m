//
//  QGGMaxLenTextFieldViewController.m
//  QGGDraft
//
//  Created by taizi on 15/12/8.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "QGGMaxLenTextFieldViewController.h"
#import "QGGTextField.h"

@interface QGGMaxLenTextFieldViewController ()

@end

@implementation QGGMaxLenTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    QGGTextField *textField = [[QGGTextField alloc] initWithFrame:CGRectMake(8, 100, 200, 30)];
    textField.backgroundColor = [UIColor lightGrayColor];
    textField.maxLength = 5;
    textField.placeholder = [NSString stringWithFormat:@"输入最大长度为%tu",textField.maxLength];
    [self.view addSubview:textField];
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
