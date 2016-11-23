//
//  KLAlertAction.h
//  KLSelectedSingleView
//
//  Created by 陈华 on 16/11/13.
//  Copyright © 2016年 com.chmn123.searchbar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KLAlertAction;

typedef void(^OptionAction)(KLAlertAction *);

typedef NS_ENUM(NSInteger,KLAlertActionType) {
    KLAlertActionTypeDefalt = 0, //默认类型
    KLAlertActionTypeControl = 1 //控制类型
};

@interface KLAlertAction : NSObject
/**选项标题*/
@property(nonatomic,copy) NSString *title;
/**文字颜色*/
@property(nonatomic,strong) UIColor *textColor;
/**文字字体*/
@property(nonatomic,strong) UIFont *textFont;
/**点击后的回调*/
@property(nonatomic,copy) OptionAction option;
/**action的类型*/
@property(nonatomic,assign) KLAlertActionType type;

+(instancetype)actionWithType:(KLAlertActionType)type textColor:(UIColor *)color textFont:(UIFont *)font title:(NSString *)title option:(OptionAction)option;

@end
