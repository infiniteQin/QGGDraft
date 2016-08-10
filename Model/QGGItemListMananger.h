//
//  QGGItemListMananger.h
//  QGGDraft
//
//  Created by taizi on 15/12/6.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QGGMenuContent;

@interface QGGItemListMananger : NSObject
@property (nonatomic,strong,readonly) NSMutableArray<QGGMenuContent*> *menuItems;
+ (instancetype)manager;
@end
