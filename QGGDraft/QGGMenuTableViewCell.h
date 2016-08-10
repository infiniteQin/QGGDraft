//
//  QGGMenuTableViewCell.h
//  QGGDraft
//
//  Created by taizi on 15/12/8.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QGGMenuItem;
#define kQGGMenuTableViewCellIdentify @"QGGMenuTableViewCell"

@interface QGGMenuTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *instruction;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (nonatomic, strong) QGGMenuItem *menuItem;

@end
