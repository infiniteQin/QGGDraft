//
//  QGGNestScrollViewController.m
//  QGGDraft
//
//  Created by taizi on 16/8/14.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "QGGNestScrollViewController.h"
#import "QGGNestScrollView.h"
#import "QGGApplication.h"

static CGFloat const kHeaderViewHeight = 200;
static NSString * const kScrollContentOffsetChangeNotify = @"ScrollContentOffsetChangeNotify";

@interface QGGNestScrollViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) QGGNestScrollView *outerScrollView;
@property (nonatomic, strong) QGGNestScrollView *innerScrollView;



@end

@implementation QGGNestScrollViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollContentOffset:) name:kScrollContentOffsetChangeNotify object:nil];
    }
    return self;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)changeScrollContentOffset:(NSNotification*)nofity {
    UIScrollView *scrollView = nofity.object;
    if (scrollView != self.outerScrollView) {
        self.outerScrollView.contentOffset = scrollView.contentOffset;
    }
}

- (void)viewDidLoad {
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [super viewDidLoad];
    
    [self.view addSubview:self.outerScrollView];
//    [self.outerScrollView addSubview:self.innerScrollView];
    
//    UIGestureRecognizer
    
}




- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static CGFloat dragY = 0;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"will begin drag");
//    dragY = scrollView.contentOffset.y;
    [self addHeaderView];
}

- (void)addHeaderView {
    [self.headerView willMoveToSuperview:self.outerScrollView];
    [self.outerScrollView insertSubview:self.headerView aboveSubview:self.outerScrollView.subviews[0]];
    [self.headerView didMoveToSuperview];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    if (scrollView == self.outerScrollView) {
////        if (scrollView.contentOffset.y<=kHeaderViewHeight) {
////            self.outerScrollView.contentOffset = scrollView.contentOffset;
//    if (scrollView.contentOffset.y>=0) {
////        CGRect temRect = self.headerView.frame;
////        temRect.origin.y = 0-scrollView.contentOffset.y;
////        self.headerView.frame = temRect;
//    }else {
//        CGRect temRect = self.headerView.frame;
//        temRect.origin.y = 0;
//        self.headerView.frame = temRect;
//    }
//    NSNotification *notify = [NSNotification alloc] initWithName:kScrollContentOffsetChangeNotify object:scrollView userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kScrollContentOffsetChangeNotify object:scrollView];
    
//    }
    
//    self.outerScrollView.contentOffset = scrollView.contentOffset;
//    if (scrollView.contentOffset.y<=0) {
//        UIEdgeInsets contentInset = self.innerScrollView.contentInset;
//        contentInset.top = scrollView.contentOffset.y;
//        self.innerScrollView.contentInset = contentInset;
//    }
//    if (scrollView == self.innerScrollView) {
//        [self.outerScrollView setContentOffset:CGPointMake(0, (self.outerScrollView.contentOffset.y - scrollView.contentOffset.y - dragY))];
//        
//        if (scrollView.contentOffset.y>20) {
    
//            self.innerScrollView.shouldTouchBegin = NO;
//            self.innerScrollView.shouldTouchBegin = YES;
////            self.innerScrollView.panGestureRecognizer.enabled = NO;
//            [self.innerScrollView.panGestureRecognizer removeTarget:self.innerScrollView action:@selector(handlePan:)];
//            [self.innerScrollView.panGestureRecognizer addTarget:self.outerScrollView action:@selector(handlePan:)];
//            [self.innerScrollView resignFirstResponder];
//            self.innerScrollView.panGestureRecognizer.enabled = NO;
//            [self.outerScrollView becomeFirstResponder];
////            self.outerScrollView.nextResponder = self.outerScrollView;
//            self.outerScrollView.panGestureRecognizer.enabled = YES;
//            ((QGGApplication*)[QGGApplication sharedApplication]).shouldSendEventBlock = ^(UIEvent *event){
//                return NO;
//            };
//            
//            ((QGGApplication*)[QGGApplication sharedApplication]).shouldSendEventBlock = ^(UIEvent *event){
//                return YES;
//            };
//            self.innerScrollView.canScroll = NO;
//            [UIApplication sharedApplication] sendAction:<#(nonnull SEL)#> to:<#(nullable id)#> from:<#(nullable id)#> forEvent:(nullable UIEvent *)
//            NSLog(@"become firstRes");
//            [self.innerScrollView removeGestureRecognizer:self.innerScrollView.panGestureRecognizer];
//        }
//    }
//    if (scrollView == self.outerScrollView) {
//        
//    }
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    [self.headerView willMoveToSuperview:self.view];
//    [self.view insertSubview:self.headerView aboveSubview:self.outerScrollView];
//    [self.headerView didMoveToSuperview];
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    [self.headerView willMoveToSuperview:self.view];
//    [self.view insertSubview:self.headerView aboveSubview:self.outerScrollView];
//    [self.headerView didMoveToSuperview];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (QGGNestScrollView *)outerScrollView {
    if (!_outerScrollView) {
        _outerScrollView = [[QGGNestScrollView alloc] initWithFrame:self.view.bounds];
        _outerScrollView.backgroundColor = self.outerScrollViewBgColor;
        _outerScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)+kHeaderViewHeight);
        _outerScrollView.delegate = self;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        view.backgroundColor = [UIColor whiteColor];
        [_outerScrollView addSubview:view];
//        _outerScrollView.scrollEnabled = NO;
//        _outerScrollView.panGestureRecognizer
    }
    return _outerScrollView;
}

- (QGGNestScrollView *)innerScrollView {
    if (!_innerScrollView) {
        CGRect tempRect = self.view.bounds;
        tempRect.origin.y = kHeaderViewHeight;
        _innerScrollView = [[QGGNestScrollView alloc] initWithFrame:tempRect];
        _innerScrollView.backgroundColor = [UIColor blueColor];
        _innerScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 800);
        _innerScrollView.delegate = self;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        view.backgroundColor = [UIColor lightGrayColor];
        [_innerScrollView addSubview:view];
        
    }
    return _innerScrollView;
}

@end
