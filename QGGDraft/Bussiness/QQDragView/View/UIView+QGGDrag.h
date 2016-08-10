//
//  UIView+QGGDrag.h
//  QGGDraft
//
//  Created by taizi on 16/3/28.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^QGGDragDidEndPanGesBlock)();

@interface UIView (QGGDrag)

/**
 *  最大距离
 */
@property (nonatomic, assign) CGFloat qggDrag_maxDistance;

/**
 *  小圆初始大小
 */
@property (nonatomic, assign) CGFloat qgg_smallViewWidth;

/**
 *  手势结束block
 */
@property (nonatomic, copy)  QGGDragDidEndPanGesBlock qgg_didEndPanGesBlock;


/**
 *  设置
 */
- (void)qgg_setUp;

@end
