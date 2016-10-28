//
//  QGGNestScrollView.m
//  QGGDraft
//
//  Created by taizi on 16/8/14.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "QGGNestScrollView.h"

@interface QGGNestScrollView ()

@end

@implementation QGGNestScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    NSLog(@"%@",gestureRecognizer);
//    if (gestureRecognizer == self.panGestureRecognizer) {
//        CGPoint point = [gestureRecognizer locationInView:self];
//        BOOL isInView = point.y<150;
//        return isInView;
//    }
//    
////    UIApplication 
//    return NO;
//}

- (BOOL)canPerformAction:(SEL)action withSender:(nullable id)sender {
    return YES;
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    if (gestureRecognizer == self.panGestureRecognizer && _nextRespView) {
//        NSLog(@"");
//        return [self isFirstResponder];
//    }
    return self.canScroll;
}


@end
