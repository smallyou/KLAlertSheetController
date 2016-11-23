//
//  KLAlertAction.m
//  KLSelectedSingleView
//
//  Created by 陈华 on 16/11/13.
//  Copyright © 2016年 com.chmn123.searchbar. All rights reserved.
//

#import "KLAlertAction.h"

@implementation KLAlertAction

+(instancetype)actionWithType:(KLAlertActionType)type textColor:(UIColor *)color textFont:(UIFont *)font title:(NSString *)title option:(OptionAction)option;
{
    KLAlertAction *action = [[self alloc]init];
    action.title  = title;
    action.type = type;
    action.textColor = color;
    action.textFont = font;
    action.option = option;
    return action;
}

@end
