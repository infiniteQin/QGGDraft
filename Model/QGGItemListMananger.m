//
//  QGGItemListMananger.m
//  QGGDraft
//
//  Created by taizi on 15/12/6.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "QGGItemListMananger.h"
#import "QGGMenuItem.h"

@implementation QGGItemListMananger

+ (instancetype) manager {
    static QGGItemListMananger *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[QGGItemListMananger alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_readMenuItems];
    }
    return self;
}

- (void)p_readMenuItems {
    dispatch_async(dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *menuItemsFilePath = [[NSBundle mainBundle] pathForResource:@"QGGMenuList" ofType:@"plist"];
        NSArray *tempArr = [NSArray arrayWithContentsOfFile:menuItemsFilePath];
        _menuItems = [[NSMutableArray alloc] initWithCapacity:[tempArr count]];
        for (NSDictionary *dic in tempArr) {
            NSArray *secList = [dic objectForKey:@"contentList"];
            NSString *secTitle = [dic objectForKey:@"sectionTitle"];
            QGGMenuContent *menuContent = [[QGGMenuContent alloc] init];
            menuContent.sectionTitle = secTitle;
            menuContent.menuItems = [NSMutableArray array];
            for (NSDictionary *inDic in secList) {
                QGGMenuItem *item = [[QGGMenuItem alloc] init];
                item.title = [inDic objectForKey:@"title"];
                item.target = [inDic objectForKey:@"target"];
                item.instruction = [inDic objectForKey:@"instruction"];
                item.isNib = [[inDic objectForKey:@"isNib"] boolValue];
                [menuContent.menuItems addObject:item];
            }
            [_menuItems addObject:menuContent];
        }
    });
}

@end
