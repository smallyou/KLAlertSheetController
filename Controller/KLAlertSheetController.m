//
//  KLAlertSheetController.m
//  KLSelectedSingleView
//
//  Created by 陈华 on 16/11/13.
//  Copyright © 2016年 com.chmn123.searchbar. All rights reserved.
//

#import "KLAlertSheetController.h"
#import <Masonry.h>

#import "KLAlertSheetTitleView.h"
#import "KLAlertSheetCell.h"

#import "KLAlertSheetTool.h"

#define KLSheetCellHeight 50


@interface KLAlertSheetController () <UITableViewDataSource,UITableViewDelegate,KLAlertSheetToolDelegate>

@property(nonatomic,weak) UITableView *infoView; //信息展示view
@property(nonatomic,weak) UITableView *controlView; //控制View

@property(nonatomic,copy) NSString *alertTitle;
@property(nonatomic,copy) NSString *alertMessage;

@property(nonatomic,strong) NSMutableArray *InfoActions;
@property(nonatomic,strong) NSMutableArray *controlActions;

@property(nonatomic,assign) CGFloat titleViewHeight;
@property(nonatomic,assign) CGFloat singleSelectedViewHeight;
@property(nonatomic,strong) KLAlertSheetTool *tool;

@end


@implementation KLAlertSheetController

static NSString *const ID = @"info";

#pragma mark - 懒加载
-(UITableView *)infoView
{
    if (_infoView == nil) {
        UITableView *infoView = [[UITableView alloc]init];
        [self.view addSubview:infoView];
        _infoView = infoView;
        _infoView.dataSource = self;
        _infoView.delegate = self;
        _infoView.tag = 0;
        infoView.backgroundColor = [UIColor whiteColor];
        infoView.layer.cornerRadius = 5;
        infoView.layer.masksToBounds = YES;
        infoView.bounces = NO;
        infoView.rowHeight = KLSheetCellHeight;
    }
    return _infoView;
}

-(UITableView *)controlView
{
    if (_controlView == nil) {
        UITableView *controlView = [[UITableView alloc]init];
        [self.view addSubview:controlView];
        _controlView = controlView;
        _controlView.tag = 1;
        _controlView.delegate = self;
        _controlView.dataSource = self;
        controlView.backgroundColor = [UIColor whiteColor];
        controlView.layer.cornerRadius = 5;
        controlView.layer.masksToBounds = YES;
        controlView.bounces = NO;
        controlView.rowHeight = KLSheetCellHeight;
    }
    return _controlView;
}

-(NSMutableArray *)InfoActions
{
    if (_InfoActions == nil) {
        _InfoActions = [NSMutableArray array];
    }
    return _InfoActions;
}

-(NSMutableArray *)controlActions
{
    if (_controlActions == nil) {
        _controlActions = [NSMutableArray array];
    }
    return _controlActions;
}

-(KLAlertSheetTool *)tool
{
    if (_tool == nil) {
        _tool = [[KLAlertSheetTool alloc]init];
        _tool.delegate = self;
    }
    return _tool;
}



+(instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message
{
    return [[self alloc]initWithTitle:title message:message];
}


-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    if (self = [super init]) {
        
        //设置属性
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self.tool;
        
        self.alertTitle = title;
        self.alertMessage = message;
        
        //添加约束
        [self.controlView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).offset(20);
            make.right.mas_equalTo(self.view.mas_right).offset(-20);
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
            make.height.mas_equalTo(0);
        }];
        
        [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).offset(20);
            make.right.mas_equalTo(self.view.mas_right).offset(-20);
            make.bottom.mas_equalTo(self.controlView.mas_top).offset(-10);
        }];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    KLAlertSheetTitleView *titleView = [KLAlertSheetTitleView titleViewWithTitle:self.alertTitle message:self.alertMessage];
    CGFloat height = 0;
    if (self.alertTitle.length) {
        CGSize size = [self.alertTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]}];
        height = height + size.height + 10;
    }
    if (self.alertMessage.length) {
         CGSize size = [self.alertMessage sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
        height = height + size.height + 10;
    }
    if (height) {
        titleView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
        self.infoView.tableHeaderView = titleView;
    }
    self.titleViewHeight = height;
}



#pragma mark - 数据
-(void)addAction:(KLAlertAction *)action
{
    if (action.type == KLAlertActionTypeDefalt) {
        [self.InfoActions addObject:action];
    }else{
        [self.controlActions addObject:action];
    }
    
    
    //刷新数据
    [self reloadData];
}

-(void)reloadData
{
    self.singleSelectedViewHeight = KLSheetCellHeight * (self.InfoActions.count + self.controlActions.count) + 20 + self.titleViewHeight;
    
    [self.infoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.InfoActions.count * KLSheetCellHeight + self.titleViewHeight);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.bottom.mas_equalTo(self.controlView.mas_top).offset(-10);
    }];
    [self.infoView reloadData];
    
    if (self.controlActions.count) {
        [self.controlView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.controlActions.count * KLSheetCellHeight);
        }];
    }
    [self.controlView reloadData];
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 0) {
        return self.InfoActions.count;
    }else{
        return self.controlActions.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    KLAlertSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[KLAlertSheetCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    //取出，模型
    KLAlertAction *action = tableView.tag == 0?self.InfoActions[indexPath.row] : self.controlActions[indexPath.row];
    //赋值
    cell.action = action;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出模型
    KLAlertAction *action = tableView.tag == 0?self.InfoActions[indexPath.row]:self.controlActions[indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (action.option) {
        action.option(action);
    }
}

#pragma mark - KLAlertSheetToolDelegate
-(CGFloat)heightForSingleSelectedView
{
    return self.singleSelectedViewHeight;
}


@end
