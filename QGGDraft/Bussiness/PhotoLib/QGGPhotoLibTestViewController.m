//
//  QGGPhotoLibTestViewController.m
//  QGGDraft
//
//  Created by taizi on 15/12/24.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "QGGPhotoLibTestViewController.h"
#import <Masonry.h>
#import "QGGImagePicker.h"
#import <MBProgressHUD.h>

@interface QGGPhotoLibTestViewController ()
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation QGGPhotoLibTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [self.view addSubview:btn];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12.];
    [btn setTitle:@"选择" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showPhotos) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    //
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    
}

- (void)showPhotos {
//    __weak typeof(self) wSelf = self;
    QGGImagePicker *imagePicker = [QGGImagePicker imagePickerWithRootView:self didFinishPick:^(NSArray<ALAsset *> *assets) {
        NSLog(@"完成选择");
    } cancelPickBlock:^{
        NSLog(@"取消选择");
    } overMaxSelectNumBlock:^(UIViewController *currVC, NSInteger maxSelectNum) {
        __block MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:currVC.view];
        [currVC.view addSubview:hud];
        
        hud.labelText = [NSString stringWithFormat:@"选择数量不能超过%lu",maxSelectNum];
        hud.mode = MBProgressHUDModeText;
        [hud showAnimated:YES whileExecutingBlock:^{
            sleep(1);
        } completionBlock:^{
            [hud removeFromSuperview];

            hud = nil;
        }];
    }];
    [imagePicker showDefaultImageLab];
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
