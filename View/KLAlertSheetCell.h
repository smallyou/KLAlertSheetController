//
//  KLAlertSheetCell.h
//  KLSelectedSingleView
//
//  Created by 陈华 on 16/11/13.
//  Copyright © 2016年 com.chmn123.searchbar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KLAlertAction;

@interface KLAlertSheetCell : UITableViewCell

@property(nonatomic,strong) KLAlertAction *action;

@end
