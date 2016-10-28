//
//  QGGHitTestViewController.m
//  QGGDraft
//
//  Created by taizi on 16/8/19.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "QGGHitTestViewController.h"
#import "QGGHitTestInnerScrollView.h"
#import "QGGHitTestOutterScrollView.h"
#import <Masonry/Masonry.h>
#import "QGGApplication.h"

static CGFloat const kHeaderHeight = 200;

static CGFloat const kTotalContentHeight = 1200;

@interface QGGHitTestViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) QGGHitTestOutterScrollView *outterScrollView;
@property (nonatomic, strong) QGGHitTestInnerScrollView  *innerScrollView;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation QGGHitTestViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"timer block");
    }];
    {// outter Scroll View
        [self.view addSubview:self.outterScrollView];
        [self.outterScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        self.outterScrollView.contentSize = self.view.bounds.size;
    }
    
    {
        [self.outterScrollView addSubview:self.innerScrollView];
        __weak typeof(self) wSelf = self;
        [self.innerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(wSelf.view).offset(kHeaderHeight);
            make.right.left.bottom.mas_equalTo(wSelf.view).offset(0);
        }];
        self.innerScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), kTotalContentHeight-kHeaderHeight);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (QGGHitTestInnerScrollView*)innerScrollView {
    if (!_innerScrollView) {
        _innerScrollView = [[QGGHitTestInnerScrollView alloc] init];
        _innerScrollView.backgroundColor = [UIColor purpleColor];
    }
    return _innerScrollView;
}

- (QGGHitTestOutterScrollView *)outterScrollView {
    if (!_outterScrollView) {
        _outterScrollView = [[QGGHitTestOutterScrollView alloc] init];
        _outterScrollView.backgroundColor = [UIColor lightGrayColor];
        _outterScrollView.delegate = self;
    }
    return _outterScrollView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y>20) {
//        self.outterScrollView.scrollEnabled = NO;
//        
//        [self.outterScrollView.panGestureRecognizer removeTarget:self.outterScrollView action:@selector(_updatePanGesture)];
////        self.outterScrollView.panGestureRecognizer.state = UIGestureRecognizerStateFailed;
//        [self.outterScrollView.panGestureRecognizer setValue:@(UIGestureRecognizerStateFailed) forKey:@"state"];
//        [self.outterScrollView.panGestureRecognizer setValue:self.innerScrollView forKey:@"view"];
//        [self.outterScrollView.panGestureRecognizer addTarget:self.innerScrollView action:@selector(_updatePanGesture)];
//        NSLog(@"view did Scroll");
//        QGGApplication *app = (QGGApplication*)[QGGApplication sharedApplication];
//        __weak typeof(self) wSelf = self;
//        app.shouldSendEventBlock = ^(UIEvent *event) {
//            for (UITouch *touch in event.allTouches) {
//                NSLog(@"%@",NSStringFromClass([touch.view class]));
//                if ([touch.view isKindOfClass:[QGGHitTestOutterScrollView class]] && touch.gestureRecognizers) {
//                    if (wSelf.innerScrollView) {
//                        [touch setValue:[@[self.innerScrollView.panGestureRecognizer] mutableCopy] forKey:@"gestureRecognizers"];
//                        [touch setValue:self.innerScrollView forKey:@"view"];
////                        return NO;
//                    }
//                    else{
//                        return NO;
//                    }
//                }
//            }
//            return YES;
//        };
    }else {
        
    }
}

-(void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

@end
