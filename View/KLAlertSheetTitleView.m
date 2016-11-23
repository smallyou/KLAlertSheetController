//
//  KLAlertSheetTitleView.m
//  KLSelectedSingleView
//
//  Created by 陈华 on 16/11/13.
//  Copyright © 2016年 com.chmn123.searchbar. All rights reserved.
//

#import "KLAlertSheetTitleView.h"
#import <UIKit/UIKit.h>

@interface KLAlertSheetTitleView()

@property(nonatomic,weak) UILabel *titleLabel;
@property(nonatomic,weak) UILabel *messageLabel;
@property(nonatomic,weak) UIView  *separtor;

@end

@implementation KLAlertSheetTitleView
{
    UIFont *_titleFont;
    UIFont *_messageFont;
    UIColor *_titleColor;
    UIColor *_messageColor;
}


#pragma mark - 懒加载
-(UIView *)separtor
{
    if (_separtor == nil) {
        UIView *separtor = [[UIView alloc]init];
        _separtor = separtor;
        _separtor.backgroundColor = [UIColor redColor];
        [self addSubview:separtor];
    }
    return _separtor;

}



+(instancetype)titleViewWithTitle:(NSString *)title message:(NSString *)message
{
    return [[self alloc]initWithTitle:title message:message];
}

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    if (self = [super init]) {
        
        /**初始化*/
        _titleFont = [UIFont systemFontOfSize:16.0];
        _messageFont = [UIFont systemFontOfSize:14.0];
        _titleColor = [UIColor blackColor];
        _messageColor = [UIColor blackColor];

        
        if (title.length) {
            UILabel *titleLabel = [[UILabel alloc]init];
            titleLabel.text = title;
            titleLabel.textColor = _titleColor;
            titleLabel.font = _titleFont;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:titleLabel];
            self.titleLabel = titleLabel;
        }
        
        if (message.length) {
            UILabel *messageLabel = [[UILabel alloc]init];
            messageLabel.text = message;
            messageLabel.textColor = _messageColor;
            messageLabel.font = _messageFont;
            messageLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:messageLabel];
            self.messageLabel = messageLabel;
        }
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat y = 0;
    if (self.titleLabel) {
        CGSize size = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:_titleFont}];
        self.titleLabel.frame = CGRectMake(0, 10, self.frame.size.width, size.height);
        y = size.height + 10;
    }
    if (self.messageLabel) {
        CGSize size = [self.messageLabel.text sizeWithAttributes:@{NSFontAttributeName:_messageFont}];
        self.messageLabel.frame = CGRectMake(0, y, self.frame.size.width, size.height);
        y = y + size.height + 10;
    }
    
    self.separtor.frame = CGRectMake(0, y, self.frame.size.width, 1);
}



@end
