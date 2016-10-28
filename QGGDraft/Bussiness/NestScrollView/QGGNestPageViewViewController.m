//
//  QGGNestPageViewViewController.m
//  QGGDraft
//
//  Created by taizi on 16/8/14.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "QGGNestPageViewViewController.h"
#import "QGGNestScrollViewController.h"

static CGFloat const kHeaderViewHeight = 200;

@interface QGGNestPageViewViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSArray *contentViewControllers;
@property (nonatomic, assign) NSUInteger currPageIndex;
@property (nonatomic, strong) UIScrollView *pageScrollView;
@property (nonatomic, strong) UIView *headerView;
@end

@implementation QGGNestPageViewViewController

- (void)viewDidLoad {
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [super viewDidLoad];
//    NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey:@(UIPageViewControllerSpineLocationMax)};
//    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
//    _pageViewController.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
//    _pageViewController.view.frame = self.view.bounds;
//    
//    _pageViewController.dataSource = self;
//    _pageViewController.delegate = self;
//    [_pageViewController setViewControllers:@[[self.contentViewControllers objectAtIndex:_currPageIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {}];
//    
//    [self addChildViewController:_pageViewController];
//    [self.view addSubview:_pageViewController.view];
//    [_pageViewController didMoveToParentViewController:self];
    
    
    [self.view addSubview:self.pageScrollView];
    self.pageScrollView.contentSize = CGSizeMake(self.contentViewControllers.count*CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    int i = 0;
    for (UIViewController *vc in self.contentViewControllers) {
        
        [self addChildViewController:vc];
        CGRect tempRect = self.view.bounds;
        
        [self.pageScrollView addSubview:vc.view];
        [vc didMoveToParentViewController:self];
        [self.view addSubview:self.headerView];
        tempRect.origin.x = i*CGRectGetWidth(self.view.bounds);
        vc.view.frame = tempRect;
        i++;
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / CGRectGetWidth(self.view.bounds);
    QGGNestScrollViewController *vc = self.contentViewControllers[index];
    CGRect temRect = self.headerView.frame;
    temRect.origin.y = 0-vc.outerScrollView.contentOffset.y;
    self.headerView.frame = temRect;
    [self addHeaderView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / CGRectGetWidth(self.view.bounds);
    QGGNestScrollViewController *vc = self.contentViewControllers[index];
//    CGRect rect = self.headerView.bounds;
//    rect.origin.y -= vc.outerScrollView.contentOffset.y;
//    self.headerView.frame = rect;
    
    CGRect temRect = self.headerView.frame;
    temRect.origin.y = 0;
    self.headerView.frame = temRect;
    
    vc.headerView = self.headerView;
    [vc addHeaderView];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self.contentViewControllers indexOfObject:viewController];
    if (index==0 || index == NSNotFound) {
        return nil;
    }
    return self.contentViewControllers[index-1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self.contentViewControllers indexOfObject:viewController];
    if (index==self.contentViewControllers.count-1 || index == NSNotFound) {
        return nil;
    }
    return self.contentViewControllers[index+1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    QGGNestScrollViewController *currVC = pageViewController.viewControllers[0];
    currVC.headerView = self.headerView;
    [self addHeaderView];
}

- (void)addHeaderView {
    [self.headerView willMoveToSuperview:self.view];
    [self.view addSubview:self.headerView];
    
    [self.headerView didMoveToSuperview];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    QGGNestScrollViewController *currVC = pageViewController.viewControllers[0];
    currVC.headerView = self.headerView;
    [currVC addHeaderView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSArray*)contentViewControllers {
    if (!_contentViewControllers) {
        
        QGGNestScrollViewController *nsvc1 = [[QGGNestScrollViewController alloc] init];
        nsvc1.headerView = self.headerView;
        nsvc1.outerScrollViewBgColor = [UIColor redColor];
        QGGNestScrollViewController *nsvc2 = [[QGGNestScrollViewController alloc] init];
        nsvc2.outerScrollViewBgColor = [UIColor purpleColor];
        nsvc2.headerView = self.headerView;
        QGGNestScrollViewController *nsvc3 = [[QGGNestScrollViewController alloc] init];
        nsvc3.outerScrollViewBgColor = [UIColor yellowColor];
        nsvc3.headerView = self.headerView;
        QGGNestScrollViewController *nsvc4 = [[QGGNestScrollViewController alloc] init];
        nsvc4.outerScrollViewBgColor = [UIColor lightGrayColor];
        nsvc4.headerView = self.headerView;
        _contentViewControllers = @[nsvc1,nsvc2,nsvc3,nsvc4];
    }
    return _contentViewControllers;
}

-(UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), kHeaderViewHeight)];
        _headerView.backgroundColor = [UIColor greenColor];
        _headerView.userInteractionEnabled = YES;
    }
    return _headerView;
}

- (UIScrollView*)pageScrollView {
    if (!_pageScrollView) {
        _pageScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _pageScrollView.pagingEnabled = YES;
        _pageScrollView.delegate = self;
    }
    return _pageScrollView;
}

@end
