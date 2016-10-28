//
//  QGGNestScrollViewController.h
//  QGGDraft
//
//  Created by taizi on 16/8/14.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QGGNestScrollView.h"
@interface QGGNestScrollViewController : UIViewController

@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, strong) UIColor *outerScrollViewBgColor;

@property (nonatomic, strong,readonly) QGGNestScrollView *outerScrollView;
- (void)addHeaderView;
@end
