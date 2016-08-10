//
//  QGGMenuItem.h
//  QGGDraft
//
//  Created by taizi on 15/12/6.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QGGMenuItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *instruction;
@property (nonatomic, strong) NSString *target;
@property (nonatomic, assign) BOOL     isNib;

@end


@interface QGGMenuContent : NSObject
@property (nonatomic,strong) NSString *sectionTitle;
@property (nonatomic,strong) NSMutableArray<QGGMenuItem*> *menuItems;
@end