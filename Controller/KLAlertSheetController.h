//
//  KLAlertSheetController.h
//  KLSelectedSingleView
//
//  Created by 陈华 on 16/11/13.
//  Copyright © 2016年 com.chmn123.searchbar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLAlertAction.h"


@interface KLAlertSheetController : UIViewController


+(instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message;

-(void)addAction:(KLAlertAction *)action;

@end
