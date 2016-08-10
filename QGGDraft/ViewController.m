//
//  ViewController.m
//  QGGDraft
//
//  Created by taizi on 15/12/6.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "ViewController.h"
#import "QGGItemListMananger.h"
#import "QGGMenuItem.h"
#import "QGGMenuTableViewCell.h"
#import "QGGClassFactory.h"
//#import <YYWebImage.h>
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 65+16;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QGGMenuTableViewCell class]) bundle:nil] forCellReuseIdentifier:kQGGMenuTableViewCellIdentify];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    QGGMenuContent *menuContent = (QGGMenuContent *)[QGGItemListMananger manager].menuItems[section];
    return [menuContent.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QGGMenuContent *menuContent = (QGGMenuContent *)[QGGItemListMananger manager].menuItems[indexPath.section];
    QGGMenuItem *item = menuContent.menuItems[indexPath.row];
    QGGMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kQGGMenuTableViewCellIdentify forIndexPath:indexPath];

    cell.menuItem = item;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithRed:224.0/255 green:224.0/255 blue:238.0/255 alpha:1.];;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 120, 20)];
    label.font = [UIFont systemFontOfSize:12.];
    QGGMenuContent *menuContent = (QGGMenuContent *)[QGGItemListMananger manager].menuItems[section];
    label.text = menuContent.sectionTitle;
    [headerView addSubview:label];
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[QGGItemListMananger manager].menuItems count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    });
    QGGMenuContent *menuContent = (QGGMenuContent *)[QGGItemListMananger manager].menuItems[indexPath.section];
    QGGMenuItem *item = menuContent.menuItems[indexPath.row];
    if (item.isNib) {
        UIViewController *targetVC = [QGGClassFactory instaneWithVCName:item.target];
        [self.navigationController pushViewController:targetVC animated:YES];
    }else {
        UIViewController *targetVC = [QGGClassFactory instanceWithClassName:item.target];
        [self.navigationController pushViewController:targetVC animated:YES];
    }
    
}

@end
