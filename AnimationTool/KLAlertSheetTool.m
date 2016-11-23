//
//  KLAlertSheetTool.m
//  KLSelectedSingleView
//
//  Created by 陈华 on 16/11/13.
//  Copyright © 2016年 com.chmn123.searchbar. All rights reserved.
//

#import "KLAlertSheetTool.h"
#import "KLASPresentationController.h"

@interface KLAlertSheetTool ()

@property(nonatomic,assign) BOOL isPresented; //标记当前是否为显示的动画

@end


@implementation KLAlertSheetTool
-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    KLASPresentationController *vc = [[KLASPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    vc.presentedRect = self.presentedRect;
    return vc;
}




/**重写，用来设置显示动画*/
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.isPresented = YES;
    return self;
}

/**重写，用来设置消失动画*/
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.isPresented = NO;
    return self;
}


#pragma mark - UIViewControllerAnimatedTransitioning

/**设置动画事件*/
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

/**设置动画*/
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.isPresented ? [self setupPresentedAnimation:transitionContext] : [self setupDismissedAnimation:transitionContext];
}

#pragma mark - 封装具体的动画
/**设置显示动画的具体实现过程*/
-(void)setupPresentedAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //1 获取当前正要显示的presentedView
    UIView *presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    //2 将presentedView添加到containerView上
    [[transitionContext containerView] addSubview:presentedView];
    
    //3 设置动画
    presentedView.transform = CGAffineTransformMakeTranslation(0, [self.delegate heightForSingleSelectedView]);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        presentedView.transform = CGAffineTransformIdentity;
        
        
    } completion:^(BOOL finished) {
        //告诉上下文，动画结束
        [transitionContext completeTransition:YES];
    }];
    
}

/**设置消失动画的具体实现过程*/
-(void)setupDismissedAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //1 获取当前正要显示的presentedView
    UIView *dismissedView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    //2 将dismissedView添加到containerView上
    [[transitionContext containerView] addSubview:dismissedView];
    
    //3 设置动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        dismissedView.transform = CGAffineTransformMakeTranslation(0, [self.delegate heightForSingleSelectedView]);
        
    } completion:^(BOOL finished) {
        
        //移除dismissedView
        [dismissedView removeFromSuperview];
        //告诉上下文，动画结束
        [transitionContext completeTransition:YES];
        
    }];
}



@end
