//
//  QGGQQDragViewController.m
//  QGGDraft
//
//  Created by taizi on 16/3/28.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "QGGQQDragViewController.h"
#import "UIView+QGGDrag.h"

@interface QGGQQDragViewController ()
@property (nonatomic, retain) NSMutableArray<UIImage*>* images;
@end

@implementation QGGQQDragViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    view.center = self.view.center;
    view.backgroundColor = [UIColor redColor];
    view.qggDrag_maxDistance = 150;
    [view qgg_setUp];
    __block typeof(view) w_view = view;
    __weak typeof(self) wSelf = self;
    view.qgg_didEndPanGesBlock = ^(){
        [wSelf startBlowUpAnimations:w_view.frame];
        [w_view removeFromSuperview];
        w_view = nil;
    };
    [self.view addSubview:view];
    view.userInteractionEnabled = YES;
    view.font = [UIFont systemFontOfSize:10.];
    view.text = @"99+";
    view.textColor = [UIColor whiteColor];
    view.textAlignment = NSTextAlignmentCenter;
}

- (void)startBlowUpAnimations:(CGRect)rect
{
    UIImageView *ainmImageView = [[UIImageView alloc] initWithFrame:rect];
    ainmImageView.animationImages = self.images;
    ainmImageView.animationRepeatCount = 1;
    ainmImageView.animationDuration = 0.5;
    [ainmImageView startAnimating];
    [self.view addSubview:ainmImageView];
}

-(NSMutableArray<UIImage *> *)images {
    if (!_images) {
        _images = [NSMutableArray arrayWithCapacity:3];
        for (int i = 0; i<5; i++) {
            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"unreadBomb_%d",i+1]];
            if (img) {
                [_images addObject:img];
            }
        }
    }
    return _images;
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
