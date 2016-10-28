//
//  QGGWindow.m
//  QGGDraft
//
//  Created by taizi on 16/8/19.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "QGGWindow.h"

@implementation QGGWindow

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"window hit Test");
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
