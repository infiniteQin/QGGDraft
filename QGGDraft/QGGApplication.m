//
//  QGGApplication.m
//  QGGDraft
//
//  Created by taizi on 16/8/14.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "QGGApplication.h"
#import "QGGHitTestOutterScrollView.h"

@implementation QGGApplication

-(BOOL)sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event {
    return [super sendAction:action to:target from:sender forEvent:event];
}

-(void)sendEvent:(UIEvent *)event {
//    if (self.shouldSendEventBlock && !self.shouldSendEventBlock(event)) {
//        [super sendEvent:nil];
//        return;
//    }
//    NSLog(@"send event");
    BOOL flag = YES;
    if (self.shouldSendEventBlock) {
        flag = self.shouldSendEventBlock(event);
    }
    if (!flag) {
        return;
    }
    [super sendEvent:event];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    NSLog(@"===touch moved==");
}


//- (BOOL)isIgnoringInteractionEvents {
//    BOOL flag = [super isIgnoringInteractionEvents];
//    if (!flag) {
////        NSLog(@"isIgnoring");
//        return YES;
//    }
//    return flag;
//}

@end
