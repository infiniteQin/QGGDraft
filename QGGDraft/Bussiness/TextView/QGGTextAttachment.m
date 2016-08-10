//
//  QGGTextAttachment.m
//  QGGDraft
//
//  Created by taizi on 16/6/20.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "QGGTextAttachment.h"

@implementation QGGTextAttachment

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex {
    
    return [super attachmentBoundsForTextContainer:textContainer proposedLineFragment:lineFrag glyphPosition:position characterIndex:charIndex];
}

@end
