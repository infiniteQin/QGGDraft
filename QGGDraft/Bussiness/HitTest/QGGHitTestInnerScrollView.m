//
//  QGGHitTestInnerScrollView.m
//  QGGDraft
//
//  Created by taizi on 16/8/19.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "QGGHitTestInnerScrollView.h"

@implementation QGGHitTestInnerScrollView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.outerScrollView.contentOffset.y<20 && self.contentOffset.y < 0) {
        return nil;
    }
    return self;
}

- (UIResponder *)nextResponder {
    return [super nextResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
