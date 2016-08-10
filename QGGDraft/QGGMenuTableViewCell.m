//
//  QGGMenuTableViewCell.m
//  QGGDraft
//
//  Created by taizi on 15/12/8.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "QGGMenuTableViewCell.h"
#import "QGGMenuItem.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation QGGMenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMenuItem:(QGGMenuItem*)menuItem {
    _menuItem = menuItem;
    self.title.text = _menuItem.title;
    self.instruction.text = _menuItem.instruction;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:@"http://f.hiphotos.baidu.com/zhidao/pic/item/1e30e924b899a901f13830bc1f950a7b0208f52f.gif"]];
}

@end
