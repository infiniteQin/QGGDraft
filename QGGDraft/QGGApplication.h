//
//  QGGApplication.h
//  QGGDraft
//
//  Created by taizi on 16/8/14.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL (^ShouldSendEventBlock)(UIEvent *event);

@interface QGGApplication : UIApplication

@property (nonatomic, copy) ShouldSendEventBlock shouldSendEventBlock;

@end
