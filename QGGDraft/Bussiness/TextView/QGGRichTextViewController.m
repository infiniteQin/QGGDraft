//
//  QGGRichTextViewController.m
//  QGGDraft
//
//  Created by taizi on 16/6/20.
//  Copyright © 2016年 Qingg. All rights reserved.
//

#import "QGGRichTextViewController.h"
#import "QGGTextAttachment.h"

@interface QGGRichTextViewController ()
@property (weak, nonatomic) IBOutlet UILabel *custLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation QGGRichTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    // Do any additional setup after loading the view from its nib.
    NSMutableAttributedString *mutableAttrStr = [[NSMutableAttributedString alloc] initWithString:@"中文版车上飞机上的控件辐克里斯朵夫肌肤的伤口附近" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blueColor]}];
    
    NSTextAttachment *attachment = [[QGGTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"bg_tree"];
    attachment.bounds = CGRectMake(0, 0, 320, 100);
    NSAttributedString *attrStr = [NSAttributedString attributedStringWithAttachment:attachment];
    
    [mutableAttrStr insertAttributedString:attrStr atIndex:3];
//    [mutableAttrStr insertAttributedString:attrStr atIndex:3];
    self.textView.attributedText = mutableAttrStr;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
