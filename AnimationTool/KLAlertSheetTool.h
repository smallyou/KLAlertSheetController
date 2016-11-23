//
//  KLAlertSheetTool.h
//  KLSelectedSingleView
//
//  Created by 陈华 on 16/11/13.
//  Copyright © 2016年 com.chmn123.searchbar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KLAlertSheetToolDelegate <NSObject>

@required
-(CGFloat)heightForSingleSelectedView;

@end


@interface KLAlertSheetTool : NSObject <UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign) CGRect presentedRect;

@property(nonatomic,assign) NSTimeInterval animationDuration;

@property(nonatomic,weak) id<KLAlertSheetToolDelegate> delegate;

@end
