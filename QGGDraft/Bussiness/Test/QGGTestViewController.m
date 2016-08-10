//
//  QGGTestViewController.m
//  QGGDraft
//
//  Created by taizi on 15/12/8.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "QGGTestViewController.h"

@interface QGGTestViewController ()

@end

@implementation QGGTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);//dispatch_queue_create("hk.xiangqu.www", DISPATCH_CURRENT_QUEUE_LABEL);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group,dispatchQueue, ^{
        for (int i = 0 ; i < 200; i++) {
            NSLog(@"111111");
        }
    });
    
    dispatch_group_async(group, dispatchQueue, ^{
        for (int i = 0 ; i < 20; i++) {
            NSLog(@"222222");
        }
    });
    
    dispatch_group_async(group, dispatchQueue, ^{
        for (int i = 0 ; i < 20; i++) {
            NSLog(@"5555555");
        }
    });
    dispatch_group_async(group, dispatchQueue, ^{
        for (int i = 0 ; i < 20; i++) {
            NSLog(@"666666");
        }
    });
    dispatch_group_notify(group, dispatchQueue, ^{
        NSLog(@"333333333");
    });
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(dispatchQueue, ^{
//        dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);
        
        for (int i = 0 ; i < 200; i++) {
            NSLog(@"aaaaaa");
        }
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_async(dispatchQueue, ^{
        dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);
        for (int i = 0 ; i < 200; i++) {
            NSLog(@"bbbbbbb");
        }
        dispatch_semaphore_signal(semaphore);
    });
    
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
