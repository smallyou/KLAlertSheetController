//
//  KLAlertSheetCell.m
//  KLSelectedSingleView
//
//  Created by 陈华 on 16/11/13.
//  Copyright © 2016年 com.chmn123.searchbar. All rights reserved.
//

#import "KLAlertSheetCell.h"

#import "KLAlertAction.h"

@interface KLAlertSheetCell ()

@property(nonatomic,weak) UILabel *title_label;
@property(nonatomic,weak) UIView *separtor;

@end

@implementation KLAlertSheetCell

#pragma mark - 懒加载
-(UILabel *)title_label
{
    if (_title_label == nil) {
        UILabel *label = [[UILabel alloc]init];
        _title_label = label;
        _title_label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_title_label];
    }
    return _title_label;
}

-(UIView *)separtor
{
    if (_separtor == nil) {
        UIView *separtor = [[UIView alloc]init];
        _separtor = separtor;
        _separtor.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
        [self.contentView addSubview:separtor];
    }
    return _separtor;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.title_label.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 1);
    self.separtor.frame = CGRectMake(0, CGRectGetMaxY(self.title_label.frame), self.frame.size.width, 1);
}


-(void)setAction:(KLAlertAction *)action
{
    _action = action;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.title_label.text = action.title;
    if (action.textColor) {
        self.title_label.textColor = action.textColor;
    }
    
    if (action.textFont) {
        self.title_label.font = action.textFont;
    }
}



@end
