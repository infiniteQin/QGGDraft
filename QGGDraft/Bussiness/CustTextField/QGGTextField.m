//
//  QGGTextField.m
//  QGGDraft
//
//  Created by taizi on 15/12/8.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "QGGTextField.h"

@implementation QGGTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

-(void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)textFiledEditChanged:(NSNotification*)notify {
    if(_maxLength>0){
        NSString *toBeString = self.text;
        NSString *lang = [[self textInputMode] primaryLanguage]; // 键盘输入模式
        if ([lang isEqualToString:@"zh-Hans"] || [lang isEqualToString:@"zh-Hant"]) { // 简体中文输入，包括简体/繁体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [self markedTextRange];
            //获取高亮部分
            UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                if (toBeString.length > _maxLength) {
                    self.text = [toBeString substringToIndex:_maxLength];
                }
            }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            else{
                
            }
        }
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        else{
            if (toBeString.length > _maxLength) {
                self.text = [toBeString substringToIndex:_maxLength];
            }
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
